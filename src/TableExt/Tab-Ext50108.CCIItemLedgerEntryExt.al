namespace Loginform.CommonConstructionIndustryDataCore;

using Microsoft.Inventory.Item;
using Microsoft.Inventory.Ledger;
using Microsoft.Purchases.Vendor;

tableextension 50108 "CCI Item Ledger Entry Ext" extends "Item Ledger Entry"
{
    fields
    {
        field(50000; "Item Group Type"; Option)
        {
            Caption = 'Item Group Type', Comment = 'HUN: Cikk kategória csoporttípusa';
            Editable = false;
            Description = '#Service';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Category"."Item Group Type" where(Code = field("Item Category Code")));
            OptionMembers = ,"Work clothes","Protective equipment",Material,Part,Fuel,"Low-value asset","Mine Material","Locksmith supplies";
            OptionCaption = ' ,Work clothes,Protective equipment,Material,Part,Fuel,Low-value asset,Mine Material,Locksmith supplies', Comment = 'HUN:  ,Munkaruha,Védő felszerelés,Anyag,Alkatrész,Üzemanyag,Kisértékű eszköz,Bánya anyag,Lakatos anyag';
        }
        field(50030; Comment; Text[1024])
        {
            Caption = 'Comment', Comment = 'HUN: Megjegyzés';
            DataClassification = CustomerContent;
            Description = '#Service';
            OptimizeForTextSearch = true;
            Editable = false;
        }
        field(50040; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name', Comment = 'HUN: Szállító neve';
            Description = '#DataCore';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor.Name where("No." = field("Source No.")));
        }
        field(50050; "Item 2"; Text[50])
        {
            Caption = 'Item 2', Comment = 'HUN: Cikk 2';
            Description = '#DataCore';
            OptimizeForTextSearch = true;
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50060; "Item 3"; Text[50])
        {
            Caption = 'Item 3', Comment = 'HUN: Cikk 3';
            Description = '#DataCore';
            OptimizeForTextSearch = true;
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50070; "Common Item No."; Code[20])
        {
            Caption = 'Common Item No.', Comment = 'HUN: Közös cikkszám';
            Description = '#DataCore';
            OptimizeForTextSearch = true;
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
}
