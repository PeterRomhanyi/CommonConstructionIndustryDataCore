namespace Loginform.CommonConstructionIndustryDataCore;

using Microsoft.HumanResources.Comment;

using Microsoft.Projects.Resources.Resource;

table 50110 "CCI Resource Qualification"
{
    Access = Public;
    Caption = 'Resource Qualification', Comment = 'HUN: Erőforrás képesítés';
    DataCaptionFields = "Resource No.";
    DataClassification = CustomerContent;
    Description = '#DataCore';
    Extensible = true;

    fields
    {
        field(1; "Resource No."; Code[20])
        {
            Caption = 'Resource No.', Comment = 'HUN: Erőforrás szám';
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = Resource."No.";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.', Comment = 'HUN: Sor szám';
            DataClassification = CustomerContent;
        }
        field(3; "Qualification Code"; Code[10])
        {
            Caption = 'Qualification Code', Comment = 'HUN: Képesítés kód';
            DataClassification = CustomerContent;
            TableRelation = "CCI Machine Writings"."Code";

            trigger OnValidate()
            var
                MachineWritings: Record "CCI Machine Writings";
            begin
                MachineWritings.Get(Rec."Qualification Code");
                Rec.Description := MachineWritings.Description;
            end;
        }
        field(4; "From Date"; Date)
        {
            Caption = 'From Date', Comment = 'HUN: Kezdő dátum';
            DataClassification = CustomerContent;
        }
        field(5; "To Date"; Date)
        {
            Caption = 'To Date', Comment = 'HUN: Záró dátum';
            DataClassification = CustomerContent;
        }
        field(6; Type; Enum "CCI Qualification Type")
        {
            Caption = 'Type', Comment = 'HUN: Típus';
            DataClassification = CustomerContent;
        }
        field(7; Description; Text[100])
        {
            Caption = 'Description', Comment = 'HUN: Leírás';
            DataClassification = CustomerContent;
        }
        field(8; "Institution/Company"; Text[100])
        {
            Caption = 'Institution/Company', Comment = 'HUN: Intézmény/Cég';
            DataClassification = CustomerContent;
        }
        field(9; Cost; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost', Comment = 'HUN: Költség';
            DataClassification = CustomerContent;
        }
        field(10; "Course Grade"; Text[50])
        {
            Caption = 'Course Grade', Comment = 'HUN: Tanfolyam osztályzat';
            DataClassification = CustomerContent;
        }
        field(11; "Resource Status"; Enum "CCI Resource Status")
        {
            Caption = 'Resource Status', Comment = 'HUN: Erőforrás állapot';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(12; Comment; Boolean)
        {
            CalcFormula = exist("Human Resource Comment Line" where("Table Name" = const("Resource Qualification"),
                                                                     "No." = field("Resource No."),
                                                                     "Table Line No." = field("Line No.")));
            Caption = 'Comment', Comment = 'HUN: Megjegyzés';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date', Comment = 'HUN: Lejárat dátuma';
            DataClassification = CustomerContent;
        }
        field(50000; "Topographic Validity"; Date)
        {
            Caption = 'Topographic Validity', Comment = 'HUN: Topográfiai érvényesség';
            DataClassification = CustomerContent;
        }
        field(50010; "Bond Number"; Text[30])
        {
            Caption = 'Bond Number', Comment = 'HUN: Kötvényszám';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Resource No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Qualification Code") { }
    }

    trigger OnDelete()
    var
        DeleteErr: Label 'You cannot delete resource qualification information if there are comments associated with it.', Comment = 'HUN: Nem törölheti az erőforrás képesítési adatokat, ha megjegyzések kapcsolódnak hozzá.';
    begin
        Rec.CalcFields(Comment);
        if Rec.Comment then
            Error(DeleteErr);
    end;

    trigger OnInsert()
    var
        ResourceRec: Record Resource;
    begin
        ResourceRec.Get(Rec."Resource No.");
        Rec."Resource Status" := ResourceRec.Status;
    end;
}
