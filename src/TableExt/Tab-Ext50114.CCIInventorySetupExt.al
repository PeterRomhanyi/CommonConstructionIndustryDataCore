namespace Loginform.CommonConstructionIndustryDataCore;

using Microsoft.Inventory.Setup;
using Microsoft.Inventory.Location;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Inventory.Journal;

tableextension 50114 "CCI Inventory Setup Ext" extends "Inventory Setup"
{
    fields
    {
        field(50000; "Equipment Template Name"; Code[10])
        {
            Caption = 'Equipment Journal Template Name', Comment = 'HUN: Felszerelés napló sablon neve';
            DataClassification = CustomerContent;
            Description = '#DataCore';
            TableRelation = "Item Journal Template";
        }
        field(50010; "Equipment Batch Name"; Code[10])
        {
            Caption = 'Equipment Journal Batch Name', Comment = 'HUN: Felszerelés napló köteg neve';
            DataClassification = CustomerContent;
            Description = '#DataCore';
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = field("Equipment Template Name"));
        }
        field(50020; "Equi. Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Equipment Gen. Bus. Posting Group', Comment = 'HUN: Felszerelés általános üzleti könyvelési csoport';
            DataClassification = CustomerContent;
            Description = '#DataCore';
            TableRelation = "Gen. Business Posting Group";
        }
        field(50030; "Equipment Location Code"; Code[10])
        {
            Caption = 'Equipment Location Code', Comment = 'HUN: Felszerelés telephely kód';
            DataClassification = CustomerContent;
            Description = '#DataCore';
            TableRelation = Location.Code;
        }
    }
}
