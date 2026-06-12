namespace Loginform.CommonConstructionIndustryDataCore;

using Microsoft.Projects.Resources.Resource;

tableextension 50116 "CCI Resource Group Ext" extends "Resource Group"
{
    fields
    {
        field(50000; "Machine status visibility"; Boolean)
        {
            Caption = 'Machine status visibility', Comment = 'HUN: Gép állapot láthatósága';
            DataClassification = CustomerContent;
            Description = '#Mobile';
        }
        field(50010; "In charge of refueling"; Boolean)
        {
            Caption = 'In charge of refueling', Comment = 'HUN: Tankolásért felelős';
            DataClassification = CustomerContent;
            Description = '#Mobile';
        }
    }
}
