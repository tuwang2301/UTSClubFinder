import SwiftUI

struct DirectoryView: View {
    @EnvironmentObject private var repository: ClubRepository
    @StateObject private var viewModel = ClubDirectoryViewModel()

    var filteredClubs: [Club] {
        viewModel.filteredClubs(from: repository.clubs)
    }

    var emptyStateMessage: String {
        let hasSearchText = !viewModel.searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty

        if hasSearchText, let category = viewModel.selectedCategory {
            return "No clubs match your search in \(category.rawValue). Try another keyword or clear filters."
        } else if hasSearchText {
            return "No clubs match your search. Try another keyword or reset your search."
        } else if let category = viewModel.selectedCategory {
            return "No clubs found in \(category.rawValue). Clear filters to browse all clubs."
        } else {
            return "No clubs are available right now."
        }
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
                Menu {
                    ForEach(ClubDirectoryViewModel.SortOption.allCases) { option in
                        Button {
                            viewModel.selectedSortOption = option
                        } label: {
                            if viewModel.selectedSortOption == option {
                                Label(option.rawValue, systemImage: "checkmark")
                            } else {
                                Text(option.rawValue)
                            }
                        }
                    }
                } label: {
                    Label("Sort: \(viewModel.selectedSortOption.rawValue)", systemImage: "arrow.up.arrow.down")
                        .font(.subheadline.weight(.semibold))
                }
                .listRowBackground(AppTheme.surface)

                if filteredClubs.isEmpty {
                    EmptyStateView(
                        title: "No matching clubs",
                        systemImage: "magnifyingglass",
                        message: emptyStateMessage,
                        actionTitle: "Clear filters",
                        action: {
                            viewModel.searchText = ""
                            viewModel.selectedCategory = nil
                        }
                    )
                    .listRowBackground(AppTheme.surface)
                } else {
                    ForEach(filteredClubs) { club in
                        NavigationLink {
                            ClubDetailView(club: club)
                        } label: {
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
        .searchable(text: $viewModel.searchText, prompt: "Search clubs, tags, or categories")
    }
}
