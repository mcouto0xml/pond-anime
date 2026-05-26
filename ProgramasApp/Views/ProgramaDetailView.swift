import SwiftUI

struct ProgramaDetailView: View {
    let programa: Programa

    private var tipoColor: Color {
        switch programa.tipo {
        case "Anime":   return .orange
        case "Desenho": return .blue
        default:        return .purple 
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {

                ZStack(alignment: .bottomLeading) {
                    Rectangle()
                        .fill(tipoColor.opacity(0.85))
                        .frame(maxWidth: .infinity)
                        .frame(height: 260)

                    Text(programa.emoji)
                        .font(.system(size: 100))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 48)

                    LinearGradient(
                        colors: [.black.opacity(0.75), .clear],
                        startPoint: .bottom,
                        endPoint: .center
                    )
                    .frame(height: 260)

                    VStack(alignment: .leading, spacing: 6) {
                        Capsule()
                            .fill(tipoColor)
                            .overlay(
                                Text(programa.tipo)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 10)
                            )
                            .frame(height: 24)
                            .fixedSize()

                        Text(programa.nome)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                }
                .frame(maxWidth: .infinity)

                VStack(alignment: .leading, spacing: 16) {

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Sinopse")
                            .font(.title2)
                            .fontWeight(.bold)

                        Text(programa.sinopse)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Informacoes")
                            .font(.title2)
                            .fontWeight(.bold)

                        HStack(spacing: 8) {
                            InfoBadge(
                                icone: "play.circle.fill",
                                valor: "\(programa.episodios)",
                                rotulo: "Episodios",
                                corFundo: .orange
                            )
                            InfoBadge(
                                icone: "tv.fill",
                                valor: "\(programa.temporadas)",
                                rotulo: "Temporadas",
                                corFundo: .green
                            )
                            InfoBadge(
                                icone: statusIcone,
                                valor: programa.status == "Concluido" ? "Concluido" : "No ar",
                                rotulo: "Status",
                                corFundo: .blue
                            )
                        }
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Personagens Principais")
                            .font(.title2)
                            .fontWeight(.bold)

                        ForEach(Array(programa.personagens.enumerated()), id: \.offset) { _, personagem in
                            CharacterRow(
                                nome: personagem.nome,
                                papel: personagem.papel,
                                emoji: personagem.emoji
                            )
                        }
                    }

                    Button(action: {}) {
                        Text("Ver Todos os Episodios")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(tipoColor)
                            .cornerRadius(50)
                    }
                    .padding(.top, 4)
                }
                .padding(16)
            }
        }
        .ignoresSafeArea(edges: .top)
#if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
    }

    private var statusIcone: String {
        programa.status == "Concluido" ? "checkmark.circle.fill" : "antenna.radiowaves.left.and.right"
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        ProgramaDetailView(programa: naruto)
    }
}
