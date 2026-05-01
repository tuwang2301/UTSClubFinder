import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var repository: ClubRepository
    @EnvironmentObject private var geofenceManager: GeofenceManager

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                VStack(alignment: .leading, spacing: 10) {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 58))
                        .foregroundStyle(AppTheme.utsGreen)

                    Text("Student Explorer")
                        .font(.title2.weight(.bold))
                    Text("Interested in technology, culture, and campus events.")
                        .font(.subheadline)
                        .foregroundStyle(AppTheme.muted)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(18)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))

                VStack(alignment: .leading, spacing: 14) {
                    Text("Interests")
                        .font(.headline)

                    InterestRow(icon: "cpu.fill", title: "Technology", detail: "Swift, product design, and hackathons")
                    InterestRow(icon: "globe.asia.australia.fill", title: "Culture", detail: "Meetups for local and international students")
                    InterestRow(icon: "calendar", title: "Events", detail: "Prefer after-class sessions on campus")
                }
                .padding(18)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))

                VStack(alignment: .leading, spacing: 8) {
                    Text("Stats")
                        .font(.headline)
                    Text("\(repository.savedClubs.count) saved clubs")
                    Text("\(repository.clubs.count) clubs in prototype data")
                    Text("\(geofenceManager.monitoredClubIDs.count) active geofence regions")
                }
                .font(.subheadline)
                .padding(18)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
            }
            .padding(20)
        }
        .background(AppTheme.surface)
        .navigationTitle("Profile")
    }
}

private struct InterestRow: View {
    let icon: String
    let title: String
    let detail: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(AppTheme.utsGreen)
                .frame(width: 24)
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.subheadline.weight(.semibold))
                Text(detail)
                    .font(.caption)
                    .foregroundStyle(AppTheme.muted)
            }
            Spacer()
        }
    }
}
