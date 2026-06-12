namespace Loginform.CommonConstructionIndustryDataCore;

using Microsoft.Inventory.Item;

tableextension 50105 "CCI Item Ext" extends Item
{
    fields
    {
        field(50000; "Item Group Type"; Option)
        {
            Caption = 'Item Group Type', Comment = 'HUN: Cikk kategória csoporttípusa';
            Description = '#Service, #Mobile, #Refueling';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Item Category"."Item Group Type" where(Code = field("Item Category Code")));
            OptionMembers = ,"Work clothes","Protective equipment",Material,Part,Fuel,"Low-value asset","Mine Material","Locksmith supplies";
        }
        field(50010; CommentText; Text[100])
        {
            Caption = 'Comment', Comment = 'HUN: Megjegyzés';
            DataClassification = CustomerContent;
            Description = '#Service';
            OptimizeForTextSearch = true;
        }
        field(50020; "Item 2"; Text[50])
        {
            Caption = 'Item 2', Comment = 'HUN: Cikk 2';
            DataClassification = CustomerContent;
            Description = '#Service';
            OptimizeForTextSearch = true;
        }
        field(50030; "Item 3"; Text[50])
        {
            Caption = 'Item 3', Comment = 'HUN: Cikk 3';
            DataClassification = CustomerContent;
            Description = '#Service';
            OptimizeForTextSearch = true;
        }
        field(50050; "Qty. on Service Order Line"; Decimal)
        {
            Caption = 'Qty. on Service Order Line', Comment = 'HUN: Nyitott szervizrendelési sorokon lévő mennyiség';
            CalcFormula = sum("CCI Service Line".Quantity where("Document Type" = const(Order),
                                                                 Status = filter(Open | "In Progress"),
                                                                 Posted = const(false),
                                                                 Type = const(Item),
                                                                 "No." = field("No."),
                                                                 "Location Code" = field("Location Filter")));
            DecimalPlaces = 0 : 5;
            Description = '#Service';
            Editable = false;
            FieldClass = FlowField;
            AutoFormatType = 0;
        }
        field(50060; "ETVJ No."; Text[40])
        {
            Caption = 'ETVJ Number', Comment = 'HUN: ETVJ vizsgálati szám';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
    }
    keys
    {
        Key(Key50; "Item 2", "Item 3", CommentText) { }
    }
    fieldgroups
    {
        addlast(DropDown; "Common Item No.", "Item 2", "Item 3", CommentText) { }
    }
}
