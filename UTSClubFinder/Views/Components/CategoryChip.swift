import SwiftUI

struct CategoryChip: View {
    let title: String
    let systemImage: String?
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                if let systemImage {
                    Image(systemName: systemImage)
                }
                Text(title)
            }
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(isSelected ? Color.white : AppTheme.ink)
            .padding(.horizontal, 12)
            .padding(.vertical, 9)
            .background(isSelected ? AppTheme.utsGreen : AppTheme.card)
            .overlay(
                Capsule()
                    .stroke(isSelected ? AppTheme.utsGreen : AppTheme.line, lineWidth: 1)
            )
            .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}
