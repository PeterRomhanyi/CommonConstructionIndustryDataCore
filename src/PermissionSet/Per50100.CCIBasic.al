namespace Loginform.CommonConstructionIndustryDataCore;

permissionset 50100 "CCI-BASIC"
{
    Caption = 'CCI Basic', Comment = 'HUN: CCI Alap';
    Assignable = true;
    Permissions =
        tabledata "CCI Job Title" = R,
        tabledata "CCI Job Group" = R,
        tabledata "CCI Owner" = R,
        tabledata "CCI Service Type" = R,
        tabledata "CCI Machine Status Log" = RIMD,
        tabledata "CCI Employee Issued Equipment" = RIMD,
        tabledata "CCI Job Title Item Connection" = R,
        tabledata "CCI Service Header" = RIMD,
        tabledata "CCI Service Line" = RIMD;
}
