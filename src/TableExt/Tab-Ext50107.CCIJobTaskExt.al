namespace Loginform.CommonConstructionIndustryDataCore;

using Microsoft.Projects.Project.Job;
using Microsoft.Projects.Project.Planning;
using Microsoft.Projects.Project.Journal;

tableextension 50107 "CCI Job Task Ext" extends "Job Task"
{
    fields
    {
        field(50000; "Job Group code"; Code[20])
        {
            Caption = 'Project Group code', Comment = 'HUN: Projekt csoport kód';
            Description = '#Mobile';
            FieldClass = FlowField;
            CalcFormula = lookup(Job."Job Group code" where("No." = field("Job No.")));
        }
        field(50010; "Planned start date"; Date)
        {
            Caption = 'Planned start date', Comment = 'HUN: Tervezett kezdési dátum';
            Description = '#DataCore';
            FieldClass = FlowField;
            CalcFormula = min("Job Planning Line"."Start Date" where("Job No." = field("Job No."), "Job Task No." = field("Job Task No.")));
        }
        field(50020; "Planned end date"; Date)
        {
            Caption = 'Planned end date', Comment = 'HUN: Tervezett befejezési dátum';
            Description = '#DataCore';
            FieldClass = FlowField;
            CalcFormula = max("Job Planning Line"."End Date" where("Job No." = field("Job No."), "Job Task No." = field("Job Task No.")));
        }
    }

    procedure ReadinessPercent(JobNo: Code[20]; JobTaskNo: Code[20]): Decimal
    var
        JPLRec_: Record "Job Planning Line";
    begin
        JPLRec_.Reset();
        JPLRec_.SetRange("Job No.", JobNo);
        JPLRec_.SetRange("Job Task No.", JobTaskNo);
        JPLRec_.SetFilter("Unit Price", '<>%1', 0);
        if JPLRec_.FindSet(false) then begin
            JPLRec_.CalcSums(JPLRec_."Qty. Posted", JPLRec_.Quantity);
            if (JPLRec_."Qty. Posted" <> 0) or (JPLRec_.Quantity <> 0) then
                exit((JPLRec_."Qty. Posted" / JPLRec_.Quantity) * 100)
            else
                exit(0);
        end;
    end;
}
