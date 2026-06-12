namespace Loginform.CommonConstructionIndustryDataCore;

using Microsoft.Inventory.Location;
using Microsoft.HumanResources.Employee;
using Microsoft.Projects.Resources.Resource;

tableextension 50100 "CCI Resource Ext" extends Resource
{
    fields
    {
        field(50000; "Machine operator"; Boolean)
        {
            Caption = 'Machine operator', Comment = 'HUN: Gépkezelő';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50010; "Technical commissioning date"; Date)
        {
            Caption = 'Technical commissioning date', Comment = 'HUN: Műszaki üzembe helyezés dátuma';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50020; "Tech. commissioning expired"; Date)
        {
            Caption = 'Technical commissioning expired', Comment = 'HUN: Műszaki üzembe helyezés lejárata';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50030; Status; Enum "CCI Resource Status")
        {
            Caption = 'Status', Comment = 'HUN: Állapot';
            DataClassification = CustomerContent;
            Description = '#DataCore';
            trigger OnValidate()
            var
                Log: Record "CCI Machine Status Log";
                LogRecx: Record "CCI Machine Status Log";
            begin
                Log.Init();
                Log."Resource No." := Rec."No.";
                LogRecx.Reset();
                LogRecx.SetRange("Resource No.", Rec."No.");
                if LogRecx.FindLast() then
                    Log."Line No." := LogRecx."Line No." + 10000
                else
                    Log."Line No." := 10000;
                Log.Date := Today;
                Log."KM/Operating Hours" := LogRecx."KM/Operating Hours";
                Log.Status := Rec.Status;
                Log.Insert();
            end;
        }
        field(50040; "Location No."; Code[10])
        {
            Caption = 'Location No.', Comment = 'HUN: Telephely';
            DataClassification = CustomerContent;
            Description = '#DataCore, #LIMOL, #LIAR, #Vezénylés';
            TableRelation = Location.Code;
            trigger OnValidate()
            begin
                "Location assignment date" := Today;
            end;
        }
        field(50050; "Location assignment date"; Date)
        {
            Caption = 'Location assignment date', Comment = 'HUN: Telephely hozzárendelés dátuma';
            DataClassification = CustomerContent;
            Description = '#DataCore';
            Editable = false;
        }
        field(50070; "Mandatory insurance expiration"; Date)
        {
            Caption = 'Mandatory insurance expiration', Comment = 'HUN: Kötelező biztosítás lejárata';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50080; "CASCO Insurance policy number"; Code[30])
        {
            Caption = 'CASCO Insurance policy number', Comment = 'HUN: CASCO biztosítás kötvényszám';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50090; "CASCO Insurance expiry"; Date)
        {
            Caption = 'CASCO Insurance expiry', Comment = 'HUN: CASCO biztosítás lejárata';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50100; "Technical exam expiration"; Date)
        {
            Caption = 'Technical exam expiration', Comment = 'HUN: Műszaki vizsga lejárata';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50110; "Traffic license expiration"; Date)
        {
            Caption = 'Traffic license expiration', Comment = 'HUN: Forgalmi engedély lejárata';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50120; "Name of vehicle user"; Text[250])
        {
            Caption = 'Name of vehicle user', Comment = 'HUN: Jármű használójának neve';
            FieldClass = FlowField;
            CalcFormula = lookup(Employee."Search Name" where("License plate number" = field(Name)));
            Description = '#DataCore';
        }
        field(50140; RFID; Text[80])
        {
            Caption = 'RFID', Comment = 'HUN: RFID azonosító';
            DataClassification = CustomerContent;
            Description = '#LIAR';
        }
        field(50150; "E-mail"; Text[80])
        {
            Caption = 'E-mail', Comment = 'HUN: E-mail cím';
            DataClassification = CustomerContent;
            Description = '#Project';
        }
        field(50160; "Warranty start"; Date)
        {
            Caption = 'Warranty start', Comment = 'HUN: Garancia kezdete';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50170; "Warranty ends"; Date)
        {
            Caption = 'Warranty ends', Comment = 'HUN: Garancia lejárata';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50180; "Warranty type"; Text[250])
        {
            Caption = 'Warranty type', Comment = 'HUN: Garancia típusa';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50190; "Maintenance contract"; Text[250])
        {
            Caption = 'Maintenance contract', Comment = 'HUN: Karbantartási szerződés';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50200; "Mand. serv. KM/Oper. hours"; Text[30])
        {
            Caption = 'Mandatory service KM / Operating hours / Year', Comment = 'HUN: Kötelező szerviz KM / üzemóra / év';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50210; "Last serv. KM/Oper. hours"; Text[30])
        {
            Caption = 'Last service KM / Operating hours / Year', Comment = 'HUN: Utolsó szerviz KM / üzemóra / év';
            DataClassification = CustomerContent;
            Description = '#Service';
        }
        field(50220; "Chassis number"; Text[250])
        {
            Caption = 'Chassis number', Comment = 'HUN: Alvázszám';
            DataClassification = CustomerContent;
            Description = '#Service';
        }
        field(50230; "Engine number"; Text[250])
        {
            Caption = 'Engine number', Comment = 'HUN: Motorszám';
            DataClassification = CustomerContent;
            Description = '#Service';
        }
        field(50240; "Bridge number"; Text[250])
        {
            Caption = 'Bridge number', Comment = 'HUN: Hídszám';
            DataClassification = CustomerContent;
            Description = '#Service';
        }
        field(50250; "Machine number"; Text[250])
        {
            Caption = 'Machine number', Comment = 'HUN: Gépszám';
            DataClassification = CustomerContent;
            Description = '#Service';
        }
        field(50260; Weight; Decimal)
        {
            Caption = 'Weight', Comment = 'HUN: Tömeg';
            DataClassification = CustomerContent;
            Description = '#Service';
        }
        field(50270; Years; Integer)
        {
            Caption = 'Years', Comment = 'HUN: Évek';
            DataClassification = CustomerContent;
            Description = '#Service';
        }
        field(50280; "Last KM/Oper. hours"; Integer)
        {
            Caption = 'Last KM / Operating hours', Comment = 'HUN: Utolsó KM / üzemóra';
            DataClassification = CustomerContent;
            Description = '#Vezénylés';
        }
        field(50290; "Average consumption"; Decimal)
        {
            Caption = 'Average consumption', Comment = 'HUN: Átlagos fogyasztás';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50300; Subtraction; Date)
        {
            Caption = 'Subtraction', Comment = 'HUN: Kivonás dátuma';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50310; Worker; Code[10])
        {
            Caption = 'Worker', Comment = 'HUN: Dolgozó';
            DataClassification = CustomerContent;
            Description = '#DataCore';
            Editable = false;
        }
        field(50320; Owner; Code[30])
        {
            Caption = 'Owner', Comment = 'HUN: Tulajdonos';
            DataClassification = CustomerContent;
            Description = '#DataCore';
            TableRelation = "CCI Owner"."No.";
        }
        field(50325; "Owner Name"; Text[100])
        {
            Caption = 'Owner Name', Comment = 'HUN: Tulajdonos neve';
            FieldClass = FlowField;
            CalcFormula = lookup("CCI Owner".Description where("No." = field(Owner)));
            Description = '#DataCore';
            Editable = false;
        }
        field(50330; LPNumber; Text[100])
        {
            Caption = 'License plate number / Machine', Comment = 'HUN: Rendszám / Gép azonosító';
            DataClassification = CustomerContent;
            Description = '#DataCore, #LIMOL, #Service';
        }
        field(50340; "Data Plate"; Media)
        {
            Caption = 'Data Plate', Comment = 'HUN: Adattábla';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50350; "Machine Plate"; Media)
        {
            Caption = 'Machine Plate', Comment = 'HUN: Gép tábla';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50360; "Machine Plate 2"; Media)
        {
            Caption = 'Machine Plate 2', Comment = 'HUN: Gép tábla 2';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50370; "Vehicle type"; Text[50])
        {
            Caption = 'Vehicle type', Comment = 'HUN: Gépjármű típusa';
            DataClassification = CustomerContent;
            Description = '#DataCore, #Service';
        }
        field(50380; "Euro rating"; Enum "CCI Euro Rating")
        {
            Caption = 'Euro rating', Comment = 'HUN: Euro besorolás';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50390; "Tachograph validity"; Date)
        {
            Caption = 'Tachograph validity', Comment = 'HUN: Tachográf érvényessége';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50400; "Mandatory service type"; Enum "CCI Mandatory Service Type")
        {
            Caption = 'Mandatory service type', Comment = 'HUN: Kötelező szerviz típusa';
            DataClassification = CustomerContent;
            Description = '#Service';
        }
        field(50410; "Machine Status Visibility"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Resource Group"."Machine status visibility" where("No." = field("Resource Group No.")));
            Caption = 'Machine Status Visibility', Locked = true;
            Description = '#DataCore';
        }
        field(50420; "Number of persons"; Integer)
        {
            Caption = 'Number of persons', Comment = 'HUN: Személyek száma';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50430; "Machine Subtraction"; Boolean)
        {
            Caption = 'Machine Subtraction', Comment = 'HUN: Gép kivonás';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50440; "In charge of refueling"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Resource Group"."In charge of refueling" where("No." = field("Resource Group No.")));
            Caption = 'In charge of refueling', Comment = 'HUN: Tankolásért felelős';
            Description = '#DataCore';
        }
    }
}
