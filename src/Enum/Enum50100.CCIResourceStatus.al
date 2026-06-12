namespace Loginform.CommonConstructionIndustryDataCore;

enum 50100 "CCI Resource Status"
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(50000; Works)
    {
        Caption = 'Works', Comment = 'HUN: Működik';
    }
    value(50010; Stands)
    {
        Caption = 'Stands', Comment = 'HUN: Áll';
    }
    value(50020; Repair)
    {
        Caption = 'Repair', Comment = 'HUN: Javítás';
    }
}
