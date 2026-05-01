import Foundation

final class ClubDirectoryViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var selectedCategory: ClubCategory?

    func filteredClubs(from clubs: [Club]) -> [Club] {
        clubs
            .filter(matchesCategory)
            .filter(matchesSearch)
            .sorted { $0.memberCount > $1.memberCount }
    }

    private func matchesCategory(_ club: Club) -> Bool {
        selectedCategory == nil || club.category == selectedCategory
    }

    private func matchesSearch(_ club: Club) -> Bool {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return true }

        return club.name.localizedCaseInsensitiveContains(query)
            || club.tagline.localizedCaseInsensitiveContains(query)
            || club.tags.contains { $0.localizedCaseInsensitiveContains(query) }
    }
}
