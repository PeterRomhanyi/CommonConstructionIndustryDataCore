namespace Loginform.CommonConstructionIndustryDataCore;

using Microsoft.Projects.Project.Job;
using Microsoft.Inventory.Location;

tableextension 50101 "CCI Location Ext" extends Location
{
    fields
    {
        field(50000; "Default hours"; Decimal)
        {
            Caption = 'Default hours', Comment = 'HUN: Alapértelmezett óra';
            DataClassification = CustomerContent;
            Description = '#Mobile';
        }
        field(50010; "Default job No."; Code[20])
        {
            Caption = 'Default Job No.', Comment = 'HUN: Alapértelmezett projekt szám';
            DataClassification = CustomerContent;
            Description = '#Mobile';
            TableRelation = Job."No.";
        }
        field(50020; "Location Type"; Option)
        {
            Caption = 'Location Type', Comment = 'HUN: Telephely típusa';
            DataClassification = CustomerContent;
            Description = '#DataCore, #Project, #Refueling, #Mobile';
            //ToDo = 'Convert to ENUM';
            OptionMembers = Location,Project,"Gas station","Mobile gas station",Car,Mine;
            OptionCaption = 'Location,Project,Gas station,Mobile gas station,Car,Mine', Comment = 'HUN: Telephely,Projekt,Benzinkút,Mobil benzinkút,Autó,Bánya';
        }
        field(50030; "Start of work"; Time)
        {
            Caption = 'Start of work', Comment = 'HUN: Munkakezdés időpontja';
            DataClassification = CustomerContent;
            Description = '#DataCore';
        }
        field(50040; "Accessible location"; Code[10])
        {
            Caption = 'Accessible location', Comment = 'HUN: Elérhető telephely';
            DataClassification = CustomerContent;
            Description = '#DataCore, #Mobile';
            TableRelation = Location.Code;
        }
    }
}
