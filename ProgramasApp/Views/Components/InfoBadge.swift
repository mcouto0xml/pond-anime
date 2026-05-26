import SwiftUI

struct InfoBadge: View {
    let icone: String
    let valor: String
    let rotulo: String
    let corFundo: Color

    init(icone: String, valor: String, rotulo: String, corFundo: Color) {
        self.icone = icone
        self.valor = valor
        self.rotulo = rotulo
        self.corFundo = corFundo
    }

    var body: some View {
        VStack(spacing: 4) {
            
            Image(systemName: icone)
                .font(.title3)
                .foregroundColor(corFundo.opacity(1.0))

            Text(valor)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.primary)

            Text(rotulo)
                .font(.footnote)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(corFundo.opacity(0.15))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(corFundo.opacity(0.4), lineWidth: 1)
        )
        .cornerRadius(12)
    }
}
