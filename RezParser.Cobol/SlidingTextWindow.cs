// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.
// See the LICENSE file in the project root for more information.

using System;
using System.Diagnostics;
using System.Linq;
using System.Text;
using Microsoft.CodeAnalysis.Text;

namespace RezParser.Cobol
{
    /// <summary>
    /// Keeps a sliding buffer over the SourceText of a file for the lexer. Also
    /// provides the lexer with the ability to keep track of a current "lexeme"
    /// by leaving a marker and advancing ahead the offset. The lexer can then
    /// decide to "keep" the lexeme by erasing the marker, or abandon the current
    /// lexeme by moving the offset back to the marker.
    /// </summary>
    public sealed class SlidingTextWindow : IDisposable
    {
        /// <summary>
        /// In many cases, e.g. PeekChar, we need the ability to indicate that there are
        /// no characters left and we have reached the end of the stream, or some other
        /// invalid or not present character was asked for. Due to perf concerns, things
        /// like nullable or out variables are not viable. Instead we need to choose a
        /// char value which can never be legal.
        /// 
        /// In .NET, all characters are represented in 16 bits using the UTF-16 encoding.
        /// Fortunately for us, there are a variety of different bit patterns which
        /// are *not* legal UTF-16 characters. 0xffff (char.MaxValue) is one of these
        /// characters -- a legal Unicode code point, but not a legal UTF-16 bit pattern.
        /// </summary>
        public const char InvalidCharacter = char.MaxValue;

        private const int DefaultWindowLength = 2048;
        private int _basis; // Offset of the window relative to the SourceText start.
        private readonly int _textEnd; // Absolute end position

        private static readonly ObjectPool<char[]> SWindowPool = new(() => new char[DefaultWindowLength]);

        public SlidingTextWindow(SourceText text)
        {
            Text = text;
            _basis = 0;
            Offset = 0;
            _textEnd = text.Length;
            CharacterWindow = SWindowPool.Allocate();
            LexemeRelativeStart = 0;
        }

        public void Dispose()
        {
            if (CharacterWindow != null)
            {
                SWindowPool.Free(CharacterWindow);
                CharacterWindow = null;
            }
        }

        public SourceText Text { get; }

        /// <summary>
        /// The current absolute position in the text file.
        /// </summary>
        public int Position => _basis + Offset;

        public int Row => Text.Lines.First(l => Position >= l.Start &&  Position < l.EndIncludingLineBreak).LineNumber;
        public int Column => Position - Text.Lines.First(l => Position >= l.Start && Position < l.EndIncludingLineBreak).Start;

        /// <summary>
        /// The current offset inside the window (relative to the window start).
        /// </summary>
        public int Offset { get; private set; }

        /// <summary>
        /// The buffer backing the current window.
        /// </summary>
        public char[] CharacterWindow { get; private set; }

        /// <summary>
        /// Returns the start of the current lexeme relative to the window start.
        /// </summary>
        public int LexemeRelativeStart { get; private set; }

        /// <summary>
        /// Number of characters in the character window.
        /// </summary>
        public int CharacterWindowCount { get; private set; }

        /// <summary>
        /// The absolute position of the start of the current lexeme in the given
        /// SourceText.
        /// </summary>
        public int LexemeStartPosition => _basis + LexemeRelativeStart;

        /// <summary>
        /// The number of characters in the current lexeme.
        /// </summary>
        public int Width => Offset - LexemeRelativeStart;

        /// <summary>
        /// Start parsing a new lexeme.
        /// </summary>
        public void Start() => LexemeRelativeStart = Offset;

        public void Reset(int position)
        {
            // if position is within already read character range then just use what we have
            var relative = position - _basis;
            if (relative >= 0 && relative <= CharacterWindowCount)
            {
                Offset = relative;
            }
            else
            {
                // we need to reread text buffer
                var amountToRead = Math.Min(Text.Length, position + CharacterWindow.Length) - position;
                amountToRead = Math.Max(amountToRead, 0);
                if (amountToRead > 0)
                {
                    Text.CopyTo(position, CharacterWindow, 0, amountToRead);
                }

                LexemeRelativeStart = 0;
                Offset = 0;
                _basis = position;
                CharacterWindowCount = amountToRead;
            }
        }

