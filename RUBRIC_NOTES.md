# Rubric Notes

## Data Modeling

`Club`, `ClubCategory`, and `ClubEvent` model the problem domain directly. Clubs contain category, location, geofence radius, tags, meeting place, weekly meetup, events, member count, and social/contact links.

## Immutable Data And Idempotent Methods

Most model fields are `let`, so club data is immutable after creation. `ClubRepository.setFavourite(_:for:)` is idempotent: calling it multiple times with the same value produces the same saved-club state.

## Functional Separation

- `Views`: SwiftUI screens and components.
- `ViewModels`: filtering/search state.
- `Services`: repository, geofencing, and notifications.
- `Models`: data structures.

## Loose Coupling

Views receive shared behaviour through `EnvironmentObject` dependencies. `CampusMapView` talks to `GeofenceManager` and `NotificationService` without owning their framework logic, while directory/detail/saved/profile screens can change independently of the map services.

## Extensibility

New clubs can be added by editing `SampleClubs.all`. New categories can be added to `ClubCategory`, then the directory filter updates through `CaseIterable`. A new club can also gain events, tags, contact links, and map/geofence behaviour through data changes rather than new screen code.

## Error Handling

`GeofenceManager` checks geofencing availability and permission status before monitoring regions. `NotificationService` requests permission and supports foreground presentation for demo testing. `DirectoryView` and `SavedClubsView` show empty states, while the Register Interest form prevents invalid names, non-UTS emails, and missing study-area input.

## Collaborative Work

`TASK_SPLIT.md` records screen ownership for group collaboration. The GitHub repository should show separate commits or branches/PRs for home/directory, detail/register, map/geofence, and saved/profile/documentation work so individual contributions are visible.
