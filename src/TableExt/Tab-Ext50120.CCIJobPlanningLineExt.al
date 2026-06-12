namespace Loginform.CommonConstructionIndustryDataCore;

using Microsoft.Projects.Project.Planning;

tableextension 50120 "CCI Job Planning Line Ext" extends "Job Planning Line"
{
    fields
    {
        field(50000; "Start Date"; Date)
        {
            Caption = 'Start Date', Comment = 'HUN: Kezdési dátum';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50010; "End Date"; Date)
        {
            Caption = 'End Date', Comment = 'HUN: Befejezési dátum';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
    }
}
