namespace Loginform.CommonConstructionIndustryDataCore;

table 50102 "CCI Owner"
{
    Access = Public;
    Caption = 'Owner', Comment = 'HUN: Tulajdonos';
    DataClassification = CustomerContent;
    Description = '#DataCore';
    Extensible = true;

    fields
    {
        field(10; "No."; Code[30])
        {
            Caption = 'No.', Comment = 'HUN: Szám';
            DataClassification = CustomerContent;
        }
        field(20; Description; Text[100])
        {
            Caption = 'Description', Comment = 'HUN: Leírás';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
