# Rubric Notes

## Data Modeling

`Club`, `ClubCategory`, and `ClubEvent` model the problem domain directly. Clubs contain category, location, geofence radius, tags, meeting place, events, and member count.

## Immutable Data And Idempotent Methods

Most model fields are `let`, so club data is immutable after creation. `ClubRepository.setFavourite(_:for:)` is idempotent: calling it multiple times with the same value produces the same result.

## Functional Separation

- `Views`: SwiftUI screens and components.
- `ViewModels`: filtering/search state.
- `Services`: repository, geofencing, and notifications.
- `Models`: data structures.

## Loose Coupling

`CampusMapView` talks to `GeofenceManager` and `NotificationService` through environment objects. The map UI can change without changing club data, and geofence logic can change without editing the directory screens.

## Extensibility

New clubs can be added by editing `SampleClubs.all`. New categories can be added to `ClubCategory`, then the directory filter updates through `CaseIterable`.

## Error Handling

`GeofenceManager` checks geofencing availability and permission status before monitoring regions. `DirectoryView` shows an empty state when search/filter returns no clubs.

## Collaborative Work

The work split in `TASK_SPLIT.md` assigns different screens and services to different members so GitHub commits can show clear individual contributions.
