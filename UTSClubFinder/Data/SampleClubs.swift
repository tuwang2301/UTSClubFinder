import Foundation

enum SampleClubs {
    static let all: [Club] = [
        Club(
            name: "UTS Programmers' Society",
            tagline: "Build apps, compete, and meet other developers.",
            category: .technology,
            description: "A student community for coding workshops, hackathons, project nights, and peer support.",
            meetingPlace: "Building 11, Software Labs",
            latitude: -33.8837,
            longitude: 151.2009,
            weeklyMeetup: "Wednesdays 5:30 PM",
            memberCount: 1240,
            tags: ["Swift", "Hackathons", "Beginner friendly"],
            upcomingEvents: [
                ClubEvent(title: "Intro to SwiftUI", dateText: "Week 10, Tue", location: "CB11.05.300", isFeatured: true),
                ClubEvent(title: "Project Night", dateText: "Week 11, Wed", location: "CB11 Labs")
            ]
        ),
        Club(
            name: "UTS Tech Society",
            tagline: "Talks, networking, and product workshops.",
            category: .technology,
            description: "Connects students with industry speakers and practical technology events.",
            meetingPlace: "Building 2, Tech Lounge",
            latitude: -33.8833,
            longitude: 151.2002,
            weeklyMeetup: "Fortnightly Thursdays",
            memberCount: 890,
            tags: ["Careers", "Startups", "Networking"],
            upcomingEvents: [
                ClubEvent(title: "Product Design Sprint", dateText: "Week 10, Thu", location: "CB02.04.120", isFeatured: true)
            ]
        ),
        Club(
            name: "UTS Basketball Club",
            tagline: "Social games and competitive squads.",
            category: .sport,
            description: "Open sessions for casual players and trials for inter-university competitions.",
            meetingPlace: "Ross Milbourne Sports Hall",
            latitude: -33.8829,
            longitude: 151.1995,
            weeklyMeetup: "Mondays 6:00 PM",
            memberCount: 430,
            tags: ["Fitness", "Social", "Competition"],
            upcomingEvents: [
                ClubEvent(title: "Social Shootaround", dateText: "Week 10, Mon", location: "Sports Hall")
            ]
        ),
        Club(
            name: "UTS International Students Club",
            tagline: "Find friends, events, and campus support.",
            category: .culture,
            description: "A welcoming space for international and local students to share culture and settle into campus life.",
            meetingPlace: "Building 1, Level 3",
            latitude: -33.8830,
            longitude: 151.2007,
            weeklyMeetup: "Fridays 4:00 PM",
            memberCount: 760,
            tags: ["Culture", "Support", "Food"],
            upcomingEvents: [
                ClubEvent(title: "Global Food Night", dateText: "Week 11, Fri", location: "CB01.03", isFeatured: true)
            ]
        ),
        Club(
            name: "UTS Design Collective",
            tagline: "Design jams, portfolios, and creative critique.",
            category: .creative,
            description: "For students interested in UX, visual design, motion, branding, and creative technology.",
            meetingPlace: "Building 6, Design Studios",
            latitude: -33.8848,
            longitude: 151.2004,
            weeklyMeetup: "Tuesdays 5:00 PM",
            memberCount: 520,
            tags: ["UX", "Portfolio", "Creative"],
            upcomingEvents: [
                ClubEvent(title: "Portfolio Critique", dateText: "Week 10, Tue", location: "CB06 Studio")
            ]
        ),
        Club(
            name: "UTS Volunteering Society",
            tagline: "Make an impact around Sydney.",
            category: .volunteering,
            description: "Coordinates volunteering projects, community partnerships, and service-learning opportunities.",
            meetingPlace: "Building 1, Student Hub",
            latitude: -33.8832,
            longitude: 151.2005,
            weeklyMeetup: "Monthly",
            memberCount: 310,
            tags: ["Community", "Impact", "Events"],
            upcomingEvents: [
                ClubEvent(title: "Community Clean-up", dateText: "Week 12, Sat", location: "Ultimo", isFeatured: true)
            ]
        )
    ]
}
