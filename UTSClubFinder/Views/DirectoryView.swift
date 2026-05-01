import SwiftUI

struct DirectoryView: View {
    @EnvironmentObject private var repository: ClubRepository
    @StateObject private var viewModel = ClubDirectoryViewModel()

    var filteredClubs: [Club] {
        viewModel.filteredClubs(from: repository.clubs)
    }

    var body: some View {
        List {
            Section {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        CategoryChip(
                            title: "All",
                            systemImage: "square.grid.2x2.fill",
                            isSelected: viewModel.selectedCategory == nil,
                            action: { viewModel.selectedCategory = nil }
                        )

                        ForEach(ClubCategory.allCases) { category in
                            CategoryChip(
                                title: category.rawValue,
                                systemImage: category.icon,
                                isSelected: viewModel.selectedCategory == category,
                                action: { viewModel.selectedCategory = category }
                            )
                        }
                    }
                    .padding(.vertical, 4)
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 0))
                .listRowBackground(AppTheme.surface)
            }

            Section {
                if filteredClubs.isEmpty {
                    ContentUnavailableView(
                        "No matching clubs",
                        systemImage: "magnifyingglass",
                        description: Text("Try a different keyword or category.")
                    )
                    .listRowBackground(AppTheme.surface)
                } else {
                    ForEach(filteredClubs) { club in
                        NavigationLink(value: club) {
                            ClubCardView(
                                club: club,
                                isFavourite: repository.isFavourite(club),
                                onToggleFavourite: { repository.toggleFavourite(for: club) }
                            )
                        }
                        .buttonStyle(.plain)
                        .listRowSeparator(.hidden)
                        .listRowBackground(AppTheme.surface)
                    }
                }
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(AppTheme.surface)
        .navigationTitle("Clubs")
        .searchable(text: $viewModel.searchText, prompt: "Search clubs or tags")
        .navigationDestination(for: Club.self) { club in
            ClubDetailView(club: club)
        }
    }
}
