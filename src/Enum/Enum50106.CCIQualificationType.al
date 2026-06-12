namespace Loginform.CommonConstructionIndustryDataCore;

enum 50106 "CCI Qualification Type"
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Internal)
    {
        Caption = 'Internal', Comment = 'HUN: Belső';
    }
    value(2; External)
    {
        Caption = 'External', Comment = 'HUN: Külső';
    }
    value(3; "Previous Position")
    {
        Caption = 'Previous Position', Comment = 'HUN: Korábbi pozíció';
    }
}
