// ProgramaDetailView.swift -- Tela 2 reutilizavel (versao "Ir Alem")
// Aceita qualquer Programa como parametro -- substitui NarutoDetailView,
// AvatarDetailView e StrangerDetailView
import SwiftUI

struct ProgramaDetailView: View {
    let programa: Programa

    // Cor principal por tipo
    private var tipoColor: Color {
        switch programa.tipo {
        case "Anime":   return .orange
        case "Desenho": return .blue
        default:        return .purple  // Serie
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {

                // TODO E: ZStack hero -- fundo + emoji + overlay gradiente + badge + nome
                ZStack(alignment: .bottomLeading) {
                    // Fundo colorido
                    Rectangle()
                        .fill(tipoColor.opacity(0.85))
                        .frame(maxWidth: .infinity)
                        .frame(height: 260)

                    // Emoji grande centralizado
                    Text(programa.emoji)
                        .font(.system(size: 100))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 48)

                    // Overlay gradiente escuro de baixo para cima
                    LinearGradient(
                        colors: [.black.opacity(0.75), .clear],
                        startPoint: .bottom,
                        endPoint: .center
                    )
                    .frame(height: 260)

                    // Badge de tipo + nome sobrepostos no hero
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

                // Conteudo do detalhe
                VStack(alignment: .leading, spacing: 16) {

                    // TODO F: Sinopse
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Sinopse")
                            .font(.title2)
                            .fontWeight(.bold)

                        Text(programa.sinopse)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    // TODO G: HStack com 3x InfoBadge
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

                    // TODO H: Personagens Principais
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

                    // Botao Ver Todos os Episodios
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
