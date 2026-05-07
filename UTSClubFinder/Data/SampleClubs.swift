import Foundation

enum SampleClubs {
    static let all: [Club] = [
        Club(
            name: "Cyber Security Society (CSEC)",
            tagline: "Learn to secure and protect the future.",
            category: .technology,
            description: "CSEC is dedicated to promoting cybersecurity awareness and technical skills. We run weekly hands-on workshops on topics like cryptography, network security, and ethical hacking, as well as hosting our own annual conference, CSECcon.",
            meetingPlace: "Building 11, Tech Precinct",
            latitude: -33.8839,
            longitude: 151.2005,
            weeklyMeetup: "Thursdays 6:00 PM",
            memberCount: 2800,
            tags: ["Security", "Hacking", "Networking", "Workshops"],
            upcomingEvents: [
                ClubEvent(title: "Ethical Hacking 101", dateText: "Week 10, Thu", location: "CB11.04.400", isFeatured: true),
                ClubEvent(title: "Capture The Flag (CTF)", dateText: "Week 11, Fri", location: "Online")
            ],
            facebookURL: "https://www.facebook.com/UTSCSEC/",
            instagramURL: "https://www.instagram.com/uts_csec/",
            websiteURL: "https://www.activateuts.com.au/clubs/cyber-security-society/"
        ),
        Club(
            name: "Motorcycle Society",
            tagline: "Ride together, stay safe, and share the passion.",
            category: .sport,
            description: "The UTS Motorcycle Society is a group for students and alumni who share a passion for two wheels. Whether you're a learner or a veteran rider, we host social rides, maintenance workshops, and track days to help you get the most out of your riding experience.",
            meetingPlace: "Building 1, Level 3 (or designated ride start points)",
            latitude: -33.8832,
            longitude: 151.2007,
            weeklyMeetup: "Monthly Social Rides",
            memberCount: 150,
            tags: ["Riding", "Safety", "Social", "Adventure"],
            upcomingEvents: [
                ClubEvent(title: "Royal National Park Ride", dateText: "Week 10, Sun", location: "Start: Building 1", isFeatured: true),
                ClubEvent(title: "Maintenance Workshop", dateText: "Week 12, Wed", location: "CB11 Workshop")
            ],
            facebookURL: "https://m.facebook.com/groups/609146981686080/",
            instagramURL: "https://www.instagram.com/utsmcs",
            websiteURL: "https://www.activateuts.com.au/clubs/motorcycle-society/"
        ),
        Club(
            name: "Anime@UTS",
            tagline: "For fans of Japanese animation and culture.",
            category: .creative,
            description: "The largest social club at UTS. We host weekly screenings, art competitions, and massive social outings for anyone who loves anime and manga.",
            meetingPlace: "Building 1, Level 3",
            latitude: -33.8830,
            longitude: 151.2007,
            weeklyMeetup: "Tuesdays 6:00 PM",
            memberCount: 1500,
            tags: ["Anime", "Social", "Art"],
            upcomingEvents: [
                ClubEvent(title: "Weekly Screening", dateText: "Week 10, Tue", location: "CB01.03.006")
            ],
            facebookURL: "https://www.facebook.com/utsanime/",
            instagramURL: "https://www.instagram.com/utsanime/",
            websiteURL: "https://www.activateuts.com.au/clubs/animeuts/"
        ),
        Club(
            name: "UTS Badminton Club",
            tagline: "Play the fastest racket sport in the world.",
            category: .sport,
            description: "Whether you want to play socially with friends or represent UTS at the Uni Nationals, UTSBC is the place for you. We provide high-quality shuttles and professional coaching to help you improve your game while keeping fit and making new friends.",
            meetingPlace: "Sydney Boys High School (Moore Park)",
            latitude: -33.8912,
            longitude: 151.2163,
            weeklyMeetup: "Wednesdays & Saturdays 6:00 PM",
            memberCount: 850,
            tags: ["Sport", "Fitness", "Social", "Competition"],
            upcomingEvents: [
                ClubEvent(title: "Social Smash Night", dateText: "Week 10, Wed", location: "Moore Park Courts", isFeatured: true),
                ClubEvent(title: "Uni Nationals Trials", dateText: "Week 11, Sat", location: "Ross Milbourne Sports Hall")
            ],
            facebookURL: "https://www.facebook.com/groups/utsbadmintonclub",
            instagramURL: "https://www.instagram.com/uts_badminton/?igsh=dTdlNjB1ZDBsaGwx#",
            websiteURL: "https://www.activateuts.com.au/clubs/badminton/"
        ),
        Club(
            name: "UTS Backstage",
            tagline: "Theatrical production and performing arts.",
            category: .creative,
            description: "UTS Backstage is the premier performing arts society on campus, dedicated to providing students with opportunities in acting, directing, and tech.",
            meetingPlace: "Building 1, Level 3",
            latitude: -33.8832,
            longitude: 151.2006,
            weeklyMeetup: "Thursdays 5:00 PM",
            memberCount: 320,
            tags: ["Drama", "Production", "Acting"],
            upcomingEvents: [
                ClubEvent(title: "Major Production Night", dateText: "Week 12, Sat", location: "Bon Marche Studio", isFeatured: true)
            ],
            facebookURL: "https://www.facebook.com/UTSBackstage",
            instagramURL: "https://www.instagram.com/utsbackstage/",
            websiteURL: "http://www.utsbackstage.com/"
        ),
        Club(
            name: "UTS Engineering Society",
            tagline: "EngSoc: Connecting future engineers.",
            category: .academic,
            description: "One of the oldest and largest societies at UTS. We bridge the gap between university and the professional engineering industry.",
            meetingPlace: "Building 11, Lobby",
            latitude: -33.8839,
            longitude: 151.2008,
            weeklyMeetup: "Wednesdays 12:00 PM",
            memberCount: 2100,
            tags: ["Industry", "Networking", "Professional"],
            upcomingEvents: [
                ClubEvent(title: "Industry Networking Night", dateText: "Week 11, Thu", location: "The Great Hall", isFeatured: true)
            ],
            facebookURL: "https://www.facebook.com/engsoc",
            instagramURL: "https://www.instagram.com/engsoc/",
            websiteURL: "https://www.activateuts.com.au/clubs/engineering-society-engsoc/"
        ),
        Club(
            name: "Law Students' Society (LSS)",
            tagline: "Representative body for the UTS legal community.",
            category: .academic, // Or you could use .professional if you have that category
            description: "The UTS LSS is a student-run society that caters to the educational, vocational, and social needs of Law students. We run over 130 initiatives a year, including our famous Law Ball, clerkship networking evenings, mooting competitions, and social justice talks.",
            meetingPlace: "Building 2, Level 14 (Law Faculty)",
            latitude: -33.8841,
            longitude: 151.2008,
            weeklyMeetup: "Various (Check Moot Court schedule)",
            memberCount: 3500,
            tags: ["Law", "Mooting", "Careers", "Networking"],
            upcomingEvents: [
                ClubEvent(title: "Clerkship Networking Evening", dateText: "May 11", location: "Aerial Function Centre", isFeatured: true),
                ClubEvent(title: "BSOC x LSS Cruise", dateText: "May 8", location: "King St Wharf")
            ],
            facebookURL: "https://www.facebook.com/utslawss",
            instagramURL: "https://www.instagram.com/utslss/?hl=en",
            websiteURL: "http://www.utslss.com/"
        ),
        Club(
            name: "Pokémon Club",
            tagline: "Gotta catch 'em all with your friends at UTS!",
            category: .games,
            description: "Keen to catch 'em all? The UTS Pokémon Club is the home for fans of the franchise to share their adventures. We host fortnightly Showdown tournaments, Pokémon Go community day walks, Switch game nights, and casual trading card meetups.",
            meetingPlace: "Building 2, Level 3 (Food Court/Social Area)",
            latitude: -33.8835,
            longitude: 151.2007,
            weeklyMeetup: "Tuesdays 4:00 PM",
            memberCount: 620,
            tags: ["Nintendo", "Gaming", "Trading Cards", "Social"],
            upcomingEvents: [
                ClubEvent(title: "Pokémon Showdown Tournament", dateText: "Week 11, Tue", location: "CB02.03.004", isFeatured: true),
                ClubEvent(title: "Community Day Walk", dateText: "Next Sat", location: "Alumni Green")
            ],
            facebookURL: "https://www.facebook.com/UTSPokemonClub",
            instagramURL: "https://www.instagram.com/UTSpokemonclub/",
            websiteURL: "https://www.activateuts.com.au/clubs/pokemon-club/"
        ),
        Club(
            name: "Indian Society",
            tagline: "Celebrating culture, Bollywood, and lifelong friendships.",
            category: .culture,
            description: "Known by our brand 'DESI', the UTS Indian Society is one of the most active cultural clubs on campus. We aim to bring together students from all backgrounds to celebrate Indian culture through massive social events like the DESI Ball, Holi festivals, and Bollywood cruise parties.",
            meetingPlace: "Building 1, Level 5 (Great Hall / Balcony Room)",
            latitude: -33.8832,
            longitude: 151.2010,
            weeklyMeetup: "Thursdays 5:00 PM (Social Mixers)",
            memberCount: 2200,
            tags: ["Culture", "Bollywood", "Festivals", "Social"],
            upcomingEvents: [
                ClubEvent(title: "The DESI Ball", dateText: "August 15", location: "Grand Ballroom", isFeatured: true),
                ClubEvent(title: "Freshers Welcome Party", dateText: "Week 2, Fri", location: "The Underground")
            ],
            facebookURL: "https://www.facebook.com/UTSIndianSociety/",
            instagramURL: "https://www.instagram.com/utsindiansociety/",
            websiteURL: "http://www.thedesiaus.com/"
        )
    ]
}
