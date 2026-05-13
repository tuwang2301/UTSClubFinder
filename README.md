# UTS Club Finder

GitHub repository: https://github.com/tuwang2301/UTSClubFinder

UTS Club Finder is a SwiftUI iOS application that helps UTS students discover clubs, compare events, save clubs, view club locations on campus, and receive location-aware club alerts.

## Target Audience

The target audience is UTS students, especially first-year, international, and socially new students who want to find communities on campus but do not know where club information is published.

## Problem Being Solved

Club information is often spread across posters, social media pages, word of mouth, ActivateUTS pages, and event stalls. This makes it difficult for students to compare clubs, remember events, and know where clubs are located on campus.

UTS Club Finder solves this by centralising:

- club discovery
- category filtering and searching
- club detail pages
- upcoming events
- saved clubs
- campus map pins
- geofence-style club alerts
- direct club contact links

## Comparison With Other Solutions

Compared with posters, Instagram pages, and manual browsing on club websites, this app provides a more structured mobile experience:

- Posters are easy to miss; this app keeps club information searchable.
- Social media pages are fragmented; this app groups clubs by category.
- Websites usually require manual browsing; this app gives students a saved shortlist.
- Static lists do not support location awareness; this app demonstrates CoreLocation geofencing and notification alerts.

## Key Features

- Browse featured clubs from the Home screen.
- Search and filter clubs by category.
- View detailed club information, events, member count, meeting place, and social links.
- Save favourite clubs.
- Register interest with validation for name, UTS student email, and study area.
- View club locations using MapKit.
- Enable location-aware club alerts using CoreLocation.
- Test geofence notifications during presentation using a controlled Test Alert button.
- Custom app icon and notification logo.

## iOS Frameworks And Services Used

- `SwiftUI`: user interface, tabs, navigation, lists, forms, reusable components.
- `MapKit`: campus map and club markers.
- `CoreLocation`: location permission and geofence monitoring with `CLCircularRegion`.
- `UserNotifications`: local notification alerts and foreground notification presentation.
- `XCTest`: unit tests for repository behaviour and search filtering.
- `UIKit`: navigation/tab bar appearance tuning and haptic feedback in the register-interest flow.

## Product Design Cycle

The app was developed through an iterative product design cycle:

1. Prototype: the team started from an HTML prototype for a UTS club discovery app.
2. MVP build: the prototype was converted into a native SwiftUI app with tabs, club data, search, save, detail, and map screens.
3. Framework integration: MapKit, CoreLocation, and UserNotifications were added to solve the location-aware discovery problem.
4. User testing: testing on simulator and physical iPhone revealed issues with simulator lag, foreground notifications, navigation title contrast, and app icon caching.
5. Refinement: the team fixed notification foreground presentation, added a Test Alert flow for presentation, improved navigation colours, added custom empty states, and added app/notification branding.

## Greatest Technical Difficulty

The most difficult part was geofencing and notification behaviour. CoreLocation requires permission handling, device support checks, and region monitoring. UserNotifications also behaves differently when the app is in the foreground, so the app implements `UNUserNotificationCenterDelegate` to show banner notifications during testing.

The final solution separates this logic into:

- `GeofenceManager`: location permission, geofence region setup, stop monitoring, and test entry simulation.
- `NotificationService`: notification permission, notification scheduling, foreground banner presentation, and logo attachment.

This separation keeps the Map screen focused on UI while services handle framework-specific behaviour.

## Code Design And Rubric Evidence

### Data Modeling

`Club`, `ClubCategory`, and `ClubEvent` model the problem domain directly. Clubs include category, description, tags, meeting place, coordinates, geofence radius, upcoming events, member count, and social links.

### Immutable Data And Idempotent Methods

Most model fields use `let`, making app data immutable after creation. `ClubRepository.setFavourite(_:for:)` is idempotent, so repeatedly setting the same saved state gives the same result.

### Functional Separation

The codebase is separated by responsibility:

- `Models`: app data structures.
- `Data`: sample club content.
- `Services`: repository, geofencing, notifications.
- `ViewModels`: search/filter state.
- `Views`: SwiftUI screens and reusable UI components.

### Loose Coupling

Views communicate with services through `EnvironmentObject` dependencies. For example, `CampusMapView` uses `GeofenceManager` and `NotificationService` without owning their internal framework logic.

### Extensibility

New clubs can be added by editing `SampleClubs.all`. New categories can be added through `ClubCategory`. New screens can be added to `AppRootView` without changing the service layer.

### Error Handling

The app handles:

- invalid registration names
- invalid UTS student email addresses
- missing study area input
- empty search results
- no saved clubs
- denied or unavailable location permission
- unavailable geofence support
- foreground notification presentation

