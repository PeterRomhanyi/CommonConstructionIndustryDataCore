namespace Loginform.CommonConstructionIndustryDataCore;

table 50101 "CCI Job Group"
{
    Access = Public;
    Caption = 'Job Group', Comment = 'HUN: Projekt csoport';
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
        field(2; Description; Text[250])
        {
            Caption = 'Description', Comment = 'HUN: Leírás';
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
