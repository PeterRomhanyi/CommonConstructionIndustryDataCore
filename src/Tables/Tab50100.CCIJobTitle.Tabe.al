namespace Loginform.CommonConstructionIndustryDataCore;

table 50100 "CCI Job Title"
{
    Caption = 'Job Title', Comment = 'HUN: Beosztás';
    DataClassification = CustomerContent;
    Description = '#DataCore';
    Access = Public;
    Extensible = true;

    fields
    {
        field(1; "No."; Text[30])
        {
            Caption = 'No.', Comment = 'HUN: Szám';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description', Comment = 'HUN: Leírás';
            DataClassification = CustomerContent;
        }
        field(50000; "Machine Operator"; Boolean)
        {
            Caption = 'Machine Operator', Comment = 'HUN: Gépkezelő';
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
