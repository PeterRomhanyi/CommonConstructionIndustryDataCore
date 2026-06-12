namespace Loginform.CommonConstructionIndustryDataCore;

enum 50102 "CCI Mandatory Service Type"
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(0; KM)
    {
        Caption = 'KM', Locked = true;
    }
    value(1; "Operating hours")
    {
        Caption = 'Operating hours', Comment = 'HUN: Üzemóra';
    }
    value(2; Year)
    {
        Caption = 'Year', Comment = 'HUN: Év';
    }
}
