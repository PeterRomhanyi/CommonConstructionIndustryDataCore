namespace Loginform.CommonConstructionIndustryDataCore;

table 50103 "CCI Machine Status Log"
{
    Access = Public;
    Caption = 'Machine Status Log', Comment = 'HUN: Gép állapot napló';
    DataClassification = CustomerContent;
    Description = '#DataCore, #Service, #Mobile';
    Extensible = true;

    fields
    {
        field(10; "Resource No."; Code[20])
        {
            Caption = 'Resource No.', Comment = 'HUN: Erőforrás sz.';
            DataClassification = CustomerContent;
        }
        field(15; "Line No."; Integer)
        {
            Caption = 'Line No.', Comment = 'HUN: Sor szám';
            DataClassification = CustomerContent;
        }
        field(20; "Date"; Date)
        {
            Caption = 'Date', Comment = 'HUN: Dátum';
            DataClassification = CustomerContent;
        }
        field(30; "KM/Operating Hours"; Integer)
        {
            Caption = 'KM/Operating Hours', Comment = 'HUN: KM/Üzemóra';
            DataClassification = CustomerContent;
        }
        field(40; Status; Enum "CCI Resource Status")
        {
            Caption = 'Status', Comment = 'HUN: Állapot';
            DataClassification = CustomerContent;
        }
        field(100; "Service Order No."; Code[20])
        {
            Caption = 'Service Order No.', Comment = 'HUN: Szerviz rendelés sz.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(110; "Service Document Date"; Date)
        {
            Caption = 'Service Document Date', Comment = 'HUN: Szerviz bizonylat dátuma';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(120; Comment; Text[1000])
        {
            Caption = 'Comment', Comment = 'HUN: Megjegyzés';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Resource No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
