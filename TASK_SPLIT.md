# Task Split For 4 Members

## Member 1: Home + Directory

- Own files:
  - `UTSClubFinder/Views/HomeView.swift`
  - `UTSClubFinder/Views/DirectoryView.swift`
  - `UTSClubFinder/ViewModels/ClubDirectoryViewModel.swift`
- Tasks:
  - Polish search, categories, and club list.
  - Add sorting by popularity, upcoming event, or distance.
  - Make filter chips match the prototype more closely.
  - Add empty states for no search results.

## Member 2: Club Detail + Join Flow

- Own files:
  - `UTSClubFinder/Views/ClubDetailView.swift`
  - `UTSClubFinder/Views/Components/ClubCardView.swift`
- Tasks:
  - Improve club detail layout.
  - Add join/register interest form validation.
  - Add contact links for Instagram, email, or website.
  - Add error handling for invalid form input.

## Member 3: Map + Geofencing

- Own files:
  - `UTSClubFinder/Views/CampusMapView.swift`
  - `UTSClubFinder/Services/GeofenceManager.swift`
  - `UTSClubFinder/Services/NotificationService.swift`
- Tasks:
  - Test location permission flow.
  - Tune geofence radius for UTS buildings.
  - Add notification copy for each club.
  - Demo entering a test region in simulator.

## Member 4: Saved + Profile + README

- Own files:
  - `UTSClubFinder/Views/SavedClubsView.swift`
  - `UTSClubFinder/Views/ProfileView.swift`
  - `README.md`
- Tasks:
  - Improve saved clubs experience.
  - Add user persona and design cycle notes.
  - Document MVP iterations and final presentation script.
  - Ensure GitHub commits show collaboration.

## Presentation Plan

1. Target audience: UTS students who want to find clubs quickly.
2. Problem: club info is fragmented and hard to compare.
3. Comparison: faster than posters/social media because it combines search, map, events, and saved clubs.
4. Demo: home, filter, detail, save, map, geofence notification.
5. Frameworks: SwiftUI, MapKit, CoreLocation, UserNotifications.
6. Difficulty: location permission/geofencing; solution is a `GeofenceManager` service with clear permission states.
7. Design cycle: prototype HTML, SwiftUI MVP, test with classmates, refine filters/detail/map.
