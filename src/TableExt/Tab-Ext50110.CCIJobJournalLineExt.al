namespace Loginform.CommonConstructionIndustryDataCore;

using Microsoft.Projects.Project.Journal;

tableextension 50110 "CCI Job Journal Line Ext" extends "Job Journal Line"
{
    fields
    {
        field(50000; "Original Resource No."; Code[20])
        {
            Caption = 'Original Resource No.', Comment = 'HUN: Eredeti erőforrás szám';
            DataClassification = CustomerContent;
            Description = '#Project';
        }
        field(50001; "Journal Total Cost (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Journal Total Cost (LCY)', Comment = 'HUN: Napló összköltség (HUF)';
            Description = '#Project';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Job Journal Line"."Total Cost (LCY)" where("Journal Template Name" = field("Journal Template Name"), "Journal Batch Name" = field("Journal Batch Name")));
        }
        field(50002; "Journal Total Price (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Journal Total Price (LCY)', Comment = 'HUN: Napló összár (HUF)';
            Description = '#Project';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Job Journal Line"."Total Price (LCY)" where("Journal Template Name" = field("Journal Template Name"), "Journal Batch Name" = field("Journal Batch Name")));
        }
        field(50030; Comment; Text[1024])
        {
            Caption = 'Comment', Comment = 'HUN: Megjegyzés';
            DataClassification = CustomerContent;
            Description = '#Service';
        }
    }
}
