namespace Loginform.CommonConstructionIndustryDataCore;

using Microsoft.Inventory.Item;
using Microsoft.Projects.Resources.Resource;
using Microsoft.Inventory.Location;
using Microsoft.Foundation.UOM;
using Microsoft.Inventory.Tracking;
using Microsoft.Utilities;
using System.Environment.Configuration;
using System.Security.User;

table 50108 "CCI Service Line"
{
    Access = Public;
    Caption = 'Service Line', Comment = 'HUN: Szerviz sor';
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
        field(20; "Resource No."; Code[20])
        {
            Caption = 'Resource No.', Comment = 'HUN: Erőforrás szám';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(21; "Resource Name"; Text[100])
        {
            Caption = 'Resource Name', Comment = 'HUN: Erőforrás neve';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(30; "Document No."; Code[20])
        {
            Caption = 'Document No.', Comment = 'HUN: Bizonylat szám';
            DataClassification = CustomerContent;
            TableRelation = "CCI Service Header"."No." where("Document Type" = field("Document Type"));
        }
        field(40; "Line No."; Integer)
        {
            Caption = 'Line No.', Comment = 'HUN: Sor szám';
            DataClassification = CustomerContent;
        }
        field(50; Type; Enum "CCI Service Line Type")
        {
            Caption = 'Type', Comment = 'HUN: Típus';
            DataClassification = CustomerContent;
        }
        field(60; "No."; Code[20])
        {
            Caption = 'No.', Comment = 'HUN: Szám';
            DataClassification = CustomerContent;
            TableRelation = if (Type = const(" ")) "Standard Text"
            else
            if (Type = const(Item)) Item where(Blocked = const(false), "Service Blocked" = const(false), "Item Category Code" = filter('ALKATRÉSZ|LAKATOS ANYAGOK'))
            else
            if (Type = const(Resource)) Resource;

            trigger OnValidate()
            begin
                TestStatusOpen();
                ClearFields();
                if "No." = '' then
                    exit;
                GetServHeader();
                InitHeaderDefaults(ServHeader);
                case Type of
                    Type::" ":
                        CopyFromStdTxt();
                    Type::Item:
                        CopyFromItem();
                    Type::Resource:
                        CopyFromResource();
                end;
                if ServiceLine.Get("Document Type", "Document No.", "Line No.") then
                    Modify();
            end;
        }
        field(70; "Location Code"; Code[10])
        {
            Caption = 'Location Code', Comment = 'HUN: Telephely kód';
            DataClassification = CustomerContent;
            TableRelation = Location;

            trigger OnValidate()
            begin
                TestStatusOpen();
                GetServHeader();
            end;
        }
        field(80; Description; Text[100])
        {
            Caption = 'Description', Comment = 'HUN: Leírás';
            DataClassification = CustomerContent;
        }
        field(81; "Description 2"; Text[50])
        {
            Caption = 'Description 2', Comment = 'HUN: Leírás 2';
            DataClassification = CustomerContent;
        }
        field(90; "Unit of Measure"; Text[50])
        {
            Caption = 'Unit of Measure', Comment = 'HUN: Mértékegység';
            DataClassification = CustomerContent;
        }
        field(100; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code', Comment = 'HUN: Mértékegység kód';
            DataClassification = CustomerContent;
            TableRelation = if (Type = const(Item)) "Item Unit of Measure".Code where("Item No." = field("No."))
            else
            if (Type = const(Resource)) "Resource Unit of Measure".Code where("Resource No." = field("No."))
            else
            "Unit of Measure";

            trigger OnValidate()
            var
                UnitOfMeasureRec: Record "Unit of Measure";
            begin
                TestStatusOpen();
                if "Unit of Measure Code" = '' then
                    "Unit of Measure" := ''
                else begin
                    if not UnitOfMeasureRec.Get("Unit of Measure Code") then
                        UnitOfMeasureRec.Init();
                    "Unit of Measure" := UnitOfMeasureRec.Description;
                    GetServHeader();
                end;
            end;
        }
        field(110; Quantity; Decimal)
        {
            Caption = 'Quantity', Comment = 'HUN: Mennyiség';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                GetServHeader();
                TestField(Type);
                TestField("No.");
                TestStatusOpen();
                Quantity := UOMMgt.RoundAndValidateQty(Quantity, "Qty. Rounding Precision", FieldCaption(Quantity));
                UpdateAmount();
            end;
        }
        field(111; "Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost (LCY)', Comment = 'HUN: Egységköltség (HUF)';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                UpdateAmount();
            end;
        }
        field(112; "Line Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Line Amount', Comment = 'HUN: Sor összeg';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(120; "Qty. Rounding Precision"; Decimal)
        {
            Caption = 'Qty. Rounding Precision', Comment = 'HUN: Mennyiség kerekítési pontosság';
            DataClassification = CustomerContent;
            InitValue = 0;
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            MaxValue = 1;
            Editable = false;
        }
        field(130; "Qty. Rounding Precision (Base)"; Decimal)
        {
            Caption = 'Qty. Rounding Precision (Base)', Comment = 'HUN: Mennyiség kerekítési pontosság (alap)';
            DataClassification = CustomerContent;
            InitValue = 0;
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            MaxValue = 1;
            Editable = false;
        }
        field(160; Status; Enum "CCI Service Status")
        {
            Caption = 'Status', Comment = 'HUN: Állapot';
            FieldClass = FlowField;
            CalcFormula = lookup("CCI Service Header".Status where("Document Type" = field("Document Type"), "No." = field("Document No.")));
            Editable = false;
        }
        field(200; Posted; Boolean)
        {
            Caption = 'Posted', Comment = 'HUN: Könyvelve';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(205; "Workshop Order"; Boolean)
        {
            Caption = 'Workshop Order', Comment = 'HUN: Műhelyi rendelés';
            DataClassification = CustomerContent;
        }
        field(210; "Job Ledger Entry No."; Integer)
        {
            Caption = 'Job Ledger Entry No.', Comment = 'HUN: Projekt főkönyvi tétel sz.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(220; "Item Comment"; Text[100])
        {
            Caption = 'Item Comment', Comment = 'HUN: Cikk megjegyzés';
            FieldClass = FlowField;
            CalcFormula = lookup(Item.CommentText where("No." = field("No.")));
            Editable = false;
        }
        field(230; "Comment"; Text[250])
        {
            Caption = 'Comment', Comment = 'HUN: Megjegyzés';
            DataClassification = CustomerContent;
        }
        field(240; "Document Date"; Date)
        {
            Caption = 'Document Date', Comment = 'HUN: Bizonylat dátuma';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(250; "Expected Finished Date"; Date)
        {
            Caption = 'Expected Finished Date', Comment = 'HUN: Várható befejezés';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(260; "Finished Date"; Date)
        {
            Caption = 'Finished Date', Comment = 'HUN: Befejezés dátuma';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(270; "Item 2"; Text[50])
        {
            Caption = 'Item 2', Comment = 'HUN: Cikk 2';
            OptimizeForTextSearch = true;
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(280; "Item 3"; Text[50])
        {
            Caption = 'Item 3', Comment = 'HUN: Cikk 3';
            OptimizeForTextSearch = true;
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(290; "Common Item No."; Code[20])
        {
            Caption = 'Common Item No.', Comment = 'HUN: Közös cikkszám';
            OptimizeForTextSearch = true;
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key50000; "Document Date") { }
    }

    trigger OnDelete()
    begin
        Rec.TestField(Posted, false);
    end;

    var
        ServHeader: Record "CCI Service Header";
        ServiceLine: Record "CCI Service Line";
        UOMMgt: Codeunit "Unit of Measure Management";
        StatusCheckSuspended: Boolean;
        BlockedItemNotificationMsg: Label 'Item %1 is blocked, but it is allowed on this type of document.', Comment = '%1=Item No.; | HUN: A %1 cikk le van zárva, de ezen a bizonylat típuson engedélyezett.';

    procedure TestStatusOpen()
    var
        ServHeaderRec: Record "CCI Service Header";
    begin
        ServHeaderRec.Get(Rec."Document Type", Rec."Document No.");
        if StatusCheckSuspended then
            exit;
        ServHeaderRec.TestField(Status, ServHeaderRec.Status::Open);
    end;

    procedure SuspendStatusCheck(bSuspend: Boolean)
    begin
        StatusCheckSuspended := bSuspend;
    end;

    protected procedure ClearFields()
    var
        TempServLine: Record "CCI Service Line" temporary;
    begin
        TempServLine := Rec;
        Init();
        SystemId := TempServLine.SystemId;
        if CurrFieldNo <> FieldNo(Type) then
            "No." := TempServLine."No.";
        Type := TempServLine.Type;
        if Type <> Type::" " then
            Quantity := TempServLine.Quantity;
        "Line No." := TempServLine."Line No.";
        "Document Type" := TempServLine."Document Type";
        "Document No." := TempServLine."Document No.";
        "Resource No." := TempServLine."Resource No.";
    end;

    procedure GetServHeader(): Record "CCI Service Header"
    begin
        ServHeader.Get(Rec."Document Type", Rec."Document No.");
        exit(ServHeader);
    end;

    local procedure InitHeaderDefaults(ServHeaderRec: Record "CCI Service Header")
    var
        UserSetup: Record "User Setup";
    begin
        "Document Type" := ServHeaderRec."Document Type";
        "Document No." := ServHeaderRec."No.";
        "Resource No." := ServHeaderRec."Resource No.";
        "Resource Name" := ServHeaderRec."Resource Name";
        "Document Date" := ServHeaderRec."Document Date";
        "Expected Finished Date" := ServHeaderRec."Expected Finished Date";
        "Finished Date" := 0D;
        "Workshop Order" := ServHeaderRec."Workshop Order";
        if UserSetup.Get(UserId) then
            if UserSetup."Default warehouse code" <> '' then
                "Location Code" := UserSetup."Default warehouse code";
    end;

    local procedure UpdateAmount()
    begin
        Rec."Line Amount" := Rec.Quantity * Rec."Unit Cost (LCY)";
    end;

    local procedure CopyFromStdTxt()
    var
        StandardText: Record "Standard Text";
    begin
        StandardText.Get("No.");
        Description := StandardText.Description;
    end;

    local procedure CopyFromItem()
    var
        ItemRec: Record Item;
    begin
        GetItem(ItemRec);
        if ItemRec."Service Blocked" then
            SendBlockedItemNotification();
        Description := ItemRec.Description;
        "Description 2" := ItemRec."Description 2";
        if ItemRec."Sales Unit of Measure" <> '' then
            "Unit of Measure Code" := ItemRec."Sales Unit of Measure"
        else
            "Unit of Measure Code" := ItemRec."Base Unit of Measure";
        "Unit Cost (LCY)" := ItemRec."Unit Cost";
        "Item 2" := ItemRec."Item 2";
        "Item 3" := ItemRec."Item 3";
        "Common Item No." := ItemRec."Common Item No.";
    end;

    local procedure CopyFromResource()
    var
        Res: Record Resource;
    begin
        Res.Get("No.");
        Res.CheckResourcePrivacyBlocked(false);
        Res.TestField(Blocked, false);
        Res.TestField("Gen. Prod. Posting Group");
        Description := Res.Name;
        "Description 2" := Res."Name 2";
        if Res."Base Unit of Measure" <> '' then
            "Unit of Measure Code" := Res."Base Unit of Measure";
    end;

    procedure GetItem(var ItemRec: Record Item)
    begin
        TestField("No.");
        ItemRec.Get("No.");
    end;

    local procedure SendBlockedItemNotification()
    var
        NotificationLifecycleMgt: Codeunit "Notification Lifecycle Mgt.";
        NotificationToSend: Notification;
    begin
        NotificationToSend.Id := GetBlockedItemNotificationID();
        NotificationToSend.Recall();
        NotificationToSend.Message := StrSubstNo(BlockedItemNotificationMsg, "No.");
        NotificationLifecycleMgt.SendNotification(NotificationToSend, RecordId);
    end;

    local procedure GetBlockedItemNotificationID(): Guid
    begin
        exit('963A9FD3-11E8-4CAA-BE3A-7F8CEC9EF8EC');
    end;
}
