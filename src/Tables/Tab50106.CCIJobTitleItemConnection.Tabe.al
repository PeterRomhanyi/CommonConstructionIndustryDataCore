namespace Loginform.CommonConstructionIndustryDataCore;

using Microsoft.Inventory.Item;

table 50106 "CCI Job Title Item Connection"
{
    Access = Public;
    Caption = 'Job Title Item Connection', Comment = 'HUN: Beosztás cikk kapcsolat';
    DataClassification = CustomerContent;
    Description = '#DataCore';
    Extensible = true;

    fields
    {
        field(10; "Job Title"; Code[10])
        {
            Caption = 'Job Title', Comment = 'HUN: Beosztás';
            DataClassification = CustomerContent;
            TableRelation = "CCI Job Title"."No.";
        }
        field(15; "Job Title Description"; Text[100])
        {
            Caption = 'Job Title Description', Comment = 'HUN: Beosztás leírás';
            FieldClass = FlowField;
            CalcFormula = lookup("CCI Job Title".Description where("No." = field("Job Title")));
            Editable = false;
        }
        field(20; "Item No."; Code[20])
        {
            Caption = 'Item No.', Comment = 'HUN: Cikkszám';
            DataClassification = CustomerContent;
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
                    Rec."Item No." := ItemRec."No.";
                end;
            end;
        }
        field(25; "Item Description"; Text[100])
        {
            Caption = 'Item Description', Comment = 'HUN: Cikk leírás';
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Job Title", "Item No.")
        {
            Clustered = true;
        }
    }
}
