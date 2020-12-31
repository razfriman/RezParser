using System;
using System.Collections.Generic;
using System.Text;

namespace RezParser.Cobol
{
    public class CobolParser : Parser
    {
        public object Parse(string aaa)
        {
            var input = aaa;
            var index = 0;
            var tokens = new List<string>();
            var token = new Token();
            var tokenBuilder = new StringBuilder();
            while (index < input.Length)
            {
            var c = input[index];
            
            if (c == ' ')
            {
                tokens.Add(tokenBuilder.ToString());
                tokenBuilder.Clear();
            }
            else
            {
                tokenBuilder.Append(c);
            }
            index++;
            }
            tokens.Add(tokenBuilder.ToString());
            
            tokens.ForEach(Console.WriteLine);
            

            
            return false;
        }
    }
}