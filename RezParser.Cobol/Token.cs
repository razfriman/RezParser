namespace RezParser.Cobol
{
    public class Token
    {
        public string Value { get; set; }
        public string LeadingTrivia { get; set; }
        public string TrailingTrivia { get; set; }
        public int ColumnStart { get; set; }
        public int RowStart { get; set; }
        public int ColumnEnd { get; set; }
        public int RowEnd { get; set; }
        public int Start { get; set; }
        public int End { get; set; }
        public bool IsTrivia { get; set; }
    }
}