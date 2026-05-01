# UTS Club Finder

SwiftUI MVP for an iOS app that helps UTS students discover clubs, compare events, save favourites, and get location-aware prompts when they are near a relevant club area on campus.

## GitHub link

https://github.com/tuwang2301/UTSClubFinder

## App Concept

Target audience: UTS students, especially first-year and international students who want a faster way to find clubs that match their interests.

Problem solved: club discovery is usually scattered across stalls, posters, social media, and word of mouth. This app centralises club browsing, filtering, saved clubs, events, maps, and geofencing prompts.

## iOS Frameworks Used

- SwiftUI: app UI, navigation, reusable components.
- MapKit: campus map and club/event annotations.
- CoreLocation: user location and geofence monitoring.
- UserNotifications: local notification when a geofence is entered.
- XCTest: unit tests for data modelling and idempotent favourite logic.

## How To Open

Recommended Xcode setup:

1. Create a new iOS App project in Xcode named `UTSClubFinder`.
2. Choose SwiftUI and Swift.
3. Drag the `UTSClubFinder` folder into the Xcode project.
4. Add `UTSClubFinder/Resources/Info.plist` keys to the app target Info settings.
5. Run on an iOS simulator or physical iPhone.

Optional XcodeGen setup:

```bash
brew install xcodegen
xcodegen generate
open UTSClubFinder.xcodeproj
```

Clone on a Mac:

```bash
git clone https://github.com/tuwang2301/UTSClubFinder.git
cd UTSClubFinder
```

The source is split so each group member can own one or two screens without blocking the others.

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
git commit -m "docs(readme): add Mac build workflow"
```

## Pull Request And Merge Rules

Recommended PR process:

1. Push your feature branch.
2. Open a Pull Request into `main`.
3. Add a short PR description:
   - What screen or feature changed.
   - How you tested it on Mac/Xcode.
   - Screenshots if the UI changed.
4. Ask one teammate to review.
5. Merge only after Xcode builds successfully.

Before merging, always update your branch:

```bash
git checkout main
git pull
git checkout feature/map-geofence
git merge main
```

If there are conflicts:

1. Open the conflicting files.
2. Keep both teammates' useful changes where possible.
3. Build in Xcode again.
4. Commit the conflict resolution:

```bash
git add .
git commit -m "fix(map): resolve merge conflict with main"
```

Do not force push to `main`. Do not rewrite another member's commits unless the whole group agrees.

## Suggested Group Split

See `TASK_SPLIT.md` for a screen-by-screen work plan for four people.
