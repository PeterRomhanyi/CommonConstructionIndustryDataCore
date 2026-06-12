namespace Loginform.CommonConstructionIndustryDataCore;

permissionset 50101 "CCI-ADMIN"
{
    Caption = 'CCI Admin', Comment = 'HUN: CCI Adminisztrátor';
    Assignable = true;
    IncludedPermissionSets = "CCI-BASIC";
    Permissions =
        tabledata "CCI Job Title" = RIMD,
        tabledata "CCI Job Group" = RIMD,
        tabledata "CCI Owner" = RIMD,
        tabledata "CCI Service Type" = RIMD,
        tabledata "CCI Machine Writings" = RIMD,
        tabledata "CCI Location Writings" = RIMD;
}
