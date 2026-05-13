import SwiftUI

struct SavedClubsView: View {
    @EnvironmentObject private var repository: ClubRepository

    var body: some View {
        List {
            if repository.savedClubs.isEmpty {
                
                saveEmptyState
                    .listRowBackground(AppTheme.surface)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
            } else {
                ForEach(repository.savedClubs) { club in
                    NavigationLink {
                        ClubDetailView(club: club)
                    } label: {
                        ClubCardView(
                            club: club,
                            isFavourite: true,
                            onToggleFavourite: { repository.toggleFavourite(for: club) }
                        )
                    }
                    .buttonStyle(.plain)
                    .listRowSeparator(.hidden)
                    .listRowBackground(AppTheme.surface)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true){
                        Button{
                            repository.setFavourite(false, for: club)
                        } label: {
                            Label ("Remove", systemImage: "trashfill")
                        }
                        .tint(.red)
                    }
                }
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(AppTheme.surface)
        .navigationTitle(savedTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
    private var savedTitle: String {
        let count = repository.savedClubs.count
        return count == 0 ? "Saved" : " Saved : (\(count))"
    }
    
    
    private var saveEmptyState: some View{
        GeometryReader{ geo in
            VStack(spacing: 20){
                Spacer()
                
                Image(systemName: "bookmark.slash.fill")
                    .font(.system(size: 48, weight: .semibold))
                    .foregroundStyle(AppTheme.utsGreen.opacity(0.4))
                
                VStack(spacing: 6){
                    Text("No saved clubs yet")
                        .font(.headline)
                        .foregroundStyle(AppTheme.ink)
                    
                    Text("Tap the bookmark on any club to add it to your shortlist")
                        .font(.subheadline)
                        .foregroundStyle(AppTheme.muted)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
                NavigationLink{
                    DirectoryView()
                } label: {
                    Label("Browse Clubs", systemImage: "magnifyingglass")
                        .font(.subheadline.weight(.semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(AppTheme.utsGreen)
                        .foregroundStyle(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 32)
                
                Spacer()
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .frame(height: UIScreen.main.bounds.height * 0.65)
    }
}
