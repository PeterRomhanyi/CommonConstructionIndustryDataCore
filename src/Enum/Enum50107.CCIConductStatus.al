namespace Loginform.CommonConstructionIndustryDataCore;

enum 50107 "CCI Conduct Status"
{
    Access = Public;
    Extensible = true;
    Caption = 'Conduct Status', Comment = 'HUN: Munkalap állapot';

    value(0; Open)
    {
        Caption = 'Open', Comment = 'HUN: Nyitott';
    }
    value(1; Closed)
    {
        Caption = 'Closed', Comment = 'HUN: Lezárt';
    }
}
