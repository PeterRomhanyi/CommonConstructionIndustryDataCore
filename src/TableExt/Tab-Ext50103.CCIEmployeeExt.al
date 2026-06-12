namespace Loginform.CommonConstructionIndustryDataCore;

using Microsoft.Projects.Resources.Resource;
using Microsoft.HumanResources.Employee;
using Microsoft.Inventory.Item;
using Microsoft.Foundation.Address;
using Microsoft.Foundation.UOM;

tableextension 50103 "CCI Employee Ext" extends Employee
{
    fields
    {
        field(50000; "Mothers name"; Text[100])
        {
            Caption = 'Mothers name', Comment = 'HUN: Anyja neve';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50010; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.', Comment = 'HUN: Adóazonosító';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50030; GYED; Boolean)
        {
            Caption = 'GYED', Comment = 'HUN: GYED';
            DataClassification = CustomerContent;
            Description = '#DataCore, #HR';
        }
        field(50040; CSED; Boolean)
        {
            Caption = 'CSED', Comment = 'HUN: CSED';
            DataClassification = CustomerContent;
            Description = '#DataCore, #HR';
        }
        field(50050; "Family tax relief"; Boolean)
        {
            Caption = 'Family tax relief', Comment = 'HUN: Családi adókedvezmény';
            DataClassification = CustomerContent;
            Description = '#DataCore, #HR';
        }
        field(50060; "License plate number"; Code[100])
        {
            Caption = 'License plate number', Comment = 'HUN: Rendszám';
            DataClassification = CustomerContent;
            Description = '#DataCore';
            TableRelation = Resource."No." where(Type = const(Machine), Blocked = const(false));
        }
        field(50065; "License plate number text"; Text[100])
        {
            Caption = 'License plate number text', Comment = 'HUN: Rendszám szöveg';
            FieldClass = FlowField;
            CalcFormula = lookup(Resource.Name where("No." = field("License plate number")));
            Description = '#DataCore';
        }
        field(50070; "Fuel contribution"; Decimal)
        {
            Caption = 'Fuel contribution (L)', Comment = 'HUN: Üzemanyag hozzájárulás (L)';
            DataClassification = CustomerContent;
            Description = '#DataCore';
            DecimalPlaces = 1 : 1;
        }
        field(50080; "KM contribution"; Decimal)
        {
            Caption = 'KM contribution (KM)', Comment = 'HUN: KM hozzájárulás (KM)';
            DataClassification = CustomerContent;
            Description = '#DataCore';
            DecimalPlaces = 0 : 1;
        }
        field(50090; "Base Unit of Measure"; Code[10])
        {
            Caption = 'Base Unit of Measure', Comment = 'HUN: Alapmértékegység';
            DataClassification = CustomerContent;
            Description = '#DataCore';
            TableRelation = "Unit of Measure".Code;
        }
        field(50100; GenderOF; Option)
        {
            Caption = 'Gender', Comment = 'HUN: Nem';
            DataClassification = CustomerContent;
            Description = '#DataCore';
            //ToDo: Change to ENUM;
            OptionMembers = "Male","Female";
            OptionCaption = 'Male,Female', Comment = 'HUN: Férfi,Nő';
        }
        field(50120; "Job title Description"; Text[100])
        {
            Caption = 'Job title Description', Comment = 'HUN: Beosztás leírás';
            CalcFormula = lookup("CCI Job Title".Description where("No." = field("Job Title")));
            FieldClass = FlowField;
            Description = '#DataCore';

        }
        field(50130; "Exit date"; Date)
        {
            Caption = 'Exit Date', Comment = 'HUN: Kilépés dátuma';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50140; "Wage type"; Option)
        {
            Caption = 'Wage type', Comment = 'HUN: Bérezés típusa';
            DataClassification = CustomerContent;
            Description = '#DataCore, #Mobile, #HR';
            //ToDo: Change to ENUM;
            OptionMembers = "Hourly wage","Daily fee",Fixed;
            OptionCaption = 'Hourly wage,Daily fee,Fixed', Comment = 'HUN: Órabér,Napidíj,Fix';
        }
        field(50150; "Base salary"; Decimal)
        {
            Caption = 'Base salary', Comment = 'HUN: Alapbér';
            DataClassification = CustomerContent;
            Description = '#HR';
        }
        field(50160; "Auxiliary worker hourly wage"; Decimal)
        {
            Caption = 'Auxiliary worker hourly wage (Net)', Comment = 'HUN: Segédmunkás órabér (nettó)';
            DataClassification = CustomerContent;
            Description = '#HR';
        }
        field(50170; "Assembly hourly wage"; Decimal)
        {
            Caption = 'Assembly hourly wage (Net)', Comment = 'HUN: Szerelési órabér (nettó)';
            DataClassification = CustomerContent;
            Description = '#HR';
        }
        field(50180; "Waiting hourly wage"; Decimal)
        {
            Caption = 'Waiting hourly wage (Net)', Comment = 'HUN: Várakozási órabér (nettó)';
            DataClassification = CustomerContent;
            Description = '#HR';
        }
        field(50190; Separation; Boolean)
        {
            Caption = 'Separation', Comment = 'HUN: Különélés';
            DataClassification = CustomerContent;
            Description = '#HR';
        }
        field(50200; "Separation Amount"; Decimal)
        {
            Caption = 'Separation Amount (Net)', Comment = 'HUN: Különélési összeg (nettó)';
            DataClassification = CustomerContent;
            Description = '#HR';
        }
        field(50210; "Other fees"; Decimal)
        {
            Caption = 'Other fees (Net)', Comment = 'HUN: Egyéb díjak (nettó)';
            DataClassification = CustomerContent;
            Description = '#HR';
        }
        field(50220; "Residence address"; Text[100])
        {
            Caption = 'Residence address', Comment = 'HUN: Lakcím';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50230; "Residence address 2"; Text[100])
        {
            Caption = 'Residence address 2', Comment = 'HUN: Lakcím 2';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50240; "Residence City"; Text[30])
        {
            Caption = 'Residence City', Comment = 'HUN: Lakóváros';
            DataClassification = CustomerContent;
            Description = '#DataCore';
            TableRelation = if ("Residence Post Code" = const('')) "Post Code".City
            else
            if ("Residence Post Code" = filter(<> '')) "Post Code".City where("Country/Region Code" = field("Residence Post Code"));
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                PostCode.LookupPostCode(Rec.City, Rec."Post Code", Rec.County, Rec."Residence Post Code");
            end;
        }
        field(50250; "Residence Post Code"; Code[20])
        {
            Caption = 'Residence Post Code', Comment = 'HUN: Lakóirányítószám';
            DataClassification = CustomerContent;
            Description = '#DataCore';
            TableRelation = if ("Residence Post Code" = const('')) "Post Code"
            else
            if ("Residence Post Code" = filter(<> '')) "Post Code" where("Country/Region Code" = field("Residence Post Code"));
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                PostCode.LookupPostCode(Rec.City, Rec."Post Code", Rec.County, Rec."Country/Region Code");
            end;
        }
        field(50260; "Residence Country/Region Code"; Code[10])
        {
            Caption = 'Residence Country/Region Code', Comment = 'HUN: Lakcím ország/régió kód';
            DataClassification = CustomerContent;
            Description = '#DataCore';
            TableRelation = "Country/Region";
        }
        field(50270; "Place of birth"; Text[30])
        {
            Caption = 'Place of birth', Comment = 'HUN: Születési hely';
            DataClassification = CustomerContent;
            Description = '#DataCore';
            TableRelation = "Post Code".City;
        }
        field(50280; "Bank account number"; Text[50])
        {
            Caption = 'Bank account number', Comment = 'HUN: Bankszámlaszám';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50290; "Stat classification"; Option)
        {
            Caption = 'Stat classification', Comment = 'HUN: Statisztikai besorolás';
            DataClassification = CustomerContent;
            Description = '#DataCore';
            //ToDo: Change to ENUM;
            OptionMembers = "Full-Physical","Full-Mental","Part-Physical","Pars-Mental","Outside of statistics";
            OptionCaption = 'Full-time Physical, Full-time Mental, Part-time Physical, Part-time Mental, Outside of statistics', Comment = 'HUN: Teljes munkaidős fizikai, Teljes munkaidős szellemi, Részmunkaidős fizikai, Részmunkaidős szellemi, Statisztikán kívüli';
        }
        field(50300; ManualSaleryCalc; Boolean)
        {
            Caption = 'Manual Salary Calculate', Comment = 'HUN: Manuális bérszámítás';
            DataClassification = CustomerContent;
            Description = '#DataCore, #HR';
        }
        modify("Job Title")
        {
            TableRelation = "CCI Job Title"."No.";

            trigger OnAfterValidate()
            var
                Connection: Record "CCI Job Title Item Connection";
                IssuedEquipment: Record "CCI Employee Issued Equipment";
            begin
                Connection.Reset();
                Connection.SetRange("Job Title", Rec."Job Title");
                if Connection.FindSet() then
                    repeat
                        IssuedEquipment.Reset();
                        IssuedEquipment.SetRange("Item No.", Connection."Item No.");
                        //ToDo: check if it is missingIssuedEquipment.SetRange("Employee No.", Rec."No.");
                        if not IssuedEquipment.FindFirst() then begin
                            IssuedEquipment.Init();
                            IssuedEquipment."Employee No." := Rec."No.";
                            IssuedEquipment.Validate("Item No.", Connection."Item No.");
                            IssuedEquipment.Insert();
                        end;
                    until Connection.Next() = 0;
            end;
        }
        modify("Last Name")
        {
            trigger OnAfterValidate()
            begin
                Rec."Search Name" := Rec."Last Name" + ' ' + Rec."First Name";
            end;
        }
        modify("First Name")
        {
            trigger OnAfterValidate()
            begin
                Rec."Search Name" := Rec."Last Name" + ' ' + Rec."First Name";
            end;
        }
    }

    trigger OnBeforeInsert()
    begin
        CheckDuplicateSearchName();
    end;

    trigger OnBeforeModify()
    begin
        if Rec."Search Name" <> xRec."Search Name" then
            CheckDuplicateSearchName();
    end;

    local procedure CheckDuplicateSearchName()
    var
        OtherEmployee: Record Employee;
    begin
        if Rec."Search Name" = '' then
            exit;
        OtherEmployee.SetRange("Search Name", Rec."Search Name");
        OtherEmployee.SetFilter("No.", '<>%1', Rec."No.");
        if OtherEmployee.FindFirst() then
            Message(StrSubstNo(DuplicateEmployeeQst, OtherEmployee."No."));
    end;

    var
        PostCode: Record "Post Code";
        DuplicateEmployeeQst: Label 'An employee with this name already exists with No. %1. Please modify the search name!', Comment = '%1=Employee No.; | HUN: A %1 számú kartonon már van ilyen nevű alkalmazott. Kérem módosítsa a keresőnevet!';
}
