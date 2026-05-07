import CoreLocation
import Foundation

struct Club: Identifiable, Equatable, Hashable {
    let id: UUID
    let name: String
    let tagline: String
    let category: ClubCategory
    let description: String
    let meetingPlace: String
    let coordinate: CLLocationCoordinate2D
    let geofenceRadius: CLLocationDistance
    let weeklyMeetup: String
    let memberCount: Int
    let tags: [String]
    let upcomingEvents: [ClubEvent]
    let facebookURL: String
    let instagramURL: String
    let websiteURL: String
    // ---------------------------

    init(
        id: UUID = UUID(),
        name: String,
        tagline: String,
        category: ClubCategory,
        description: String,
        meetingPlace: String,
        latitude: CLLocationDegrees,
        longitude: CLLocationDegrees,
        geofenceRadius: CLLocationDistance = 90,
        weeklyMeetup: String,
        memberCount: Int,
        tags: [String],
        upcomingEvents: [ClubEvent],
        facebookURL: String = "https://facebook.com/activateuts",
        instagramURL: String = "https://instagram.com/activateuts",
        websiteURL: String = "https://www.activateuts.com.au/clubs/"
    ) {
        self.id = id
        self.name = name
        self.tagline = tagline
        self.category = category
        self.description = description
        self.meetingPlace = meetingPlace
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.geofenceRadius = geofenceRadius
        self.weeklyMeetup = weeklyMeetup
        self.memberCount = memberCount
        self.tags = tags
        self.upcomingEvents = upcomingEvents
        self.facebookURL = facebookURL
        self.instagramURL = instagramURL
        self.websiteURL = websiteURL
    }

    static func == (lhs: Club, rhs: Club) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

enum ClubCategory: String, CaseIterable, Identifiable {
    case technology = "Technology"
    case culture = "Culture"
    case sport = "Sport"
    case creative = "Creative"
    case academic = "Academic"
    case games = "Games"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .technology: "cpu.fill"
        case .culture: "globe.asia.australia.fill"
        case .sport: "figure.run"
        case .creative: "paintpalette.fill"
        case .academic: "graduationcap.fill"
        case .games: "gamecontroller.fill"
        }
    }
}

struct ClubEvent: Identifiable, Equatable, Hashable {
    let id: UUID
    let title: String
    let dateText: String
    let location: String
    let isFeatured: Bool

    init(id: UUID = UUID(), title: String, dateText: String, location: String, isFeatured: Bool = false) {
        self.id = id
        self.title = title
        self.dateText = dateText
        self.location = location
        self.isFeatured = isFeatured
    }
}
