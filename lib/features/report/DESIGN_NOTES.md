# Design notes: report

Memory of Figma values that have no shared token yet. Append-only table, one row per distinct value. Promotion into `lib/core/theme/` is done only by the shared-code owner.

Status flow: `Open` -> `Requested` -> `Promoted` -> `Migrated`

| ID | Type | Constant | Exact Figma value | Figma frame / layer | Used in | Status | Note |
|----|------|----------|-------------------|---------------------|---------|--------|------|
| REPORT-001 | color | `cardBorder` | `#D8E5EC` | `1. Report type` / option cards | `report_type_screen.dart` | Open | No exact shared border token; closest is `AppColors.borderGray200`. |
| REPORT-002 | color | `stepsSurface` | `#EAF8FB` | `1. Report type` / steps callout | `report_type_screen.dart` | Open | No exact shared surface token. |
| REPORT-003 | color | `stepsIconSurface` | `#CFF3FA` | `1. Report type` / steps icon bubble | `report_type_screen.dart` | Open | No exact shared surface token. |
| REPORT-004 | color | `responsibilitySurface` | `#E8F8F3` | `1. Report type` / responsibility callout | `report_type_screen.dart` | Open | No exact shared surface token. |
| REPORT-005 | color | `responsibilityIconSurface` | `#D0F2E4` | `1. Report type` / responsibility icon bubble | `report_type_screen.dart` | Open | No exact shared surface token. |
| REPORT-006 | textStyle | `optionTitle` | `17px bold / 21px line height` | `1. Report type` / option titles | `report_type_screen.dart` | Open | Existing styles do not match the Figma size or line height. |
| REPORT-007 | textStyle | `optionDescription` | `13px regular / 16px line height` | `1. Report type` / option descriptions | `report_type_screen.dart` | Open | Existing styles do not match the Figma size or line height. |
| REPORT-008 | textStyle | `calloutTitle` | `15px semibold / 19px line height` | `1. Report type` / callout titles | `report_type_screen.dart` | Open | Existing styles do not match the Figma size or line height. |
| REPORT-009 | textStyle | `calloutBody` | `12px regular / 15px line height` | `1. Report type` / callout bodies | `report_type_screen.dart` | Open | Existing styles do not match the Figma size or line height. |
| REPORT-010 | textStyle | `actionLabel` | `16px bold` | `1. Report type` / view reports action | `report_type_screen.dart` | Open | Existing styles do not match the Figma size. |
| REPORT-011 | radius | `cardRadius` | `15px` | `1. Report type` / option cards | `report_type_screen.dart` | Open | Off the shared radius scale. |
| REPORT-012 | radius | `calloutRadius` | `14px` | `1. Report type` / informational callouts | `report_type_screen.dart` | Open | Off the shared radius scale. |
| REPORT-013 | shadow | `cardShadow` | `0 3px 4.5px rgba(34,87,112,0.09)` | `1. Report type` / option cards | `report_type_screen.dart` | Open | No shared shadow token. |
| REPORT-014 | spacing | `reportImageSize` | `60px` | `1. Report type` / option images | `report_type_screen.dart` | Open | Exact image size is retained locally. |
| REPORT-015 | spacing | `heroHeight` | `156px` | `1. Report type` / hero image | `report_type_screen.dart` | Open | Exact hero height is retained locally. |
| REPORT-016 | spacing | `calloutHeight` | `66px` | `1. Report type` / informational callouts | `report_type_screen.dart` | Open | Exact callout height is retained locally. |
| REPORT-017 | spacing | `actionWidth` | `279px` | `1. Report type` / view reports action | `report_type_screen.dart` | Open | Exact action width is retained locally. |
| REPORT-018 | spacing | `actionHeight` | `41px` | `1. Report type` / view reports action | `report_type_screen.dart` | Open | Exact action height is retained locally. |
| REPORT-019 | spacing | `topBarHeight` | `117px` | `1. Report type` / top app bar canvas | `report_type_screen.dart` | Open | Exact frame canvas position is retained locally. |
| REPORT-020 | spacing | `pollutionCardTop` | `254px` | `1. Report type` / pollution card | `report_type_screen.dart` | Open | Exact frame y-position is retained locally. |
| REPORT-021 | spacing | `speciesCardTop` | `363px` | `1. Report type` / species card | `report_type_screen.dart` | Open | Exact frame y-position is retained locally. |
| REPORT-022 | spacing | `stepsCalloutTop` | `479px` | `1. Report type` / steps callout | `report_type_screen.dart` | Open | Exact frame y-position is retained locally. |
| REPORT-023 | spacing | `responsibilityCalloutTop` | `572px` | `1. Report type` / responsibility callout | `report_type_screen.dart` | Open | Exact frame y-position is retained locally. |
| REPORT-024 | spacing | `actionTop` | `665px` | `1. Report type` / view reports action | `report_type_screen.dart` | Open | Exact frame y-position is retained locally. |
| REPORT-025 | spacing | `optionIconSize` | `24px` | `1. Report type` / option icon | `report_type_screen.dart` | Open | Exact icon size is retained locally. |
| REPORT-026 | spacing | `calloutIconSize` | `20px` | `1. Report type` / callout icon | `report_type_screen.dart` | Open | Exact icon size is retained locally. |
| REPORT-027 | textStyle | `logoFontSize` | `30px bold` | `1. Report type` / BlueCitizen logo | `report_type_screen.dart` | Open | Existing heading styles do not match the Figma logo size. |
| REPORT-028 | spacing | `notificationSize` | `43.303px` | `1. Report type` / notification bubble | `report_type_screen.dart` | Open | Exact notification diameter is retained locally. |
| REPORT-029 | spacing | `reportImageRadius` | `30px` | `1. Report type` / option images | `report_type_screen.dart` | Open | Radius is derived from the exact 60px image diameter. |
| REPORT-030 | spacing | `zero` | `0px` | `1. Report type` / full-width anchors | `report_type_screen.dart` | Open | Explicit zero anchors keep raw layout values out of the screen file. |
| REPORT-031 | asset | `heroImageAsset` | `hero_turtle.png` | `1. Report type` / hero image | `report_type_screen.dart` | Open | Downloaded exact Figma source image for the hero. |
| REPORT-032 | asset | `pollutionImageAsset` | `pollution_card.png` | `1. Report type` / pollution image | `report_type_screen.dart` | Open | Downloaded exact Figma source image for the pollution option. |
| REPORT-033 | asset | `speciesImageAsset` | `species_card.png` | `1. Report type` / species image | `report_type_screen.dart` | Open | Downloaded exact Figma source image for the species option. |
| REPORT-034 | spacing | `topBarElementTop` | `59px` | `1. Report type` / top app bar elements | `report_type_screen.dart` | Open | Exact frame y-position for logo and notification. |
| REPORT-035 | spacing | `topBarSideInset` | `22px` | `1. Report type` / notification bubble | `report_type_screen.dart` | Open | Exact frame right inset. |
| REPORT-036 | spacing | `optionHorizontalPadding` | `18px` | `1. Report type` / option cards | `report_type_screen.dart` | Open | Aligns image and text to exact card coordinates. |
| REPORT-037 | spacing | `optionContentGap` | `20px` | `1. Report type` / option cards | `report_type_screen.dart` | Open | Aligns title x-coordinate to the frame. |
| REPORT-038 | spacing | `calloutContentGap` | `11px` | `1. Report type` / informational callouts | `report_type_screen.dart` | Open | Aligns callout text to the frame. |
| REPORT-039 | spacing | `heroImageRenderedHeight` | `327.678px` | `1. Report type` / hero image crop | `report_type_screen.dart` | Open | Matches Figma image height ratio. |
| REPORT-040 | spacing | `heroImageOffset` | `-123.084px` | `1. Report type` / hero image crop | `report_type_screen.dart` | Open | Matches Figma image top crop offset. |
