namespace Loginform.CommonConstructionIndustryDataCore;

using Microsoft.Inventory.Location;
using Microsoft.Projects.Resources.Resource;

table 50115 "CCI Conduct Line"
{
    Access = Public;
    Caption = 'Conduct Line', Comment = 'HUN: Munkalap sor';
    DataClassification = CustomerContent;
    Description = '#Conduct';
    Extensible = true;

    fields
    {
        field(10; "Document No."; Code[20])
        {
            Caption = 'Document No.', Comment = 'HUN: Bizonylat szám';
            DataClassification = CustomerContent;
            TableRelation = "CCI Conduct Header"."No.";
        }
        field(20; "Line No."; Integer)
        {
            Caption = 'Line No.', Comment = 'HUN: Sorszám';
            DataClassification = CustomerContent;
        }
        field(30; "Location Code"; Code[10])
        {
            Caption = 'Location Code', Comment = 'HUN: Telephely kód';
            DataClassification = CustomerContent;
            TableRelation = Location;

            trigger OnValidate()
            begin
                TestStatusOpen();
                GetConductHeader();
            end;
        }
        field(40; "Employee No."; Code[20])
        {
            Caption = 'Employee No.', Comment = 'HUN: Alkalmazott szám';
            DataClassification = CustomerContent;
            TableRelation = Resource where(Type = const(Person), Blocked = const(false));
        }
        field(45; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name', Comment = 'HUN: Alkalmazott neve';
            FieldClass = FlowField;
            CalcFormula = lookup(Resource.Name where("No." = field("Employee No.")));
            Editable = false;
        }
        field(50; "Machine No."; Code[20])
        {
            Caption = 'Machine No.', Comment = 'HUN: Gép szám';
            DataClassification = CustomerContent;
            TableRelation = Resource where(Type = const(Machine), Blocked = const(false));
        }
        field(55; "Machine Name"; Text[100])
        {
            Caption = 'Machine Name', Comment = 'HUN: Gép neve';
            FieldClass = FlowField;
            CalcFormula = lookup(Resource.Name where("No." = field("Machine No.")));
            Editable = false;
        }
        field(60; Comment; Text[1000])
        {
            Caption = 'Comment', Comment = 'HUN: Megjegyzés';
            DataClassification = CustomerContent;
        }
        field(70; Quantity; Decimal)
        {
            Caption = 'Quantity', Comment = 'HUN: Mennyiség';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                GetConductHeader();
                Rec.TestField(Rec."Employee No.");
                Rec.TestField(Rec."Machine No.");
                TestStatusOpen();
            end;
        }
        field(80; "Settlement Type"; Enum "CCI Settlement Type")
        {
            Caption = 'Settlement Type', Comment = 'HUN: Elszámolás típusa';
            DataClassification = CustomerContent;
        }
        field(90; "Document Date"; Date)
        {
            Caption = 'Document Date', Comment = 'HUN: Bizonylat dátuma';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    var
        ConductHeader: Record "CCI Conduct Header";

    trigger OnInsert()
    begin
        GetConductHeader();
        Rec."Document Date" := ConductHeader."Document Date";
    end;

    trigger OnDelete()
    begin
        GetConductHeader();
        ConductHeader.TestField(ConductHeader.Status, ConductHeader.Status::Open);
    end;

    procedure GetConductHeader(): Record "CCI Conduct Header"
    begin
        ConductHeader.Get(Rec."Document No.");
        exit(ConductHeader);
    end;

    procedure TestStatusOpen()
    var
        LocalConductHeader: Record "CCI Conduct Header";
    begin
        LocalConductHeader.Get(Rec."Document No.");
        LocalConductHeader.TestField(LocalConductHeader.Status, LocalConductHeader.Status::Open);
    end;
}
