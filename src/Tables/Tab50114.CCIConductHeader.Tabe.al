namespace Loginform.CommonConstructionIndustryDataCore;

using Microsoft.Projects.Project.Setup;
using Microsoft.Foundation.NoSeries;
using System.Security.AccessControl;

table 50114 "CCI Conduct Header"
{
    Access = Public;
    Caption = 'Conduct Header', Comment = 'HUN: Munkalap fejléc';
    DataClassification = CustomerContent;
    Description = '#Conduct';
    Extensible = true;

    fields
    {
        field(10; "No."; Code[20])
        {
            Caption = 'No.', Comment = 'HUN: Szám';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Rec."No." <> xRec."No." then begin
                    GetJobSetup();
                    TestNoSeriesManual();
                    Rec."No. Series" := '';
                end;
            end;
        }
        field(20; "No. Series"; Code[20])
        {
            Caption = 'No. Series', Comment = 'HUN: Számsorozat';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(30; "Document Date"; Date)
        {
            Caption = 'Document Date', Comment = 'HUN: Bizonylat dátuma';
            DataClassification = CustomerContent;
        }
        field(40; "User ID"; Code[50])
        {
            Caption = 'User', Comment = 'HUN: Felhasználó';
            DataClassification = CustomerContent;
            TableRelation = User."User Name";
        }
        field(50; Status; Enum "CCI Conduct Status")
        {
            Caption = 'Status', Comment = 'HUN: Állapot';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    var
        JobSetup: Record "Jobs Setup";
        NoSeries: Codeunit "No. Series";
        Text001: Label 'The Conduct Header %1 already exists.', Comment = '%1=Number;';

    trigger OnInsert()
    begin
        InitRecord();
    end;

    trigger OnDelete()
    var
        ConductLine: Record "CCI Conduct Line";
    begin
        Rec.TestField(Rec.Status, Rec.Status::Open);
        ConductLine.Reset();
        ConductLine.SetRange("Document No.", Rec."No.");
        if not ConductLine.IsEmpty() then
            ConductLine.DeleteAll(true);
    end;

    procedure GetJobSetup()
    begin
        JobSetup.Get();
    end;

    procedure InitRecord()
    begin
        GetJobSetup();
        SetDefaultNoSeries();
        Rec."Document Date" := Today;
        Rec."User ID" := UserId;
    end;

    local procedure SetDefaultNoSeries()
    begin
        Rec."No. Series" := JobSetup."CCI Conduct Header Nos.";
        Rec."No." := NoSeries.GetNextNo(Rec."No. Series", Rec."Document Date");
    end;

    local procedure TestNoSeriesManual()
    begin
        NoSeries.TestManual(JobSetup."CCI Conduct Header Nos.");
    end;
}
