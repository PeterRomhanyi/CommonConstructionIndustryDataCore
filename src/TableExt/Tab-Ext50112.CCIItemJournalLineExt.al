namespace Loginform.CommonConstructionIndustryDataCore;

using Microsoft.Inventory.Journal;
using Microsoft.Inventory.Ledger;

tableextension 50112 "CCI Item Journal Line Ext" extends "Item Journal Line"
{
    fields
    {
        field(50000; AutoPost; Boolean)
        {
            Caption = 'Auto Post', Comment = 'HUN: Automatikus könyvelés';
            DataClassification = CustomerContent;
            Description = '#Mobile';
        }
        field(50010; EquipmentBool; Boolean)
        {
            Caption = 'Equipment', Comment = 'HUN: Felszerelés';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50020; EquipmentreturnBool; Boolean)
        {
            Caption = 'Equipment return', Comment = 'HUN: Felszerelés visszavétel';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50030; Comment; Text[1024])
        {
            Caption = 'Comment', Comment = 'HUN: Megjegyzés';
            DataClassification = CustomerContent;
            Description = '#Mobile, #Service';
        }
        field(50040; "Actual Inventory"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Actual Inventory', Comment = 'HUN: Tényleges készlet';
            DecimalPlaces = 0 : 5;
            Description = '#DataCore';
            Editable = false;
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("Item No."),
                                                                  "Global Dimension 1 Code" = field("Shortcut Dimension 1 Code"),
                                                                  "Global Dimension 2 Code" = field("Shortcut Dimension 2 Code"),
                                                                  "Location Code" = field("Location Code"),
                                                                  "Drop Shipment" = field("Drop Shipment"),
                                                                  "Variant Code" = field("Variant Code"),
                                                                  "Lot No." = field("Lot No."),
                                                                  "Serial No." = field("Serial No."),
                                                                  "Unit of Measure Code" = field("Unit of Measure Code"),
                                                                  "Package No." = field("Package No.")));
            FieldClass = FlowField;

        }
    }
}
