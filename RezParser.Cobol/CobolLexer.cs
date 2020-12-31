using System;
using System.Collections.Generic;
using Microsoft.CodeAnalysis.Text;

namespace RezParser.Cobol
{
    public class CobolLexer
    {
        private readonly SourceText _text;
        private readonly CobolParseOptions _options;
        public SlidingTextWindow TextWindow { get; private set; }

        public CobolLexer(SourceText text, CobolParseOptions options)
        {
            _text = text;
            _options = options;
            TextWindow = new SlidingTextWindow(_text);
        }

        public void Start() => TextWindow.Start();

        public Token Lex()
        {
            if (TextWindow.IsReallyAtEnd())
            {
                return null;
            }

            Start();

            if (TextWindow.Column == 0)
            {
                var s = "";
                s += TextWindow.NextChar();
                s += TextWindow.NextChar();
                s += TextWindow.NextChar();
                s += TextWindow.NextChar();
                s += TextWindow.NextChar();
                s += TextWindow.NextChar();
                if (TextWindow.PeekChar() == '*')
                {
                    // comment
                    while (!TextWindow.IsReallyAtEnd() && TextWindow.PeekChar() != '\r')
                    {
                        s += TextWindow.NextChar();
                    }
                }
                else
                {
                    s += TextWindow.NextChar();
                }
                return new Token()
                {
                    Value = s,
                    Start = TextWindow.LexemeStartPosition,
                    End = TextWindow.Position,
                    IsTrivia = true,
                    RowStart = TextWindow.Text.Lines.GetLinePosition(TextWindow.LexemeStartPosition).Character,
                    ColumnStart = TextWindow.Text.Lines.GetLinePosition(TextWindow.LexemeStartPosition).Character,
                    RowEnd = TextWindow.Text.Lines.GetLinePosition(TextWindow.LexemeStartPosition).Character,
                    ColumnEnd = TextWindow.Text.Lines.GetLinePosition(TextWindow.LexemeStartPosition).Character
                };
            }
            else if (TextWindow.Column == 72)
            {
                var s = "";
                s += TextWindow.NextChar();
                s += TextWindow.NextChar();
                s += TextWindow.NextChar();
                s += TextWindow.NextChar();
                s += TextWindow.NextChar();
                s += TextWindow.NextChar();
                s += TextWindow.NextChar();
                s += TextWindow.NextChar();
                return new Token()
                {
                    Value = s,
                    Start = TextWindow.LexemeStartPosition,
                    End = TextWindow.Position,
                    IsTrivia = true,
                    RowStart = TextWindow.Text.Lines.GetLinePosition(TextWindow.LexemeStartPosition).Character,
                    ColumnStart = TextWindow.Text.Lines.GetLinePosition(TextWindow.LexemeStartPosition).Character,
                    RowEnd = TextWindow.Text.Lines.GetLinePosition(TextWindow.LexemeStartPosition).Character,
                    ColumnEnd = TextWindow.Text.Lines.GetLinePosition(TextWindow.LexemeStartPosition).Character
                };

            }
            else
            {
                if (SyntaxFacts.IsWhiteSpace(TextWindow.PeekChar()))
                {
                    var trivia = ScanTrivia();
                    return new Token()
                    {
                        Value = trivia,
                        Start = TextWindow.LexemeStartPosition,
                        End = TextWindow.Position,
                        IsTrivia = true,
                        RowStart = TextWindow.Text.Lines.GetLinePosition(TextWindow.LexemeStartPosition).Character,
                        ColumnStart = TextWindow.Text.Lines.GetLinePosition(TextWindow.LexemeStartPosition).Character,
                        RowEnd = TextWindow.Text.Lines.GetLinePosition(TextWindow.LexemeStartPosition).Character,
                        ColumnEnd = TextWindow.Text.Lines.GetLinePosition(TextWindow.LexemeStartPosition).Character
                    };
                }
                else
                {
                    return ScanSyntaxToken();
                }
            }
        }

        private string ScanTrivia()
        {
            var trivia = "";
            while (!TextWindow.IsReallyAtEnd() && (SyntaxFacts.IsWhiteSpace(TextWindow.PeekChar())))
            {
                trivia += TextWindow.NextChar();
            }

            return trivia;
        }

        private Token ScanSyntaxToken()
        {
            var c = TextWindow.PeekChar();
            var s = "";
            if (c == '.')
            {
                s += TextWindow.NextChar();
                return new Token()
                {
                    Value = s,
                    Start = TextWindow.LexemeStartPosition,
                    End = TextWindow.Position,
                    IsTrivia = false,
                    RowStart = TextWindow.Text.Lines.GetLinePosition(TextWindow.LexemeStartPosition).Character,
                    ColumnStart = TextWindow.Text.Lines.GetLinePosition(TextWindow.LexemeStartPosition).Character,
                    RowEnd = TextWindow.Text.Lines.GetLinePosition(TextWindow.LexemeStartPosition).Character,
                    ColumnEnd = TextWindow.Text.Lines.GetLinePosition(TextWindow.LexemeStartPosition).Character
                };
            }

            if (c == '"')
            {
                // string!
                s += TextWindow.NextChar();
                while (TextWindow.PeekChar() != '"')
                {
                    s += TextWindow.NextChar();
                }
                s += TextWindow.NextChar();
                return new Token()
                {
                    Value = s,
                    Start = TextWindow.LexemeStartPosition,
                    End = TextWindow.Position,
                    IsTrivia = false,
                    RowStart = TextWindow.Text.Lines.GetLinePosition(TextWindow.LexemeStartPosition).Character,
                    ColumnStart = TextWindow.Text.Lines.GetLinePosition(TextWindow.LexemeStartPosition).Character,
                    RowEnd = TextWindow.Text.Lines.GetLinePosition(TextWindow.LexemeStartPosition).Character,
                    ColumnEnd = TextWindow.Text.Lines.GetLinePosition(TextWindow.LexemeStartPosition).Character
                };
            }

            while ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || c == '-' || (c >= '0' && c <= '9') || c == '=' ||
                   c == '"' || c == '*')
            {
                s += TextWindow.NextChar();
                c = TextWindow.PeekChar();
            }

            if (c == '(')
            {
                s += TextWindow.NextChar();
            }
            
            if (c == ')')
            {
                s += TextWindow.NextChar();
            }

            if (s.Length == 0)
            {
                throw new Exception("Unknown character: " + TextWindow.PeekChar());
            }
            

            return new Token()
            {
                Value = s,
                Start = TextWindow.LexemeStartPosition,
                End = TextWindow.Position,
                IsTrivia = false,
                RowStart = TextWindow.Text.Lines.GetLinePosition(TextWindow.LexemeStartPosition).Character,
                ColumnStart = TextWindow.Text.Lines.GetLinePosition(TextWindow.LexemeStartPosition).Character,
                RowEnd = TextWindow.Text.Lines.GetLinePosition(TextWindow.LexemeStartPosition).Character,
                ColumnEnd = TextWindow.Text.Lines.GetLinePosition(TextWindow.LexemeStartPosition).Character
            };
        }

        public List<Token> ScanTokens()
        {
            var result = new List<Token>();

            while (!TextWindow.IsReallyAtEnd())
            {
                var t = Lex();
                result.Add(t);
            }

            return result;
        }
    }
}