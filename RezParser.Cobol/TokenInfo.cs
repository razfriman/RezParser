namespace RezParser.Cobol
{
    public struct TokenInfo
    {
        // scanned values
        internal SyntaxKind Kind;
        internal SyntaxKind ContextualKind;
        internal string Text;
        internal bool RequiresTextForXmlEntity;
        internal bool HasIdentifierEscapeSequence;
        internal string StringValue;
        internal char CharValue;
        internal int IntValue;
        internal uint UintValue;
        internal long LongValue;
        internal ulong UlongValue;
        internal float FloatValue;
        internal double DoubleValue;
        internal decimal DecimalValue;
        internal bool IsVerbatim;
    }
}