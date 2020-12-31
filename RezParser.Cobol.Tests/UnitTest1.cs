using Microsoft.CodeAnalysis;
using Microsoft.CodeAnalysis.CSharp;
using Microsoft.CodeAnalysis.Text;
using NUnit.Framework;

namespace RezParser.Cobol.Tests
{
    public class Tests
    {
        [Test]
        public void Test()
        {
            //SyntaxTree csharpTree = CSharpSyntaxTree.ParseText(" var x = 1; ");
            //var tree = CobolSyntaxTree.ParseText("aa bb cc");
            var lexer = new CobolLexer(SourceText.From("aa bb cc"), null);
            var tokens = lexer.ScanTokens();
            Assert.Pass();
        }
    }
}