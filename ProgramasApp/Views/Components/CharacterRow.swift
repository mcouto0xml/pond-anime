import SwiftUI

struct CharacterRow: View {
    let nome: String
    let papel: String
    let emoji: String

    var body: some View {
        HStack(spacing: 12) {
            Text(emoji)
                .font(.title2)
                .frame(width: 44, height: 44)
                .background(Color.gray.opacity(0.18))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 2) {
                Text(nome)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(papel)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.10))
        .cornerRadius(10)
    }
}
