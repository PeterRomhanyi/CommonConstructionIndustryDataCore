namespace Loginform.CommonConstructionIndustryDataCore;

using Microsoft.Inventory.Item;

tableextension 50104 "CCI Item Category Ext" extends "Item Category"
{
    fields
    {
        field(50000; "Item Group Type"; Option)
        {
            Caption = 'Item Group Type', Comment = 'HUN: Cikk kategória csoporttípusa';
            DataClassification = CustomerContent;
            Description = '#DataCore';
            //ToDo: Change to New table "CCI Item Group Type" and use it as a base table for this field
            OptionMembers = ,"Work clothes","Protective equipment",Material,Part,Fuel,"Low-value asset","Mine Material","Locksmith supplies";
            OptionCaption = ' ,Work clothes,Protective equipment,Material,Part,Fuel,Low-value asset,Mine Material,Locksmith supplies', Comment = 'HUN:  ,Munkaruha,Védő felszerelés,Anyag,Alkatrész,Üzemanyag,Kisértékű eszköz,Bánya anyag,Lakatos anyag';
        }
        field(50010; "Item Expiration"; Text[10])
        {
            Caption = 'Item Expiration formula', Comment = 'HUN: Cikk lejárati képlet';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                Error001: Label 'Only work clothes or protective equipment can have an expired formula!', Comment = 'HUN: Csak munkaruha vagy védőfelszerelés rendelkezhet lejárati képlettel!';
            begin
                //ToDo: On the new "CCI Item Group Type" table it can be validated in the table "CCI Item Group Type" instead of validating it here with if statement
                if ("Item Group Type" <> "Item Group Type"::"Work clothes") and ("Item Group Type" <> "Item Group Type"::"Protective equipment") then
                    Error(Error001);
            end;
        }
    }
}
