# Platform Mapping

Map the token set consistently across platforms.

## Android MaterialTheme

| Material token | Light | Dark |
| --- | --- | --- |
| `primary` | `#8B5E3C` | `#C8A97E` |
| `onPrimary` | `#1A1A18` | `#ECECEC` |
| `background` | `#F5F0EB` | `#1C1B19` |
| `surface` | `#FFFFFDFA` | `#242320` |
| `surfaceVariant` | `#EDE5DD` | `#2E2D2A` |
| `onBackground` | `#1A1A18` | `#ECECEC` |
| `onSurface` | `#1C1C1A` | `#E8E8E6` |
| `onSurfaceVariant` | `#6B6B6B` | `#9B9B9B` |
| `outline` | `#1A1A18` | `#D4D4D4` |
| `error` | `#B3261E` | `#B3261E` |

Implementation guidance:

- Create semantic theme colors once, then derive component styling from Material tokens
- Do not scatter raw hex values across composables
- If the host app already uses Material 3, adjust only the palette and keep existing shape and typography scales where possible

## iOS Usage

Use the same numeric palette values as Android.

Suggested naming:

- `lightBackground` and `darkBackground`
- `lightSurface` and `darkSurface`
- `lightSurfaceVariant` and `darkSurfaceVariant`
- `lightTextPrimary` and `darkTextPrimary`
- `lightTextSecondary` and `darkTextSecondary`
- `lightLink` and `darkLink`

Implementation guidance:

- Expose palette constants centrally, then consume them by scene intent
- Prefer semantic accessors over direct color literals in views
- Keep UIKit and SwiftUI naming aligned if both exist in the same codebase
