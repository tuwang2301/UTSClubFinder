# 5 Minute Presentation Outline

## 0:00-0:40 Target Audience

Our audience is UTS students who want to discover clubs quickly, especially new students who do not yet know where club information is posted.

## 0:40-1:20 Problem

Club information is fragmented across posters, stalls, social media, and word of mouth. Students need one place to search, compare, save, and locate clubs.

## 1:20-2:00 Comparison

Compared with posters or Instagram pages, UTS Club Finder combines structured categories, saved clubs, upcoming events, campus map discovery, and location-aware reminders.

## 2:00-3:00 Demo

Show Home, Clubs search/filter, Club Detail, Register Interest validation, Save Club, Saved list, Map, Test Alert notification, and Profile.

## 3:00-3:40 Frameworks

SwiftUI builds the interface and navigation. MapKit displays campus locations. CoreLocation monitors nearby club regions. UserNotifications sends the geofence alert. UIKit is used for app-level appearance tuning, notification attachment support, and haptic feedback.

## 3:40-4:25 Difficulty

The main difficulty was geofencing because location permission, notification permission, foreground notification behaviour, and simulator testing can fail separately. We solved this by separating logic into `GeofenceManager` and `NotificationService`, testing on a physical iPhone, and adding a Test Alert path for the five-minute demo.

## 4:25-5:00 Product Design Cycle

We started with an HTML prototype, converted it into a SwiftUI MVP, tested the core flows on simulator and iPhone, then refined navigation contrast, empty states, notification branding, and screen responsibilities through group task splitting.
