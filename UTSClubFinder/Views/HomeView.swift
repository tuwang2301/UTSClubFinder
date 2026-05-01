import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var repository: ClubRepository

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                hero

                VStack(alignment: .leading, spacing: 12) {
                    Text("Featured this week")
                        .font(.title3.weight(.bold))

                    ForEach(repository.featuredClubs) { club in
                        NavigationLink(value: club) {
                            ClubCardView(
                                club: club,
                                isFavourite: repository.isFavourite(club),
                                onToggleFavourite: { repository.toggleFavourite(for: club) }
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(20)
        }
        .background(AppTheme.surface)
        .navigationTitle("UTS Club Finder")
        .navigationDestination(for: Club.self) { club in
            ClubDetailView(club: club)
        }
    }

    private var hero: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Find your people on campus")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(Color.white)
                        .fixedSize(horizontal: false, vertical: true)

                    Text("Browse clubs, save events, and get a prompt when you are nearby.")
                        .font(.body)
                        .foregroundStyle(Color.white.opacity(0.88))
                }

                Spacer(minLength: 12)

                Image(systemName: "location.circle.fill")
                    .font(.system(size: 54))
                    .foregroundStyle(AppTheme.utsLime)
            }

            NavigationLink {
                DirectoryView()
            } label: {
                Label("Browse clubs", systemImage: "sparkle.magnifyingglass")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.white)
                    .foregroundStyle(AppTheme.utsGreen)
                    .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
            }
        }
        .padding(20)
        .background(AppTheme.utsGreen)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
    }
}
