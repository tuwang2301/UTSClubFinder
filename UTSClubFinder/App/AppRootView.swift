import SwiftUI
import UIKit

struct AppRootView: View {
    init() {
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black
        ]

        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.configureWithOpaqueBackground()
        navigationAppearance.backgroundColor = .white
        navigationAppearance.shadowColor = UIColor.black.withAlphaComponent(0.08)
        navigationAppearance.titleTextAttributes = titleAttributes
        navigationAppearance.largeTitleTextAttributes = titleAttributes
        navigationAppearance.buttonAppearance.normal.titleTextAttributes = titleAttributes
        navigationAppearance.doneButtonAppearance.normal.titleTextAttributes = titleAttributes
        navigationAppearance.backButtonAppearance.normal.titleTextAttributes = titleAttributes

        UINavigationBar.appearance().standardAppearance = navigationAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationAppearance
        UINavigationBar.appearance().compactAppearance = navigationAppearance
        UINavigationBar.appearance().compactScrollEdgeAppearance = navigationAppearance
        UINavigationBar.appearance().barStyle = .default
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = UIColor(AppTheme.utsGreen)

        let tabAppearance = UITabBarAppearance()
        tabAppearance.configureWithOpaqueBackground()
        tabAppearance.backgroundColor = .white
        UITabBar.appearance().standardAppearance = tabAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabAppearance
        UITabBar.appearance().barStyle = .default
        UITabBar.appearance().isTranslucent = false
    }

    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .appNavigationChrome()
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }

            NavigationStack {
                DirectoryView()
            }
            .appNavigationChrome()
            .tabItem {
                Label("Clubs", systemImage: "person.3.fill")
            }

            NavigationStack {
                CampusMapView()
            }
            .appNavigationChrome()
            .tabItem {
                Label("Map", systemImage: "map.fill")
            }

            NavigationStack {
                SavedClubsView()
            }
            .appNavigationChrome()
            .tabItem {
                Label("Saved", systemImage: "bookmark.fill")
            }

            NavigationStack {
                ProfileView()
            }
            .appNavigationChrome()
            .tabItem {
                Label("Profile", systemImage: "person.crop.circle.fill")
            }
        }
        .tint(AppTheme.utsGreen)
        .toolbarBackground(Color.white, for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
        .toolbarColorScheme(.light, for: .tabBar)
        .preferredColorScheme(.light)
    }
}

private extension View {
    func appNavigationChrome() -> some View {
        self
            .toolbarBackground(Color.white, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.light, for: .navigationBar)
    }
}
