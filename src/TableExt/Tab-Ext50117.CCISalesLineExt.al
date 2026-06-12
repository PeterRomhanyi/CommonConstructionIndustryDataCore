namespace Loginform.CommonConstructionIndustryDataCore;

using Microsoft.Sales.Document;
using Microsoft.Projects.Project.Job;

tableextension 50117 "CCI Sales Line Ext" extends "Sales Line"
{
    fields
    {
        modify("Job No.")
        {
            TableRelation = Job where("Bill-to Customer No." = field("Bill-to Customer No."), Status = filter(<> Completed));
        }
    }
}
