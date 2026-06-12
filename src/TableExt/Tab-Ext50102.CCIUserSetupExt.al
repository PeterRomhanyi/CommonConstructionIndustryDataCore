namespace Loginform.CommonConstructionIndustryDataCore;

using Microsoft.Inventory.Location;
using System.Security.User;
using System.Security.AccessControl;

tableextension 50102 "CCI User Setup Ext" extends "User Setup"
{
    fields
    {
        field(50000; "Default warehouse code"; Code[10])
        {
            Caption = 'Default warehouse code', Comment = 'HUN: Alapértelmezett raktárkód';
            DataClassification = CustomerContent;
            Description = '#Mobile, #Service';
            TableRelation = Location.Code;
        }
        field(50010; "Powerapps View Filter"; Option)
        {
            Caption = 'Powerapps View Filter', Comment = 'HUN: PowerApps nézet szűrő';
            DataClassification = CustomerContent;
            Description = '#Mobile';
            //ToDo: Change to ENUM;
            OptionMembers = Project,Mine,Service,Center,TESZT,Porta,Fueling;
            OptionCaption = 'Project,Mine,Service,Center,TESZT,Porta,Fueling', Comment = 'HUN: Projekt,Bánya,Szerviz,Központ,TESZT,Porta,Tankolás';
        }
        field(50020; JobGroupcode; Code[20])
        {
            Caption = 'Project Group code', Comment = 'HUN: Projekt csoport kód';
            DataClassification = CustomerContent;
            Description = '#Mobile';
            TableRelation = "CCI Job Group"."Code";
        }
        field(50030; "Administration / salary View"; Boolean)
        {
            Caption = 'Administration / salary View', Comment = 'HUN: Adminisztrációs / bér nézet';
            DataClassification = CustomerContent;
            Description = '#DataCore, #HR';
        }
        field(50040; "PO Substitute"; Code[50])
        {
            Caption = 'PO Substitute', Comment = 'HUN: BM helyettes';
            DataClassification = CustomerContent;
            Description = '#DataCore';
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }
        field(50050; "Allow to ReOpen Service Order"; Boolean)
        {
            Caption = 'Allow to ReOpen Service Order', Comment = 'HUN: Szerviz rendelés újranyitás engedélyezése';
            DataClassification = CustomerContent;
            Description = '#Service';
        }
        field(50060; "View personal data"; Boolean)
        {
            Caption = 'View personal data', Comment = 'HUN: Személyes adatok megtekintése';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50070; EmployeeView; Boolean)
        {
            Caption = 'Employee View', Comment = 'HUN: Alkalmazott nézet';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50080; ManualSaleryEdit; Boolean)
        {
            Caption = 'Manual Salary Edit', Comment = 'HUN: Manuális bérszerkesztés';
            DataClassification = CustomerContent;
            Description = '#DataCore, #HR';
        }
        field(50090; "Email notif. Tech. com. Exp."; Boolean)
        {
            Caption = 'Email notification about technical commissioning expired', Comment = 'HUN: E-mail értesítés lejárt műszaki üzembe helyezésről';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50100; "Email notif. Subtraction"; Boolean)
        {
            Caption = 'Email notification about Subtraction', Comment = 'HUN: E-mail értesítés kivonásról';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50110; "Email notif. Tach. validity"; Boolean)
        {
            Caption = 'Email notification about Tachograph validity', Comment = 'HUN: E-mail értesítés tachográf érvényességről';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50120; "Email notif. Inventory"; Boolean)
        {
            Caption = 'Email notification about Inventory', Comment = 'HUN: E-mail értesítés készletről';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50121; "Location Filter for Inventory"; Code[10])
        {
            Caption = 'Location Filter for Email notification about Inventory', Comment = 'HUN: Telephely szűrő a készlet e-mail értesítéshez';
            DataClassification = CustomerContent;
            Description = '#DataCore';
            TableRelation = Location.Code where("Location Type" = const(Mine));
        }
        field(50122; "Workshop employee"; Boolean)
        {
            Caption = 'Workshop employee', Comment = 'HUN: Műhelyi alkalmazott';
            DataClassification = CustomerContent;
            Description = '#Service';
        }
        field(50130; "Powerapps Email"; Text[100])
        {
            Caption = 'Powerapps Email', Comment = 'HUN: PowerApps e-mail cím';
            DataClassification = CustomerContent;
            Description = '#Mobile';
        }
    }

    trigger OnBeforeModify()
    var
        EditError: Label 'You cannot change the setting!', Comment = 'HUN: Nem módosíthatja a beállítást!';
    begin
        //ToDo: Change to check if the user is in the role of BCADMIN instead of checking the user name;
        if UserId <> 'BCADMIN' then
            Error(EditError);
    end;

    trigger OnBeforeRename()
    var
        EditError: Label 'You cannot change the setting!', Comment = 'HUN: Nem módosíthatja a beállítást!';
    begin
        //ToDo: Change to check if the user is in the role of BCADMIN instead of checking the user name;
        if UserId <> 'BCADMIN' then
            Error(EditError);
    end;

    trigger OnBeforeInsert()
    var
        EditError: Label 'You cannot create a new row!', Comment = 'HUN: Nem hozhat létre új sort!';
    begin
        //ToDo: Change to check if the user is in the role of BCADMIN instead of checking the user name;
        if UserId <> 'BCADMIN' then
            Error(EditError);
    end;

    trigger OnBeforeDelete()
    var
        EditError: Label 'You cannot delete an existing row!', Comment = 'HUN: Nem törölhet meglévő sort!';
    begin
        //ToDo: Change to check if the user is in the role of BCADMIN instead of checking the user name;
        if UserId <> 'BCADMIN' then
            Error(EditError);
    end;
}