        private bool MoreChars()
        {
            if (Offset >= CharacterWindowCount)
            {
                if (Position >= _textEnd)
                {
                    return false;
                }

                // if lexeme scanning is sufficiently into the char buffer, 
                // then refocus the window onto the lexeme
                if (LexemeRelativeStart > (CharacterWindowCount / 4))
                {
                    Array.Copy(CharacterWindow,
                        LexemeRelativeStart,
                        CharacterWindow,
                        0,
                        CharacterWindowCount - LexemeRelativeStart);
                    CharacterWindowCount -= LexemeRelativeStart;
                    Offset -= LexemeRelativeStart;
                    _basis += LexemeRelativeStart;
                    LexemeRelativeStart = 0;
                }

                if (CharacterWindowCount >= CharacterWindow.Length)
                {
                    // grow char array, since we need more contiguous space
                    var oldWindow = CharacterWindow;
                    var newWindow = new char[CharacterWindow.Length * 2];
                    Array.Copy(oldWindow, 0, newWindow, 0, CharacterWindowCount);
                    SWindowPool.ForgetTrackedObject(oldWindow, newWindow);
                    CharacterWindow = newWindow;
                }

                var amountToRead = Math.Min(_textEnd - (_basis + CharacterWindowCount),
                    CharacterWindow.Length - CharacterWindowCount);
                Text.CopyTo(_basis + CharacterWindowCount,
                    CharacterWindow,
                    CharacterWindowCount,
                    amountToRead);
                CharacterWindowCount += amountToRead;
                return amountToRead > 0;
            }

            return true;
        }

        /// <summary>
        /// After reading <see cref=" InvalidCharacter"/>, a consumer can determine
        /// if the InvalidCharacter was in the user's source or a sentinel.
        /// 
        /// Comments and string literals are allowed to contain any Unicode character.
        /// </summary>
        /// <returns></returns>
        internal bool IsReallyAtEnd() => Offset >= CharacterWindowCount && Position >= _textEnd;

        /// <summary>
        /// Advance the current position by one. No guarantee that this
        /// position is valid.
        /// </summary>
        public void AdvanceChar()
        {
            Offset++;
        }

        /// <summary>
        /// Advance the current position by n. No guarantee that this position
        /// is valid.
        /// </summary>
        public void AdvanceChar(int n) => Offset += n;

        /// <summary>
        /// Grab the next character and advance the position.
        /// </summary>
        /// <returns>
        /// The next character, <see cref="InvalidCharacter" /> if there were no characters 
        /// remaining.
        /// </returns>
        public char NextChar()
        {
            var c = PeekChar();
            if (c != InvalidCharacter)
            {
                AdvanceChar();
            }

            return c;
        }

        /// <summary>
        /// Gets the next character if there are any characters in the 
        /// SourceText. May advance the window if we are at the end.
        /// </summary>
        /// <returns>
        /// The next character if any are available. InvalidCharacter otherwise.
        /// </returns>
        public char PeekChar()
        {
            if (Offset >= CharacterWindowCount
                && !MoreChars())
            {
                return InvalidCharacter;
            }

            // N.B. MoreChars may update the offset.
            return CharacterWindow[Offset];
        }

        /// <summary>
        /// Gets the character at the given offset to the current position if
        /// the position is valid within the SourceText.
        /// </summary>
        /// <returns>
        /// The next character if any are available. InvalidCharacter otherwise.
        /// </returns>
        public char PeekChar(int delta)
        {
            var position = Position;
            AdvanceChar(delta);

            char ch;
            if (Offset >= CharacterWindowCount && !MoreChars())
            {
                ch = InvalidCharacter;
            }
            else
            {
                // N.B. MoreChars may update the offset.
                ch = CharacterWindow[Offset];
            }

            Reset(position);
            return ch;
        }

