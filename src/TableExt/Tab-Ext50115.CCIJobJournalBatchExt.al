namespace Loginform.CommonConstructionIndustryDataCore;

using Microsoft.Projects.Project.Journal;
using Microsoft.Projects.Project.Job;

tableextension 50115 "CCI Job Journal Batch Ext" extends "Job Journal Batch"
{
    fields
    {
        field(50000; "CCI Job No."; Code[20])
        {
            Caption = 'Job No.', Comment = 'HUN: Projekt szám';
            DataClassification = CustomerContent;
            Description = '#Project';
            TableRelation = Job;
        }
    }
}
