using System;
using System.IO;
using System.Linq;
using Microsoft.CodeAnalysis.Text;

namespace RezParser.Cobol.Console
{
    public static class Program
    {
        public static void Main(string[] args)
        {
            var sourceText = SourceText.From(" COMPUTE    A   \r\n  EQUALS B PLUS C");
            sourceText = SourceText.From(File.ReadAllText("test.cob"));
            var lexer = new CobolLexer(sourceText, null);
            var tokens = lexer.ScanTokens();
            System.Console.WriteLine("Tokens");
            tokens
                .Where(x => !x.IsTrivia)
                .ToList()
                .ForEach(token => System.Console.WriteLine($"Token:{token.Value}"));
                //.ForEach(token => System.Console.WriteLine($"Token:{token.Value}          Start:{token.Start} End:{token.End} RowStart:{token.RowStart} ColumnStart:{token.ColumnStart} RowEnd:{token.RowEnd} ColumnEnd:{token.ColumnEnd}"));
            System.Console.WriteLine("Done");
        }
    }
}