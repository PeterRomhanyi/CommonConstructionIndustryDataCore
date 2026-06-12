namespace Loginform.CommonConstructionIndustryDataCore;

enum 50108 "CCI Settlement Type"
{
    Access = Public;
    Extensible = true;
    Caption = 'Settlement Type', Comment = 'HUN: Elszámolás típusa';

    value(0; Turn)
    {
        Caption = 'Turn', Comment = 'HUN: Forduló';
    }
    value(1; Hour)
    {
        Caption = 'Hour', Comment = 'HUN: Óra';
    }
}
