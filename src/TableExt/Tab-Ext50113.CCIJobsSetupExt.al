namespace Loginform.CommonConstructionIndustryDataCore;

using Microsoft.Projects.Project.Setup;
using Microsoft.Projects.Resources.Resource;
using Microsoft.Projects.Project.Job;
using Microsoft.Projects.Project.Journal;
using Microsoft.Foundation.NoSeries;
using Microsoft.Finance.GeneralLedger.Setup;

tableextension 50113 "CCI Jobs Setup Ext" extends "Jobs Setup"
{
    fields
    {
        field(50000; "Aut. Posting Jnl Template Name"; Code[10])
        {
            Caption = 'Automatic Posting Journal Template Name', Comment = 'HUN: Automatikus könyvelési napló sablon neve';
            DataClassification = CustomerContent;
            Description = '#Project';
            TableRelation = "Job Journal Template";
        }
        field(50001; "Aut. Posting Jnl Batch Name"; Code[10])
        {
            Caption = 'Automatic Posting Journal Batch Name', Comment = 'HUN: Automatikus könyvelési napló köteg neve';
            DataClassification = CustomerContent;
            Description = '#Project';
            TableRelation = "Job Journal Batch".Name where("Journal Template Name" = field("Aut. Posting Jnl Template Name"));
        }
        field(50002; "Aut. Posting Resouce No."; Code[20])
        {
            Caption = 'Automatic Posting Resource No.', Comment = 'HUN: Automatikus könyvelési erőforrás szám';
            DataClassification = CustomerContent;
            Description = '#Project';
            TableRelation = Resource."No.";
        }
        field(50050; "CCI Service Order Nos."; Code[20])
        {
            Caption = 'Service Order Nos.', Comment = 'HUN: Szerviz rendelés számsorozat';
            DataClassification = CustomerContent;
            Description = '#Service';
            TableRelation = "No. Series";
        }
        field(50051; "CCI Service Project No."; Code[20])
        {
            Caption = 'Service Project No.', Comment = 'HUN: Szerviz projekt szám';
            DataClassification = CustomerContent;
            Description = '#Service';
            TableRelation = Job."No.";
        }
        field(50052; "CCI Service Project Task No."; Code[20])
        {
            Caption = 'Service Project Task No.', Comment = 'HUN: Szerviz projekt feladat szám';
            DataClassification = CustomerContent;
            Description = '#Service';
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("CCI Service Project No."));
        }
        field(50053; "CCI Serv. Gen. Bus. Post. Grp."; Code[20])
        {
            Caption = 'Service Gen. Bus. Posting Group', Comment = 'HUN: Szerviz általános üzleti könyvelési csoport';
            DataClassification = CustomerContent;
            Description = '#Service';
            TableRelation = "Gen. Business Posting Group";
        }
        field(50054; "CCI Serv. Post. Jnl Temp. Name"; Code[10])
        {
            Caption = 'Automatic Service Posting Journal Template Name', Comment = 'HUN: Automatikus szerviz könyvelési napló sablon neve';
            DataClassification = CustomerContent;
            Description = '#Service';
            TableRelation = "Job Journal Template";
        }
        field(50055; "CCI Serv. Post. Jnl Batch Name"; Code[10])
        {
            Caption = 'Automatic Service Posting Journal Batch Name', Comment = 'HUN: Automatikus szerviz könyvelési napló köteg neve';
            DataClassification = CustomerContent;
            Description = '#Service';
            TableRelation = "Job Journal Batch".Name where("Journal Template Name" = field("CCI Serv. Post. Jnl Temp. Name"));
        }
        field(50056; "CCI Def. Project Posting Group"; Code[20])
        {
            Caption = 'Default Project Posting Group', Comment = 'HUN: Alapértelmezett projekt könyvelési csoport';
            DataClassification = CustomerContent;
            Description = '#Project';
            TableRelation = "Job Posting Group";
        }
        field(50057; "CCI Conduct Header Nos."; Code[20])
        {
            Caption = 'Conduct Header Nos.', Comment = 'HUN: Munkalap fejléc számsorozat';
            DataClassification = CustomerContent;
            Description = '#Vezénylés';
            TableRelation = "No. Series";
        }
        field(50058; "CCI Workshop Order Nos."; Code[20])
        {
            Caption = 'Workshop Order Nos.', Comment = 'HUN: Műhelyi rendelés számsorozat';
            DataClassification = CustomerContent;
            Description = '#Service';
            TableRelation = "No. Series";
        }
    }
}
