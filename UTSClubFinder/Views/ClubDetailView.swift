import SwiftUI

struct ClubDetailView: View {
    @EnvironmentObject private var repository: ClubRepository
    let club: Club

    @State private var showingJoinConfirmation = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                header
                details
                events
                actions
            }
            .padding(20)
        }
        .background(AppTheme.surface)
        .navigationTitle(club.name)
        .navigationBarTitleDisplayMode(.inline)
        .alert("Interest registered", isPresented: $showingJoinConfirmation) {
            Button("Done", role: .cancel) {}
        } message: {
            Text("We saved your interest in \(club.name).")
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .center, spacing: 14) {
                Image(systemName: club.category.icon)
                    .font(.system(size: 34, weight: .semibold))
                    .foregroundStyle(AppTheme.utsGreen)
                    .frame(width: 64, height: 64)
                    .background(AppTheme.utsGreen.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))

                VStack(alignment: .leading, spacing: 5) {
                    Text(club.category.rawValue)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(AppTheme.utsGreen)
                    Text(club.tagline)
                        .font(.title3.weight(.bold))
                        .foregroundStyle(AppTheme.ink)
                }
            }

            Text(club.description)
                .font(.body)
                .foregroundStyle(AppTheme.muted)
        }
        .padding(18)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
    }

    private var details: some View {
        VStack(alignment: .leading, spacing: 14) {
            InfoRow(icon: "mappin.and.ellipse", title: "Meeting place", value: club.meetingPlace)
            InfoRow(icon: "calendar", title: "Weekly meetup", value: club.weeklyMeetup)
            InfoRow(icon: "person.2.fill", title: "Members", value: "\(club.memberCount) students")

            FlowLayout(items: club.tags) { tag in
                Text(tag)
                    .font(.caption.weight(.semibold))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 7)
                    .background(AppTheme.utsGreen.opacity(0.10))
                    .foregroundStyle(AppTheme.utsGreen)
                    .clipShape(Capsule())
            }
        }
        .padding(18)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
    }

    private var events: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Upcoming events")
                .font(.headline)

            ForEach(club.upcomingEvents) { event in
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: event.isFeatured ? "star.circle.fill" : "calendar.circle.fill")
                        .foregroundStyle(event.isFeatured ? AppTheme.utsLime : AppTheme.utsGreen)
                        .font(.title3)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(event.title)
                            .font(.subheadline.weight(.semibold))
                        Text("\(event.dateText) · \(event.location)")
                            .font(.caption)
                            .foregroundStyle(AppTheme.muted)
                    }
                    Spacer()
                }
                .padding(12)
                .background(AppTheme.surface)
                .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
            }
        }
        .padding(18)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
    }

    private var actions: some View {
        VStack(spacing: 10) {
            Button {
                repository.toggleFavourite(for: club)
            } label: {
                Label(repository.isFavourite(club) ? "Saved" : "Save club", systemImage: repository.isFavourite(club) ? "bookmark.fill" : "bookmark")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)

            Button {
                showingJoinConfirmation = true
            } label: {
                Label("Register interest", systemImage: "checkmark.circle.fill")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
        }
    }
}

private struct InfoRow: View {
    let icon: String
    let title: String
    let value: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(AppTheme.utsGreen)
                .frame(width: 28)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(AppTheme.muted)
                Text(value)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(AppTheme.ink)
            }
            Spacer()
        }
    }
}

private struct FlowLayout<Data: RandomAccessCollection, Content: View>: View where Data.Element: Hashable {
    let items: Data
    let content: (Data.Element) -> Content

    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 110), spacing: 8)], alignment: .leading, spacing: 8) {
            ForEach(Array(items), id: \.self) { item in
                content(item)
            }
        }
    }
}
