namespace Loginform.CommonConstructionIndustryDataCore;

enum 50103 "CCI Service Status"
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(0; Open)
    {
        Caption = 'Open', Comment = 'HUN: Nyitott';
    }
    value(1; "In Progress")
    {
        Caption = 'In Progress', Comment = 'HUN: Folyamatban';
    }
    value(2; Finished)
    {
        Caption = 'Finished', Comment = 'HUN: Befejezett';
    }
}
