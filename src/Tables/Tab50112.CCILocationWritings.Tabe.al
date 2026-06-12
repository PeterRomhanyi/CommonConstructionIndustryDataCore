namespace Loginform.CommonConstructionIndustryDataCore;

table 50112 "CCI Location Writings"
{
    Access = Public;
    Caption = 'Location Writings', Comment = 'HUN: Telephely bejegyzések';
    DataClassification = CustomerContent;
    Description = '#DataCore';
    Extensible = true;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code', Comment = 'HUN: Kód';
            DataClassification = CustomerContent;
        }
        field(10; Description; Text[100])
        {
            Caption = 'Description', Comment = 'HUN: Leírás';
            DataClassification = CustomerContent;
        }
        field(20; "Warning Days"; Decimal)
        {
            Caption = 'Warning Days', Comment = 'HUN: Figyelmeztetés (nap)';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
