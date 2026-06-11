# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Identity

- **App name:** CommonConstructionIndustryDataCore
- **Publisher:** Default Publisher
- **Target:** BC 28 (application 28.0.0.0, runtime 17.0), Cloud
- **Object ID range:** 50100–50149
- **Namespace:** `DefaultPublisher.CommonConstructionIndustryDataCore`
- **Feature flags:** `NoImplicitWith` — all `Rec.` prefixes are mandatory

## Object Prefix: CCI

**All AL objects in this project use the `CCI` prefix** (CommonConstructionIndustry).
This applies to every object type: tables, pages, codeunits, enums, reports, etc.
When porting code from the Gerulus project (`GER*`, `LIMOL*`, `LIAR*` prefixes), rename all objects and references to `CCI`.

Examples:
- Table: `CCI Fuel Card`
- Page: `CCI Fuel Card List`, `CCI Fuel Card Card`
- Codeunit: `CCI Fuel Card Mgt.`
- PermissionSet: `CCI-BASIC`, `CCI-ADMIN`

## Development Commands

All AL development is done in VS Code with the AL Language extension:

| Action | How |
|---|---|
| **Compile / publish** | `Ctrl+Shift+B` (AL: Publish) or `F5` (publish + debug) |
| **Package only** | `Ctrl+F5` |
| **Run tests** | AL Test Runner extension → sidebar |
| **Single test** | AL Test Runner → right-click a test procedure → Run |

The launch target is a Microsoft cloud sandbox. Configure tenant, auth, and environment name in `.vscode/launch.json` before first use — never commit credentials there.

## AL Development Standards

Every new file must comply with the full **Loginform AL Development Standards** (Loginform-skill-md). Non-negotiable rules:

- **DataClassification** on every table field (default: `CustomerContent`)
- **SetLoadFields** before every `FindSet`/`Get` when reading a subset of fields
- **Captions** in English; Hungarian in `Comment = 'HUN: ...'`
- **PermissionSet**: every new table, page, codeunit, and report must appear in at least one AL `permissionset` before merge
- **No XML permission files** — AL `permissionset` objects only
- **File naming:** `{TypePrefix}{ID}.{Description}[.TypeSuffix].al` — e.g., `Tab50100.CCIFuelCard.Tabe.al`

## Directory Structure

Place every new file in the correct subfolder under `src/`:

```
src/
  Tables/
  TableExt/
  Pages/
  PageExt/
  Codeunit/
  Enum/
  EnumExt/
  Reports/
  Queries/
  Interfaces/
```

## app.json

Governed by the Loginform ID allocation system — **never edit manually**. If missing, restore through the allocation tooling.

## Gerulus Reference

Related production app at `C:\Users\peter.romhanyi\Documents\AL\Gerulus_DEV` (Gerulus System Integration, ID range 50000–59999, BC 26).
When porting code from Gerulus: rename all `GER*`/`LIMOL*`/`LIAR*` prefixes to `CCI`, update namespace, apply full Loginform skill rules.
