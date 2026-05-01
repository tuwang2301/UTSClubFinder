import SwiftUI

struct ClubCardView: View {
    let club: Club
    let isFavourite: Bool
    let onToggleFavourite: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: AppTheme.cornerRadius)
                        .fill(AppTheme.utsGreen.opacity(0.12))
                    Image(systemName: club.category.icon)
                        .foregroundStyle(AppTheme.utsGreen)
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
                        .foregroundStyle(isFavourite ? AppTheme.utsGreen : AppTheme.muted)
                        .frame(width: 32, height: 32)
                }
                .buttonStyle(.plain)
                .accessibilityLabel(isFavourite ? "Remove favourite" : "Save club")
            }

            HStack(spacing: 8) {
                Label(club.category.rawValue, systemImage: "tag.fill")
                Label("\(club.memberCount)", systemImage: "person.2.fill")
                Spacer()
            }
            .font(.caption)
            .foregroundStyle(AppTheme.muted)
        }
        .padding(14)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: AppTheme.cornerRadius)
                .stroke(AppTheme.line, lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
    }
}
