import XCTest
@testable import UTSClubFinder

final class ClubRepositoryTests: XCTestCase {
    func testSetFavouriteIsIdempotent() {
        let club = SampleClubs.all[0]
        let repository = ClubRepository(clubs: [club])

        repository.setFavourite(true, for: club)
        repository.setFavourite(true, for: club)

        XCTAssertEqual(repository.favouriteClubIDs.count, 1)
        XCTAssertTrue(repository.isFavourite(club))
    }

    func testFilteringFindsTagsCaseInsensitively() {
        let viewModel = ClubDirectoryViewModel()
        viewModel.searchText = "swift"

        let results = viewModel.filteredClubs(from: SampleClubs.all)

        XCTAssertTrue(results.contains { $0.name == "UTS Programmers' Society" })
    }
}
