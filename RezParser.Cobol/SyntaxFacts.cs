using System.Diagnostics;

namespace RezParser.Cobol
{
    public class SyntaxFacts
    {
        /// <summary>
        /// Returns true if the Unicode character is a hexadecimal digit.
        /// </summary>
        /// <param name="c">The Unicode character.</param>
        /// <returns>true if the character is a hexadecimal digit 0-9, A-F, a-f.</returns>
        internal static bool IsWhiteSpace(char c)
        {
            return c == ' ' || c == '\t' || c == '\r' || c == '\n';
        }
        
        /// <summary>
        /// Returns true if the Unicode character is a hexadecimal digit.
        /// </summary>
        /// <param name="c">The Unicode character.</param>
        /// <returns>true if the character is a hexadecimal digit 0-9, A-F, a-f.</returns>
        internal static bool IsHexDigit(char c)
        {
            return (c >= '0' && c <= '9') ||
                   (c >= 'A' && c <= 'F') ||
                   (c >= 'a' && c <= 'f');
        }

        /// <summary>
        /// Returns true if the Unicode character is a binary (0-1) digit.
        /// </summary>
        /// <param name="c">The Unicode character.</param>
        /// <returns>true if the character is a binary digit.</returns>
        internal static bool IsBinaryDigit(char c)
        {
            return c == '0' | c == '1';
        }

        /// <summary>
        /// Returns true if the Unicode character is a decimal digit.
        /// </summary>
        /// <param name="c">The Unicode character.</param>
        /// <returns>true if the Unicode character is a decimal digit.</returns>
        internal static bool IsDecDigit(char c)
        {
            return c >= '0' && c <= '9';
        }

        /// <summary>
        /// Returns the value of a hexadecimal Unicode character.
        /// </summary>
        /// <param name="c">The Unicode character.</param>
        internal static int HexValue(char c)
        {
            Debug.Assert(IsHexDigit(c));
            return (c >= '0' && c <= '9') ? c - '0' : (c & 0xdf) - 'A' + 10;
        }

        /// <summary>
        /// Returns the value of a binary Unicode character.
        /// </summary>
        /// <param name="c">The Unicode character.</param>
        internal static int BinaryValue(char c)
        {
            Debug.Assert(IsBinaryDigit(c));
            return c - '0';
        }

        /// <summary>
        /// Returns the value of a decimal Unicode character.
        /// </summary>
        /// <param name="c">The Unicode character.</param>
        internal static int DecValue(char c)
        {
            Debug.Assert(IsDecDigit(c));
            return c - '0';
        }
    }
}