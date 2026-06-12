namespace Loginform.CommonConstructionIndustryDataCore;

using System.Security.AccessControl;

table 50116 "CCI Conduct Log"
{
    Access = Public;
    Caption = 'Conduct Log', Comment = 'HUN: Munkalap napló';
    DataClassification = CustomerContent;
    Description = '#Conduct';
    Extensible = true;

    fields
    {
        field(10; "Entry No."; BigInteger)
        {
            Caption = 'Entry No.', Comment = 'HUN: Tételszám';
            DataClassification = CustomerContent;
        }
        field(21; "Document No."; Code[20])
        {
            Caption = 'Document No.', Comment = 'HUN: Bizonylat szám';
            DataClassification = CustomerContent;
        }
        field(50; "Old Status"; Enum "CCI Conduct Status")
        {
            Caption = 'Old Status', Comment = 'HUN: Korábbi állapot';
            DataClassification = CustomerContent;
        }
        field(60; "New Status"; Enum "CCI Conduct Status")
        {
            Caption = 'New Status', Comment = 'HUN: Új állapot';
            DataClassification = CustomerContent;
        }
        field(70; "User ID"; Code[50])
        {
            Caption = 'User ID', Comment = 'HUN: Felhasználó azonosító';
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }
        field(80; "Log Date"; Date)
        {
            Caption = 'Log Date', Comment = 'HUN: Napló dátuma';
            DataClassification = CustomerContent;
        }
        field(90; "Log Time"; Time)
        {
            Caption = 'Log Time', Comment = 'HUN: Napló időpontja';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
