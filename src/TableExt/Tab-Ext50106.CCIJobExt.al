namespace Loginform.CommonConstructionIndustryDataCore;

using Microsoft.Projects.Project.Job;
using Microsoft.Projects.Project.Planning;

tableextension 50106 "CCI Job Ext" extends Job
{
    fields
    {
        field(50000; "Job Group code"; Code[20])
        {
            Caption = 'Project Group code', Comment = 'HUN: Projekt csoport kód';
            DataClassification = CustomerContent;
            Description = '#Mobile';
            TableRelation = "CCI Job Group"."Code";
        }
        modify("No.")
        {
            Caption = 'Contract number';
        }
        field(50010; "External contract number"; Text[200])
        {
            Caption = 'External contract number', Comment = 'HUN: Külső szerződésszám';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
    }

    procedure ReadinessPercent(JobNo: Code[20]): Decimal
    var
        JPLRec_: Record "Job Planning Line";
    begin
        JPLRec_.Reset();
        JPLRec_.SetRange("Job No.", JobNo);
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
