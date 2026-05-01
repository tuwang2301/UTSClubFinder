import Foundation

final class ClubRepository: ObservableObject {
    @Published private(set) var clubs: [Club]
    @Published private(set) var favouriteClubIDs: Set<Club.ID>

    init(clubs: [Club] = SampleClubs.all, favouriteClubIDs: Set<Club.ID> = []) {
        self.clubs = clubs
        self.favouriteClubIDs = favouriteClubIDs
    }

    var featuredClubs: [Club] {
        clubs.filter { club in
            club.upcomingEvents.contains { $0.isFeatured }
        }
    }

    var savedClubs: [Club] {
        clubs.filter { favouriteClubIDs.contains($0.id) }
    }

    func club(withID id: Club.ID) -> Club? {
        clubs.first { $0.id == id }
    }

    func isFavourite(_ club: Club) -> Bool {
        favouriteClubIDs.contains(club.id)
    }

    func setFavourite(_ isFavourite: Bool, for club: Club) {
        if isFavourite {
            favouriteClubIDs.insert(club.id)
        } else {
            favouriteClubIDs.remove(club.id)
        }
    }

    func toggleFavourite(for club: Club) {
        setFavourite(!isFavourite(club), for: club)
    }
}
