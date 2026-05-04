import SwiftUI

struct AppRootView: View {
    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }

            NavigationStack {
                DirectoryView()
            }
            .tabItem {
                Label("Clubs", systemImage: "person.3.fill")
            }

            NavigationStack {
                CampusMapView()
            }
            .tabItem {
                Label("Map", systemImage: "map.fill")
            }

            NavigationStack {
                SavedClubsView()
            }
            .tabItem {
                Label("Saved", systemImage: "bookmark.fill")
            }

            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Label("Profile", systemImage: "person.crop.circle.fill")
            }
        }
        .tint(AppTheme.utsGreen)
        .toolbarBackground(Color.white, for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
        .toolbarColorScheme(.light, for: .tabBar)
    }
}
