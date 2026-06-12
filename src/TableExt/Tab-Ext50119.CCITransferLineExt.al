namespace Loginform.CommonConstructionIndustryDataCore;

using Microsoft.Inventory.Transfer;

tableextension 50119 "CCI Transfer Line Ext" extends "Transfer Line"
{
    fields
    {
        field(50000; "Quantity received by warehouse"; Decimal)
        {
            Caption = 'Quantity received by warehouse', Comment = 'HUN: Raktár által átvett mennyiség';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
    }
}
