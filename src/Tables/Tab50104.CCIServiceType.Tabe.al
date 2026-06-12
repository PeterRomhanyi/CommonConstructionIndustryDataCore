namespace Loginform.CommonConstructionIndustryDataCore;

using Microsoft.Projects.Resources.Resource;

table 50104 "CCI Service Type"
{
    Access = Public;
    Caption = 'Service Type', Comment = 'HUN: Szerviz típus';
    DataClassification = CustomerContent;
    Description = '#Service';
    Extensible = true;

    fields
    {
        field(10; "Code"; Code[20])
        {
            Caption = 'Code', Comment = 'HUN: Kód';
            DataClassification = CustomerContent;
        }
        field(20; Description; Text[250])
        {
            Caption = 'Description', Comment = 'HUN: Leírás';
            DataClassification = CustomerContent;
        }
        field(30; "Hourly Overhead Cost"; Decimal)
        {
            Caption = 'Hourly Overhead Cost', Comment = 'HUN: Óránkénti rezsi költség';
            DataClassification = CustomerContent;
        }
        field(40; "Resource Overhead"; Code[20])
        {
            Caption = 'Resource Overhead', Comment = 'HUN: Erőforrás rezsi';
            DataClassification = CustomerContent;
            TableRelation = Resource."No." where(Blocked = const(false));
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
