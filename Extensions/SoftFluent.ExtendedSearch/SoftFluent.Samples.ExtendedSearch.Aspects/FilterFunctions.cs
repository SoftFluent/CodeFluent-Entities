using System;
using System.ComponentModel;
using System.Drawing.Design;

namespace SoftFluent.Samples.ExtendedSearch.Aspects
{
    [Flags]
    [EditorAttribute(typeof(CodeFluent.Runtime.Design.EnumEditor), typeof(UITypeEditor))]
    public enum FilterFunctions
    {
        None =                      0x0000,
        Equals =                    0x0001,
        NotEquals =                 0x0002,
        StartsWith =                0x0004,
        EndsWith =                  0x0008,
        Contains =                  0x0010,
        NotContains =               0x0020,
        IsLessThan =                0x0040,
        IsLessThanOrEqualTo =       0x0080,
        IsGreaterThan =             0x0100,
        IsGreaterThanOrEqualTo =    0x0200,
        FullTextContains =          0x0400,
        NotFullTextContains =       0x0800,
        FreeText =                  0x1000,
        NotFreeText =               0x2000,
        AllExceptFullText =         All ^ FullTextContains ^ NotFullTextContains ^ FreeText ^ NotFreeText,
        All =                       0x3FFF
    }
}