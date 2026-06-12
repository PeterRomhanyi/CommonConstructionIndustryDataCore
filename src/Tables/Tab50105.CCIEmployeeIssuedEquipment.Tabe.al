namespace Loginform.CommonConstructionIndustryDataCore;

using Microsoft.Inventory.Item;
using Microsoft.HumanResources.Employee;

table 50105 "CCI Employee Issued Equipment"
{
    Access = Public;
    Caption = 'Employee Issued Equipment', Comment = 'HUN: Kiadott felszerelés';
    DataClassification = CustomerContent;
    Description = '#DataCore';
    Extensible = true;

    fields
    {
        field(10; "Item No."; Code[20])
        {
            Caption = 'Item No.', Comment = 'HUN: Cikkszám';
            DataClassification = CustomerContent;
            TableRelation = Item."No.";
            trigger OnValidate()
            var
                ItemRec_: Record Item;
            begin
                if ItemRec_.Get("Item No.") then
                    Description := ItemRec_.Description;
            end;

            trigger OnLookup()
            var
                ItemRec: Record Item;
                ItemList: Page "Item List";
            begin
                ItemRec.Reset();
                //ToDo: The Item Group Type must be transferred to table, and an individual checkbox nedds to controll, which types can be used in this field.
                ItemRec.CalcFields("Item Group Type");
                ItemRec.SetFilter("Item Group Type", '%1|%2',
                    ItemRec."Item Group Type"::"Work clothes",
                    ItemRec."Item Group Type"::"Protective equipment");
                ItemList.SetTableView(ItemRec);
                if ItemRec.Get(Rec."Item No.") then
                    ItemList.SetRecord(ItemRec);
                ItemList.LookupMode(true);
                if ItemList.RunModal() = Action::LookupOK then begin
                    ItemList.GetRecord(ItemRec);
                    Rec.Validate("Item No.", ItemRec."No.");
                end;
            end;
        }
        field(20; "Employee No."; Code[20])
        {
            Caption = 'Employee No.', Comment = 'HUN: Alkalmazott szám';
            DataClassification = CustomerContent;
            TableRelation = Employee."No.";
        }
        field(30; Description; Text[100])
        {
            Caption = 'Description', Comment = 'HUN: Leírás';
            DataClassification = CustomerContent;
        }
        field(40; Issued; Boolean)
        {
            Caption = 'Issued', Comment = 'HUN: Kiadva';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if Rec.Issued then
                    "Issued Date" := Today
                else
                    "Issued Date" := 0D;
                Rec.Modify();
            end;
        }
        field(50; "Issued Date"; Date)
        {
            Caption = 'Issued Date', Comment = 'HUN: Kiadás dátuma';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60; IssuedEntryID; Integer)
        {
            Caption = 'Issued Entry ID', Comment = 'HUN: Kiadási tétel azonosító';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Item No.", "Employee No.")
        {
            Clustered = true;
        }
    }
}
