namespace Loginform.CommonConstructionIndustryDataCore;

using Microsoft.Projects.Resources.Resource;
using Microsoft.Inventory.Location;
using Microsoft.Foundation.NoSeries;
using Microsoft.Finance.Dimension;
using Microsoft.Projects.Project.Setup;
using System.Security.User;
using Microsoft.Finance.GeneralLedger.Setup;

table 50107 "CCI Service Header"
{
    Access = Public;
    Caption = 'Service Header', Comment = 'HUN: Szerviz fejléc';
    DataClassification = CustomerContent;
    Description = '#Service';
    Extensible = true;

    fields
    {
        field(10; "Document Type"; Enum "CCI Service Document Type")
        {
            Caption = 'Document Type', Comment = 'HUN: Bizonylat típus';
            DataClassification = CustomerContent;
        }
        field(20; "No."; Code[20])
        {
            Caption = 'No.', Comment = 'HUN: Szám';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    GetJobSetup();
                    TestNoSeriesManual();
                    "No. Series" := '';
                end;
            end;
        }
        field(30; "Resource No."; Code[20])
        {
            Caption = 'Resource No.', Comment = 'HUN: Erőforrás szám';
            DataClassification = CustomerContent;
            TableRelation = Resource."No." where(Type = const(Machine));

            trigger OnValidate()
            var
                ResourceRec: Record Resource;
                Ev1Dec: Decimal;
                Ev2Dec: Decimal;
                Ev1Date: Date;
                Ev2Date: Date;
            begin
                TestField("Resource No.");
                ResourceRec.Get(Rec."Resource No.");
                if (ResourceRec."Last serv. KM/Oper. hours" <> '') and (Rec."Resource Las serv.KM/Miles" <> '') then begin
                    if ResourceRec."Mandatory service type" = "CCI Mandatory Service Type"::Year then begin
                        Evaluate(Ev1Date, ResourceRec."Last serv. KM/Oper. hours");
                        Evaluate(Ev2Date, Rec."Resource Las serv.KM/Miles");
                        if Ev2Date < Ev1Date then
                            Rec."Resource Las serv.KM/Miles" := ResourceRec."Last serv. KM/Oper. hours";
                    end else begin
                        Evaluate(Ev1Dec, ResourceRec."Last serv. KM/Oper. hours");
                        Evaluate(Ev2Dec, Rec."Resource Las serv.KM/Miles");
                        if Ev2Dec < Ev1Dec then
                            Rec."Resource Las serv.KM/Miles" := ResourceRec."Last serv. KM/Oper. hours";
                    end;
                end;
                "Resource Name" := ResourceRec.Name;
                UpdateLines();
            end;
        }
        field(31; "Resource Name"; Text[100])
        {
            Caption = 'Resource Name', Comment = 'HUN: Erőforrás neve';
            DataClassification = CustomerContent;
        }
        field(32; "Resource Location Code"; Code[10])
        {
            Caption = 'Location Code', Comment = 'HUN: Telephely kód';
            FieldClass = FlowField;
            CalcFormula = lookup(Resource."Location No." where("No." = field("Resource No.")));
        }
        field(33; "Resource Las serv.KM/Miles"; Text[30])
        {
            Caption = 'Last Serv. KM/Miles', Comment = 'HUN: Utolsó szerviz KM';
            DataClassification = CustomerContent;
        }
        field(34; "Resource Chassis Number"; Text[250])
        {
            Caption = 'Chassis Number', Comment = 'HUN: Alvázszám';
            FieldClass = FlowField;
            CalcFormula = lookup(Resource."Chassis number" where("No." = field("Resource No.")));
        }
        field(35; "Resource Engine Number"; Text[250])
        {
            Caption = 'Engine Number', Comment = 'HUN: Motorszám';
            FieldClass = FlowField;
            CalcFormula = lookup(Resource."Engine number" where("No." = field("Resource No.")));
        }
        field(36; "Resource Bridge Number"; Text[250])
        {
            Caption = 'Bridge Number', Comment = 'HUN: Hídszám';
            FieldClass = FlowField;
            CalcFormula = lookup(Resource."Bridge number" where("No." = field("Resource No.")));
        }
        field(37; "Resource Machine Number"; Text[250])
        {
            Caption = 'Machine Number', Comment = 'HUN: Gép szám';
            FieldClass = FlowField;
            CalcFormula = lookup(Resource."Machine number" where("No." = field("Resource No.")));
        }
        field(38; "Resource Weight"; Decimal)
        {
            Caption = 'Weight', Comment = 'HUN: Tömeg';
            FieldClass = FlowField;
            CalcFormula = lookup(Resource.Weight where("No." = field("Resource No.")));
        }
        field(39; "Resource Years"; Integer)
        {
            Caption = 'Years', Comment = 'HUN: Évek';
            FieldClass = FlowField;
            CalcFormula = lookup(Resource.Years where("No." = field("Resource No.")));
        }
        field(50; "Other Comment"; Text[100])
        {
            Caption = 'Other Comment', Comment = 'HUN: Egyéb megjegyzés';
            DataClassification = CustomerContent;
        }
        field(60; "Document Date"; Date)
        {
            Caption = 'Document Date', Comment = 'HUN: Bizonylat dátuma';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if Rec."Document Date" <> xRec."Document Date" then
                    UpdateLines();
            end;
        }
        field(70; "Service Fault Description"; Text[250])
        {
            Caption = 'Service Fault Description', Comment = 'HUN: Hiba leírás';
            DataClassification = CustomerContent;
        }
        field(80; "Service Work Description"; Text[250])
        {
            Caption = 'Service Work Description', Comment = 'HUN: Elvégzett munka leírás';
            DataClassification = CustomerContent;
        }
        field(90; "Service Type"; Code[20])
        {
            Caption = 'Service Type', Comment = 'HUN: Szerviz típus';
            DataClassification = CustomerContent;
            TableRelation = "CCI Service Type"."Code";
        }
        field(91; "Service Type Description"; Text[250])
        {
            Caption = 'Service Type Description', Comment = 'HUN: Szerviz típus leírás';
            FieldClass = FlowField;
            CalcFormula = lookup("CCI Service Type".Description where("Code" = field("Service Type")));
        }
        field(100; "Finished Date"; Date)
        {
            Caption = 'Finished Date', Comment = 'HUN: Befejezés dátuma';
            DataClassification = CustomerContent;
            Editable = false;
            trigger OnValidate()
            begin
                if Rec."Finished Date" <> xRec."Finished Date" then
                    UpdateLines();
            end;
        }
        field(110; "Posting Description"; Text[100])
        {
            Caption = 'Posting Description', Comment = 'HUN: Könyvelési leírás';
            DataClassification = CustomerContent;
        }
        field(120; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code', Comment = 'HUN: Rövidített dimenzió 1 kód';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), Blocked = const(false));
        }
        field(130; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code', Comment = 'HUN: Rövidített dimenzió 2 kód';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), Blocked = const(false));
        }
        field(140; "No. Series"; Code[20])
        {
            Caption = 'No. Series', Comment = 'HUN: Számsorozat';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(160; Status; Enum "CCI Service Status")
        {
            Caption = 'Status', Comment = 'HUN: Állapot';
            DataClassification = CustomerContent;
        }
        field(170; "Expected Finished Date"; Date)
        {
            Caption = 'Expected Finished Date', Comment = 'HUN: Várható befejezés dátuma';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if Rec."Expected Finished Date" <> xRec."Expected Finished Date" then
                    UpdateLines();
            end;
        }
        field(180; "Repair Location"; Code[10])
        {
            Caption = 'Repair Location', Comment = 'HUN: Javítás helye';
            DataClassification = CustomerContent;
            TableRelation = Location.Code where("Location Type" = filter(<> "Gas station" & <> "Mobile gas station"));
        }
        field(205; "Workshop Order"; Boolean)
        {
            Caption = 'Workshop Order', Comment = 'HUN: Műhelyi rendelés';
            DataClassification = CustomerContent;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID', Comment = 'HUN: Dimenzió készlet azonosító';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                Rec.ShowDocDim();
            end;

            trigger OnValidate()
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;
        }
    }
    keys
    {
        key(PK; "Document Type", "No.")
        {
            Clustered = true;
        }
        key(Key50000; "Document Date") { }
    }

    trigger OnInsert()
    begin
        InitRecord();
    end;

    trigger OnModify()
    begin
        UpdateLines();
    end;

    var
        JobSetup: Record "Jobs Setup";
        ServHeader: Record "CCI Service Header";
        DimMgt: Codeunit DimensionManagement;
        NoSeries: Codeunit "No. Series";
        Text001: Label 'The service %1 %2 already exists.', Comment = '%1=Document type format;%2=Number; | HUN: A szerviz %1 %2 már létezik.';

    procedure GetJobSetup()
    begin
        JobSetup.Get();
    end;

    procedure InitRecord()
    begin
        GetJobSetup();
        SetDefaultNoSeries();
        "Document Date" := Today;
    end;

    local procedure SetDefaultNoSeries()
    var
        UserSetup: Record "User Setup";
    begin
        "Document Type" := "Document Type"::Order;
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId);
        if (not UserSetup.FindFirst()) or (not UserSetup."Workshop employee") then
            "No. Series" := JobSetup."CCI Service Order Nos."
        else begin
            "No. Series" := JobSetup."CCI Workshop Order Nos.";
            "Workshop Order" := true;
        end;
        "No." := NoSeries.GetNextNo("No. Series", "Document Date");
    end;

    local procedure TestNoSeriesManual()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId);
        if (not UserSetup.FindFirst()) or (not UserSetup."Workshop employee") then
            NoSeries.TestManual(JobSetup."CCI Service Order Nos.")
        else
            NoSeries.TestManual(JobSetup."CCI Workshop Order Nos.");
    end;

    procedure ShowDocDim()
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
            DimMgt.EditDimensionSet(
                Rec, "Dimension Set ID", StrSubstNo('%1 %2', "Document Type", "No."),
                "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        if OldDimSetID <> "Dimension Set ID" then
            Modify();
    end;

    procedure AssistEdit(OldServHeader: Record "CCI Service Header"): Boolean
    var
        ServHeader2: Record "CCI Service Header";
    begin
        ServHeader.Copy(Rec);
        ServHeader.GetJobSetup();
        if NoSeries.LookupRelatedNoSeries(ServHeader.GetNoSeriesCode(), OldServHeader."No. Series", ServHeader."No. Series") then begin
            ServHeader."No." := NoSeries.GetNextNo(ServHeader."No. Series");
            if ServHeader2.Get(ServHeader."Document Type", ServHeader."No.") then
                Error(Text001, LowerCase(Format(ServHeader."Document Type")), ServHeader."No.");
            Rec := ServHeader;
            exit(true);
        end;
    end;

    procedure GetNoSeriesCode(): Code[20]
    begin
        exit(JobSetup."CCI Service Order Nos.");
    end;

    local procedure UpdateLines()
    var
        ServiceLine: Record "CCI Service Line";
    begin
        if Rec."Resource No." <> xRec."Resource No." then begin
            ServiceLine.SetLoadFields("Resource No.", "Resource Name");
            ServiceLine.Reset();
            ServiceLine.SetRange("Document Type", Rec."Document Type");
            ServiceLine.SetRange("Document No.", Rec."No.");
            if ServiceLine.FindSet(true) then
                repeat
                    ServiceLine."Resource No." := Rec."Resource No.";
                    ServiceLine."Resource Name" := Rec."Resource Name";
                    ServiceLine.Modify(true);
                until ServiceLine.Next() = 0;
        end;

        if Rec."Document Date" <> xRec."Document Date" then begin
            ServiceLine.Reset();
            ServiceLine.SetLoadFields("Document Date");
            ServiceLine.SetRange("Document Type", Rec."Document Type");
            ServiceLine.SetRange("Document No.", Rec."No.");
            ServiceLine.SetRange(Posted, false);
            if ServiceLine.FindSet(true) then
                repeat
                    ServiceLine."Document Date" := Rec."Document Date";
                    ServiceLine.Modify(true);
                until ServiceLine.Next() = 0;
        end;

        if Rec."Finished Date" <> xRec."Finished Date" then begin
            ServiceLine.Reset();
            ServiceLine.SetLoadFields("Finished Date");
            ServiceLine.SetRange("Document Type", Rec."Document Type");
            ServiceLine.SetRange("Document No.", Rec."No.");
            ServiceLine.SetRange(Posted, false);
            if ServiceLine.FindSet(true) then
                repeat
                    ServiceLine."Finished Date" := Rec."Finished Date";
                    ServiceLine.Modify(true);
                until ServiceLine.Next() = 0;
        end;

        if Rec."Expected Finished Date" <> xRec."Expected Finished Date" then begin
            ServiceLine.Reset();
            ServiceLine.SetLoadFields("Expected Finished Date");
            ServiceLine.SetRange("Document Type", Rec."Document Type");
            ServiceLine.SetRange("Document No.", Rec."No.");
            ServiceLine.SetRange(Posted, false);
            if ServiceLine.FindSet(true) then
                repeat
                    ServiceLine."Expected Finished Date" := Rec."Expected Finished Date";
                    ServiceLine.Modify(true);
                until ServiceLine.Next() = 0;
        end;
    end;
}
