namespace Loginform.CommonConstructionIndustryDataCore;

using Microsoft.Inventory.Transfer;

tableextension 50118 "CCI Transfer Header Ext" extends "Transfer Header"
{
    trigger OnAfterInsert()
    begin
        Rec.Validate("Direct Transfer", true);
    end;
}
