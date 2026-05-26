import SwiftUI

struct ShowCard: View {
    let programa: Programa

    private var tipoColor: Color {
        switch programa.tipo {
        case "Anime":   return .orange
        case "Desenho": return .blue
        default:        return .purple
        }
    }

    private var fundoColor: Color {
        tipoColor.opacity(0.15)
    }

    var body: some View {
        HStack(spacing: 0) {
            Rectangle()
                .fill(tipoColor)
                .frame(width: 6)
                .clipShape(
                    UnevenRoundedRectangle(
                        topLeadingRadius: 16,
                        bottomLeadingRadius: 16
                    )
                )

            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(fundoColor)
                        .frame(width: 64, height: 64)
                    Text(programa.emoji)
                        .font(.system(size: 30))
                }

                VStack(alignment: .leading, spacing: 4) {
                        Text(programa.tipo)
                            .font(.caption2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Capsule().fill(tipoColor))
                        

                    Text(programa.nome)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(1)

                    Text(programa.genero)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(1)

                    HStack(spacing: 2) {
                        ForEach(0..<5, id: \.self) { index in
                            Image(systemName: starName(for: index, rating: programa.avaliacao))
                                .font(.caption)
                                .foregroundColor(.orange)
                        }
                        Text(String(format: "%.1f", programa.avaliacao))
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(Color.secondary.opacity(0.7))
                    .font(.caption)
                    .padding(.trailing, 8)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 12)
        }
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 2)
    }

    private func starName(for index: Int, rating: Double) -> String {
        let threshold = Double(index) + 1.0
        if rating >= threshold {
            return "star.fill"
        } else if rating >= threshold - 0.5 {
            return "star.leadinghalf.filled"
        } else {
            return "star"
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        ShowCard(programa: naruto)
        ShowCard(programa: avatar)
        ShowCard(programa: strangerThings)
        ShowCard(programa: muriloMariella)
    }
    .padding()
    .background(Color.gray.opacity(0.08))
}
