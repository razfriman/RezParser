using System;
using Microsoft.CodeAnalysis.Text;

namespace RezParser.Cobol
{
    public class CobolParseOptions
    {
        public static readonly CobolParseOptions Default = new();
    }
    public class CobolSyntaxTree
    {

        public static CobolSyntaxTree ParseText(string text, CobolParseOptions options = null)
        {
            return ParseText(SourceText.From(text));
        }
        
        public static CobolSyntaxTree ParseText(SourceText text, CobolParseOptions options = null)
        {
            if (text == null)
            {
                throw new ArgumentNullException(nameof(text));
            }

            options ??= CobolParseOptions.Default;

            var lexer = new CobolLexer(text, options);
            var tokens = lexer.ScanTokens();
            var tree = new CobolSyntaxTree();
            return tree;
        }
    }
}