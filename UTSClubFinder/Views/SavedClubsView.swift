import SwiftUI

struct SavedClubsView: View {
    @EnvironmentObject private var repository: ClubRepository

    var body: some View {
        List {
            if repository.savedClubs.isEmpty {
                ContentUnavailableView(
                    "No saved clubs yet",
                    systemImage: "bookmark",
                    description: Text("Save clubs from the directory to build your shortlist.")
                )
                .listRowBackground(AppTheme.surface)
            } else {
                ForEach(repository.savedClubs) { club in
                    NavigationLink(value: club) {
                        ClubCardView(
                            club: club,
                            isFavourite: true,
                            onToggleFavourite: { repository.toggleFavourite(for: club) }
                        )
                    }
                    .buttonStyle(.plain)
                    .listRowSeparator(.hidden)
                    .listRowBackground(AppTheme.surface)
                }
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(AppTheme.surface)
        .navigationTitle("Saved")
        .navigationDestination(for: Club.self) { club in
            ClubDetailView(club: club)
        }
    }
}