        public bool IsUnicodeEscape()
        {
            if (PeekChar() == '\\')
            {
                var ch2 = PeekChar(1);
                if (ch2 == 'U' || ch2 == 'u')
                {
                    return true;
                }
            }

            return false;
        }

        public char PeekCharOrUnicodeEscape(out char surrogateCharacter)
        {
            if (IsUnicodeEscape())
            {
                return PeekUnicodeEscape(out surrogateCharacter);
            }
            else
            {
                surrogateCharacter = InvalidCharacter;
                return PeekChar();
            }
        }

        public char PeekUnicodeEscape(out char surrogateCharacter)
        {
            var position = Position;

            // if we're peeking, then we don't want to change the position
            var ch = ScanUnicodeEscape(out surrogateCharacter);
            Reset(position);
            return ch;
        }

        public char NextCharOrUnicodeEscape(out char surrogateCharacter)
        {
            var ch = PeekChar();
            Debug.Assert(ch != InvalidCharacter,
                "Precondition established by all callers; required for correctness of AdvanceChar() call.");
            if (ch == '\\')
            {
                var ch2 = PeekChar(1);
                if (ch2 == 'U' || ch2 == 'u')
                {
                    return ScanUnicodeEscape(out surrogateCharacter);
                }
            }

            surrogateCharacter = InvalidCharacter;
            AdvanceChar();
            return ch;
        }

        public char NextUnicodeEscape(out char surrogateCharacter)
        {
            return ScanUnicodeEscape(out surrogateCharacter);
        }

        private char ScanUnicodeEscape(out char surrogateCharacter)
        {
            surrogateCharacter = InvalidCharacter;

            var character = PeekChar();
            Debug.Assert(character == '\\');
            AdvanceChar();

            character = PeekChar();
            if (character == 'U')
            {
                uint uintChar = 0;

                AdvanceChar();
                if (SyntaxFacts.IsHexDigit(PeekChar()))
                {
                    for (var i = 0; i < 8; i++)
                    {
                        character = PeekChar();
                        uintChar = (uint) ((uintChar << 4) + SyntaxFacts.HexValue(character));
                        AdvanceChar();
                    }

                    if (uintChar > 0x0010FFFF)
                    {
                    }
                    else
                    {
                        character = GetCharsFromUtf32(uintChar, out surrogateCharacter);
                    }
                }
            }
            else
            {
                Debug.Assert(character == 'u' || character == 'x');

                var intChar = 0;
                AdvanceChar();
                if (SyntaxFacts.IsHexDigit(PeekChar()))
                {
                    for (var i = 0; i < 4; i++)
                    {
                        var ch2 = PeekChar();
                        intChar = (intChar << 4) + SyntaxFacts.HexValue(ch2);
                        AdvanceChar();
                    }

                    character = (char) intChar;
                }
            }

            return character;
        }

