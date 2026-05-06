import Foundation

final class ClubDirectoryViewModel: ObservableObject {
    enum SortOption: String, CaseIterable, Identifiable {
        case mostPopular = "Most popular"
        case alphabetical = "A-Z"
        case upcomingEvents = "Upcoming events"

        var id: String { rawValue }
    }

    @Published var searchText = ""
    @Published var selectedCategory: ClubCategory?
    @Published var selectedSortOption: SortOption = .mostPopular

    func filteredClubs(from clubs: [Club]) -> [Club] {
        clubs
            .filter(matchesCategory)
            .filter(matchesSearch)
            .sorted(by: sortClubs)
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

    private func sortClubs(_ lhs: Club, _ rhs: Club) -> Bool {
        switch selectedSortOption {
        case .mostPopular:
            lhs.memberCount > rhs.memberCount
        case .alphabetical:
            lhs.name.localizedCaseInsensitiveCompare(rhs.name) == .orderedAscending
        case .upcomingEvents:
            sortByUpcomingEvent(lhs, rhs)
        }
    }

    private func sortByUpcomingEvent(_ lhs: Club, _ rhs: Club) -> Bool {
        let lhsDate = earliestUpcomingEventSortKey(for: lhs)
        let rhsDate = earliestUpcomingEventSortKey(for: rhs)

        switch (lhsDate, rhsDate) {
        case let (lhsDate?, rhsDate?):
            if lhsDate != rhsDate {
                return lhsDate < rhsDate
            }
            return lhs.name.localizedCaseInsensitiveCompare(rhs.name) == .orderedAscending
        case (.some, .none):
            return true
        case (.none, .some):
            return false
        case (.none, .none):
            return lhs.name.localizedCaseInsensitiveCompare(rhs.name) == .orderedAscending
        }
    }

    private func earliestUpcomingEventSortKey(for club: Club) -> Int? {
        club.upcomingEvents
            .compactMap { sortKey(from: $0.dateText) }
            .min()
    }

    // Assumes sample event dates start with "Week N, Day", for example "Week 10, Tue".
    private func sortKey(from dateText: String) -> Int? {
        let parts = dateText
            .split(separator: ",", maxSplits: 1)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }

        guard
            let weekText = parts.first,
            weekText.hasPrefix("Week "),
            let week = Int(weekText.dropFirst("Week ".count)),
            parts.count > 1,
            let day = weekdaySortOrder[String(parts[1].prefix(3))]
        else {
            return nil
        }

        return week * 10 + day
    }

    private let weekdaySortOrder = [
        "Mon": 1,
        "Tue": 2,
        "Wed": 3,
        "Thu": 4,
        "Fri": 5,
        "Sat": 6,
        "Sun": 7
    ]
}
