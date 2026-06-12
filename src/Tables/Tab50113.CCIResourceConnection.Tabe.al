namespace Loginform.CommonConstructionIndustryDataCore;

using Microsoft.Projects.Resources.Resource;

table 50113 "CCI Resource Connection"
{
    Access = Public;
    Caption = 'Resource Connection', Comment = 'HUN: Erőforrás kapcsolat';
    DataClassification = CustomerContent;
    Description = '#DataCore';
    Extensible = true;

    fields
    {
        field(10; "Person Resource"; Code[20])
        {
            Caption = 'Person Resource', Comment = 'HUN: Személy erőforrás';
            DataClassification = CustomerContent;
            TableRelation = Resource."No." where(Type = const(Person));
        }
        field(15; "Person Resource Name"; Text[100])
        {
            Caption = 'Person Resource Name', Comment = 'HUN: Személy erőforrás neve';
            FieldClass = FlowField;
            CalcFormula = lookup(Resource."Search Name" where("No." = field("Person Resource")));
            Editable = false;
        }
        field(20; "Machine Resource"; Code[20])
        {
            Caption = 'Machine Resource', Comment = 'HUN: Gép erőforrás';
            DataClassification = CustomerContent;
            TableRelation = Resource."No." where(Type = const(Machine));
        }
        field(25; "Machine Resource Name"; Text[100])
        {
            Caption = 'Machine Resource Name', Comment = 'HUN: Gép erőforrás neve';
            FieldClass = FlowField;
            CalcFormula = lookup(Resource."Search Name" where("No." = field("Machine Resource")));
            Editable = false;
        }
        field(30; Description; Text[250])
        {
            Caption = 'Description', Comment = 'HUN: Leírás';
            DataClassification = CustomerContent;
        }
        field(40; "Create Date"; Date)
        {
            Caption = 'Create Date', Comment = 'HUN: Létrehozás dátuma';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Person Resource", "Machine Resource")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        Rec."Create Date" := Today;
    end;
}
