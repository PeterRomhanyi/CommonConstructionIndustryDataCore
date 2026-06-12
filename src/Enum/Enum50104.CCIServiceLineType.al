namespace Loginform.CommonConstructionIndustryDataCore;

enum 50104 "CCI Service Line Type"
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Resource)
    {
        Caption = 'Resource', Comment = 'HUN: Erőforrás';
    }
    value(2; Item)
    {
        Caption = 'Item', Comment = 'HUN: Cikk';
    }
}