### Collaborative Work

The repository uses GitHub branches, commits, and Pull Requests. `TASK_SPLIT.md` defines screen ownership and planned responsibilities for four members.

## Geofencing Demo

The Map tab demonstrates `MapKit`, `CoreLocation`, and `UserNotifications`.

Demo steps:

1. Open the app in Xcode.
2. Go to the Map tab.
3. Select a club marker to show the selected club preview.
4. Tap Enable to request notification and location permission.
5. Tap Test Alert to send the same notification that would appear when entering the selected club's geofence.
6. Tap Stop alerts to stop monitoring active club regions.

Presentation note: the Test Alert button is included because physically walking into a campus geofence is not practical during a five-minute lab presentation. The production path is still represented by `GeofenceManager`, which uses `CLLocationManager` and `CLCircularRegion`.

## Recommended Screenshots To Capture

Add screenshots to a `Screenshots/` folder before final submission. Recommended captures:

1. `01-home.jpg`: Home screen with featured clubs.
2. `02-directory-filter.jpg`: Clubs screen showing category filters/search.
3. `03-club-detail.jpg`: Club detail screen with events and social links.
4. `04-register-validation.jpg`: Register Interest form showing validation or completed fields.
5. `05-saved-clubs.jpg`: Saved screen after saving at least one club.
6. `06-map-selected-club.jpg`: Map screen with a selected club preview.
7. `07-geofence-alert.jpg`: iPhone notification banner after tapping Test Alert.
8. `08-app-icon.jpg`: app icon visible on the iPhone home screen.

For the final presentation, the most important screenshots are Home, Directory, Club Detail, Register Interest, Map/Test Alert, and Notification.

## App Screenshots

The following screenshots were captured from a physical iPhone.

| Home | Clubs |
| --- | --- |
| ![Home screen](Screenshots/01-home.jpg) | ![Club directory with filters](Screenshots/02-directory-filter.jpg) |

| Club Detail | Saved |
| --- | --- |
| ![Club detail screen](Screenshots/03-club-detail.jpg) | ![Saved clubs screen](Screenshots/05-saved-clubs.jpg) |

| Map And Geofence Controls | Notification Alert |
| --- | --- |
| ![Campus map with geofence controls](Screenshots/06-map-selected-club.jpg) | ![Geofence notification alert](Screenshots/07-geofence-alert.jpg) |

| App Icon |
| --- |
| ![UTS Club Finder app icon](Screenshots/08-app-icon.jpg) |

## How To Open

Recommended Xcode setup:

1. Clone the repository on a Mac.
2. Double-click `UTSClubFinder.xcodeproj`.
3. Select an iPhone simulator or physical iPhone.
4. Press Run in Xcode.

Clone command:

```bash
git clone https://github.com/tuwang2301/UTSClubFinder.git
cd UTSClubFinder
open UTSClubFinder.xcodeproj
```

If Xcode asks for signing, select the `UTSClubFinder` app target, open Signing & Capabilities, then choose an Apple Developer team or personal team.

## Git Branch Workflow

Keep `main` stable. Each member should work on a feature branch.

Branch name format:

```bash
feature/<screen-or-task-name>
```

Examples:

```bash
feature/home-directory
feature/club-detail
feature/map-geofence
feature/saved-profile-docs
```

Create a branch:

```bash
git checkout main
git pull
git checkout -b feature/map-geofence
```

Push a branch:

```bash
git push -u origin feature/map-geofence
```

## Commit Message Format

Use small commits. One commit should describe one meaningful change.

Format:

```text
type(scope): short summary
```

Allowed types:

- `feat`: new feature or screen
- `fix`: bug fix
- `style`: visual/UI changes only
- `refactor`: code structure change without new behaviour
- `docs`: README, presentation, or planning docs
- `test`: unit tests or test data
- `chore`: project setup or config

Examples:

```bash
git commit -m "feat(map): add campus geofence controls"
git commit -m "style(home): align hero with UTS green theme"
git commit -m "fix(directory): handle empty search results"
git commit -m "docs(readme): add Xcode setup steps"
```

## Pull Request And Merge Rules

Recommended PR process:

1. Push your feature branch.
2. Open a Pull Request into `main`.
3. Add a short PR description explaining what changed and how it was tested.
4. Include screenshots if the UI changed.
5. Ask one teammate to review.
6. Merge only after Xcode builds successfully.

Do not force push to `main`. Do not rewrite another member's commits unless the whole group agrees.

## Supporting Files

- `TASK_SPLIT.md`: group task ownership and branch plan.
- `PRESENTATION_OUTLINE.md`: five-minute presentation structure.
- `RUBRIC_NOTES.md`: code-design rubric notes.
