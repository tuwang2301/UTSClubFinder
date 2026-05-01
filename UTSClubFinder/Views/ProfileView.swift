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
                    Text("MVP progress")
                        .font(.headline)

                    ProgressRow(title: "Search clubs", isDone: true)
                    ProgressRow(title: "Save favourites", isDone: true)
                    ProgressRow(title: "Map discovery", isDone: true)
                    ProgressRow(title: "Geofence demo", isDone: !geofenceManager.monitoredClubIDs.isEmpty)
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

private struct ProgressRow: View {
    let title: String
    let isDone: Bool

    var body: some View {
        HStack {
            Image(systemName: isDone ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(isDone ? AppTheme.utsGreen : AppTheme.muted)
            Text(title)
            Spacer()
        }
    }
}
