namespace Loginform.CommonConstructionIndustryDataCore;

using Microsoft.Finance.GeneralLedger.Setup;

tableextension 50109 "CCI General Ledger Setup Ext" extends "General Ledger Setup"
{
    fields
    {
        field(50000; "Gross wage multiplier"; Decimal)
        {
            Caption = 'Gross wage multiplier', Comment = 'HUN: Bruttó bérszorzó';
            DataClassification = CustomerContent;
            Description = '#HR';
        }
    }
}
