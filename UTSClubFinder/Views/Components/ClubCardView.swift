import SwiftUI

struct ClubCardView: View {
    let club: Club
    let isFavourite: Bool
    let onToggleFavourite: () -> Void

    private var accentColor: Color {
        club.category.accentColor
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: AppTheme.cornerRadius)
                        .fill(accentColor.opacity(0.14))
                    Image(systemName: club.category.icon)
                        .foregroundStyle(accentColor)
                        .font(.title3.weight(.semibold))
                }
                .frame(width: 48, height: 48)

                VStack(alignment: .leading, spacing: 4) {
                    Text(club.name)
                        .font(.headline)
                        .foregroundStyle(AppTheme.ink)
                    Text(club.tagline)
                        .font(.subheadline)
                        .foregroundStyle(AppTheme.muted)
                        .lineLimit(2)
                }

                Spacer()

                Button(action: onToggleFavourite) {
                    Image(systemName: isFavourite ? "bookmark.fill" : "bookmark")
                        .foregroundStyle(isFavourite ? accentColor : AppTheme.muted)
                        .frame(width: 32, height: 32)
                }
                .buttonStyle(.plain)
                .accessibilityLabel(isFavourite ? "Remove favourite" : "Save club")
            }

            HStack(spacing: 8) {
                Label(club.category.rawValue, systemImage: "tag.fill")
                    .foregroundStyle(accentColor)
                    .padding(.horizontal, 9)
                    .padding(.vertical, 5)
                    .background(accentColor.opacity(0.14))
                    .clipShape(Capsule())

                Label("\(club.memberCount)", systemImage: "person.2.fill")
                    .foregroundStyle(AppTheme.muted)
                Spacer()
            }
            .font(.caption)
        }
        .padding(14)
        .background(AppTheme.card)
        .overlay(alignment: .leading) {
            Rectangle()
                .fill(accentColor)
                .frame(width: 4)
        }
        .overlay(
            RoundedRectangle(cornerRadius: AppTheme.cornerRadius)
                .stroke(AppTheme.line, lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
    }
}

private extension ClubCategory {
    var accentColor: Color {
        switch self {
        case .technology:
            Color(red: 0.024, green: 0.549, blue: 0.231)
        case .culture:
            Color(red: 0.357, green: 0.341, blue: 0.851)
        case .sport:
            Color(red: 1.000, green: 0.416, blue: 0.239)
        case .creative:
            Color(red: 1.000, green: 0.180, blue: 0.388)
        case .academic:
            Color(red: 0.114, green: 0.478, blue: 0.953)
        case .volunteering:
            Color(red: 0.192, green: 0.780, blue: 0.349)
        }
    }
}