        /// <summary>
        /// Given that the next character is an ampersand ('&amp;'), attempt to interpret the
        /// following characters as an XML entity.  On success, populate the out parameters
        /// with the low and high UTF-16 surrogates for the character represented by the
        /// entity.
        /// </summary>
        /// <param name="ch">e.g. '&lt;' for &amp;lt;.</param>
        /// <param name="surrogate">e.g. '\uDC00' for &amp;#x10000; (ch == '\uD800').</param>
        /// <returns>True if a valid XML entity was consumed.</returns>
        /// <remarks>
        /// NOTE: Always advances, even on failure.
        /// </remarks>
        public bool TryScanXmlEntity(out char ch, out char surrogate)
        {
            Debug.Assert(PeekChar() == '&');

            ch = '&';
            AdvanceChar();

            surrogate = InvalidCharacter;

            switch (PeekChar())
            {
                case 'l':
                    if (AdvanceIfMatches("lt;"))
                    {
                        ch = '<';
                        return true;
                    }

                    break;
                case 'g':
                    if (AdvanceIfMatches("gt;"))
                    {
                        ch = '>';
                        return true;
                    }

                    break;
                case 'a':
                    if (AdvanceIfMatches("amp;"))
                    {
                        ch = '&';
                        return true;
                    }
                    else if (AdvanceIfMatches("apos;"))
                    {
                        ch = '\'';
                        return true;
                    }

                    break;
                case 'q':
                    if (AdvanceIfMatches("quot;"))
                    {
                        ch = '"';
                        return true;
                    }

                    break;
                case '#':
                {
                    AdvanceChar(); //#

                    uint uintChar = 0;

                    if (AdvanceIfMatches("x"))
                    {
                        char digit;
                        while (SyntaxFacts.IsHexDigit(digit = PeekChar()))
                        {
                            AdvanceChar();

                            // disallow overflow
                            if (uintChar <= 0x7FFFFFF)
                            {
                                uintChar = (uintChar << 4) + (uint) SyntaxFacts.HexValue(digit);
                            }
                            else
                            {
                                return false;
                            }
                        }
                    }
                    else
                    {
                        char digit;
                        while (SyntaxFacts.IsDecDigit(digit = PeekChar()))
                        {
                            AdvanceChar();

                            // disallow overflow
                            if (uintChar <= 0x7FFFFFF)
                            {
                                uintChar = (uintChar << 3) + (uintChar << 1) + (uint) SyntaxFacts.DecValue(digit);
                            }
                            else
                            {
                                return false;
                            }
                        }
                    }

                    if (AdvanceIfMatches(";"))
                    {
                        ch = GetCharsFromUtf32(uintChar, out surrogate);
                        return true;
                    }

                    break;
                }
            }

            return false;
        }

        /// <summary>
        /// If the next characters in the window match the given string,
        /// then advance past those characters.  Otherwise, do nothing.
        /// </summary>
        private bool AdvanceIfMatches(string desired)
        {
            var length = desired.Length;

            for (var i = 0; i < length; i++)
            {
                if (PeekChar(i) != desired[i])
                {
                    return false;
                }
            }

            AdvanceChar(length);
            return true;
        }

        public string GetText() => GetText(LexemeStartPosition, Width);

        public string GetText(int position, int length)
        {
            var offset = position - _basis;

            // PERF: Whether interning or not, there are some frequently occurring
            // easy cases we can pick off easily.
            switch (length)
            {
                case 0:
                    return string.Empty;

                case 1:
                    if (CharacterWindow[offset] == ' ')
                    {
                        return " ";
                    }

                    if (CharacterWindow[offset] == '\n')
                    {
                        return "\n";
                    }

                    break;

                case 2:
                    var firstChar = CharacterWindow[offset];
                    if (firstChar == '\r' && CharacterWindow[offset + 1] == '\n')
                    {
                        return "\r\n";
                    }

                    if (firstChar == '/' && CharacterWindow[offset + 1] == '/')
                    {
                        return "//";
                    }

                    break;

                case 3:
                    if (CharacterWindow[offset] == '/' && CharacterWindow[offset + 1] == '/' &&
                        CharacterWindow[offset + 2] == ' ')
                    {
                        return "// ";
                    }

                    break;
            }

            return new string(CharacterWindow, offset, length);
        }

        internal static char GetCharsFromUtf32(uint codepoint, out char lowSurrogate)
        {
            if (codepoint < 0x00010000)
            {
                lowSurrogate = InvalidCharacter;
                return (char) codepoint;
            }
            else
            {
                Debug.Assert(codepoint > 0x0000FFFF && codepoint <= 0x0010FFFF);
                lowSurrogate = (char) ((codepoint - 0x00010000) % 0x0400 + 0xDC00);
                return (char) ((codepoint - 0x00010000) / 0x0400 + 0xD800);
            }
        }
    }
}