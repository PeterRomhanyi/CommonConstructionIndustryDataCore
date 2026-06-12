namespace Loginform.CommonConstructionIndustryDataCore;

table 50109 "CCI Machine Writings"
{
    Access = Public;
    Caption = 'Machine Writings', Comment = 'HUN: Gépkönyvi bejegyzés';
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
        field(20; "Warning Day"; Date)
        {
            Caption = 'Warning Day', Comment = 'HUN: Figyelmeztetés napja';
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
