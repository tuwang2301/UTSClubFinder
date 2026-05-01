import SwiftUI

@main
struct UTSClubFinderApp: App {
    @StateObject private var repository = ClubRepository()
    @StateObject private var geofenceManager = GeofenceManager()
    @StateObject private var notificationService = NotificationService()

    var body: some Scene {
        WindowGroup {
            AppRootView()
                .environmentObject(repository)
                .environmentObject(geofenceManager)
                .environmentObject(notificationService)
                .tint(AppTheme.utsGreen)
        }
    }
}
