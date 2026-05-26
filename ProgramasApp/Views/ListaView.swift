import SwiftUI

struct ListaView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(programas) { programa in
                        NavigationLink(destination: ProgramaDetailView(programa: programa)) {
                            ShowCard(programa: programa)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
            .background(Color.gray.opacity(0.08))
            .navigationTitle("Programas")
        }
    }
}

// MARK: - Preview
#Preview {
    ListaView()
}
