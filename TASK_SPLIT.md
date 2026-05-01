# Team Task Split

This file defines the suggested work split for a 4-member group. Each member should work on a separate feature branch, commit small changes, and open a Pull Request into `main`.

## Member 1: Home + Club Directory

Branch:

```bash
feature/home-directory
```

Main responsibility:

Improve the discovery flow so students can quickly browse, search, filter, and sort clubs.

Tasks:

- Improve `HomeView.swift` layout and spacing.
- Add a clearer "Featured this week" section.
- Improve `DirectoryView.swift` search and category filters.
- Add sorting options: "Most popular", "A-Z", and "Upcoming events".
- Add a better empty state when no clubs match the search.
- Test searching by club name, tag, and category.

Files:

- `UTSClubFinder/Views/HomeView.swift`
- `UTSClubFinder/Views/DirectoryView.swift`
- `UTSClubFinder/ViewModels/ClubDirectoryViewModel.swift`
- `UTSClubFinder/Views/Components/CategoryChip.swift`

Commit examples:

```bash
git commit -m "feat(directory): add club sorting options"
git commit -m "style(home): polish featured clubs layout"
```

## Member 2: Club Detail + Join Flow

Branch:

```bash
feature/club-detail-join
```

Main responsibility:

Make the club detail page more useful and add a realistic register-interest flow.

Tasks:

- Improve `ClubDetailView.swift` visual layout.
- Add a "Register Interest" form.
- Add form fields for name, student email, study area, and optional message.
- Validate that name is not empty.
- Validate that email ends with `@student.uts.edu.au` or contains `uts`.
- Show a success message after valid submission.
- Show a clear error message for invalid input.
- Add a club contact section with email, Instagram, and website placeholders.

Files:

- `UTSClubFinder/Views/ClubDetailView.swift`
- `UTSClubFinder/Models/Club.swift`
- `UTSClubFinder/Data/SampleClubs.swift`

Commit examples:

```bash
git commit -m "feat(detail): add register interest form"
git commit -m "fix(detail): validate student email input"
```

## Member 3: Campus Map + Geofencing

Branch:

```bash
feature/map-geofence
```

Main responsibility:

Improve the campus map experience and make the CoreLocation geofencing demo easier to present.

Tasks:

- Improve `CampusMapView.swift` map bottom panel.
- Add a selected club preview before opening the full detail screen.
- Add clearer geofence permission status.
- Add explanation text for location permission.
- Add a "Stop alerts" button.
- Test the geofence demo button.
- Test location permission denied and allowed states.
- Add notes to `README.md` about how to demo geofencing in the presentation.

Files:

- `UTSClubFinder/Views/CampusMapView.swift`
- `UTSClubFinder/Services/GeofenceManager.swift`
- `UTSClubFinder/Services/NotificationService.swift`
- `README.md`

Commit examples:

```bash
git commit -m "feat(map): add selected club preview"
git commit -m "feat(geofence): add stop monitoring action"
```

## Member 4: Saved + Profile + Documentation

Branch:

```bash
feature/saved-profile-docs
```

Main responsibility:

Improve the saved clubs/profile experience and keep the submission documentation polished.

Tasks:

- Improve `SavedClubsView.swift` empty state.
- Add saved club count and quick actions.
- Improve `ProfileView.swift` so it looks like a real student profile.
- Add editable interests using toggles or chips.
- Update this file with final member names.
- Update `PRESENTATION_OUTLINE.md`.
- Add screenshots to `README.md` after testing on Xcode.
- Add final GitHub repository link in submission notes.

Files:

- `UTSClubFinder/Views/SavedClubsView.swift`
- `UTSClubFinder/Views/ProfileView.swift`
- `TASK_SPLIT.md`
- `PRESENTATION_OUTLINE.md`
- `README.md`

Commit examples:

```bash
git commit -m "feat(profile): add editable student interests"
git commit -m "docs(presentation): add final demo script"
```

## General Git Workflow

Create a branch:

```bash
git checkout main
git pull
git checkout -b feature/your-task-name
```

Commit changes:

```bash
git add .
git commit -m "type(scope): short summary"
```

Push branch:

```bash
git push -u origin feature/your-task-name
```

Then open a Pull Request into `main`.

## Pull Request Checklist

Before merging into `main`:

- The app opens in Xcode.
- The app builds successfully.
- The main tabs still work: Home, Clubs, Map, Saved, Profile.
- The changed screen has been tested in the simulator.
- The Pull Request has a short description of what changed.
- At least one teammate has reviewed the Pull Request.

## Recommended Commit Format

Use:

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
git commit -m "feat(directory): add category filter chips"
git commit -m "fix(map): handle denied location permission"
git commit -m "docs(readme): add Xcode setup steps"
```
