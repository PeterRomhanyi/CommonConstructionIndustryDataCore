namespace Loginform.CommonConstructionIndustryDataCore;

using Microsoft.Purchases.Document;
using Microsoft.Inventory.Item;
using System.Security.User;

tableextension 50111 "CCI Purchase Line Ext" extends "Purchase Line"
{
    fields
    {
        field(50000; "Quantity received by warehouse"; Decimal)
        {
            Caption = 'Quantity received by warehouse', Comment = 'HUN: Raktár által átvett mennyiség';
            DataClassification = CustomerContent;
            Description = '#Mobile';
        }
        field(50220; "Item 2"; Text[50])
        {
            Caption = 'Item 2', Comment = 'HUN: Cikk 2';
            DataClassification = CustomerContent;
            Description = '#DataCore';
            Editable = false;
            OptimizeForTextSearch = true;
        }
        field(50230; "Item 3"; Text[50])
        {
            Caption = 'Item 3', Comment = 'HUN: Cikk 3';
            OptimizeForTextSearch = true;
            DataClassification = CustomerContent;
            Description = '#DataCore';
            Editable = false;
        }
        field(50240; "Common Item No."; Code[20])
        {
            Caption = 'Common Item No.', Comment = 'HUN: Közös cikkszám';
            DataClassification = CustomerContent;
            Description = '#DataCore';
            Editable = false;
            OptimizeForTextSearch = true;
        }
        field(50250; "Service Document No."; Code[20])
        {
            Caption = 'Service Document No.', Comment = 'HUN: Szerviz bizonylat szám';
            DataClassification = CustomerContent;
            Description = '#Service';
            Editable = false;
            TableRelation = "CCI Service Header"."No." where("Document Type" = const(Order), Status = filter(Open));
        }
        field(50260; "Service Line No."; Integer)
        {
            Caption = 'Service Line No.', Comment = 'HUN: Szerviz sor szám';
            DataClassification = CustomerContent;
            Description = '#Service';
            TableRelation = "CCI Service Line"."Line No." where("Document Type" = const(Order), Status = filter(Open), "No." = field("No."), Type = const(Item));

            trigger OnValidate()
            var
                ServiceLine: Record "CCI Service Line";
            begin
                if "Service Line No." <> 0 then begin
                    ServiceLine.Reset();
                    ServiceLine.Get(ServiceLine."Document Type"::Order, Rec."Service Document No.", Rec."Service Line No.");
                    ServiceLine.TestField(Status, ServiceLine.Status::Open);
                    ServiceLine.TestField(Type, ServiceLine.Type::Item);
                    ServiceLine.TestField("No.", Rec."No.");
                end
                else
                    Rec."Service Document No." := '';
            end;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                UserSetupRec_: Record "User Setup";
            begin
                if "Document Type" = "Document Type"::Order then
                    if UserSetupRec_.Get(UserId) then
                        Validate("Location Code", UserSetupRec_."Default warehouse code");
            end;
        }
    }
}
