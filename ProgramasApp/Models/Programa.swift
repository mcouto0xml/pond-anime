struct Programa: Identifiable {
    let nome: String
    let tipo: String
    let emoji: String
    let genero: String
    let sinopse: String
    let episodios: Int
    let temporadas: Int
    let avaliacao: Double
    let status: String
    let personagens: [(nome: String, papel: String, emoji: String)]

    var id: String { nome }
}

let naruto = Programa(
    nome: "Naruto", tipo: "Anime", emoji: "\u{1F9C6}",
    genero: "Acao - Aventura",
    sinopse: "Naruto Uzumaki e um jovem ninja que sonha em se tornar Hokage, o lider maximo de sua aldeia.",
    episodios: 720, temporadas: 5, avaliacao: 5.0,
    status: "Concluido",
    personagens: [("Naruto Uzumaki", "Protagonista", "\u{1F9C6}"),
                  ("Sasuke Uchiha", "Rival", "\u{26A1}"),
                  ("Sakura Haruno", "Companheira", "\u{1F338}")]
)

let avatar = Programa(
    nome: "Avatar: A Lenda de Aang", tipo: "Desenho", emoji: "\u{1F30A}",
    genero: "Aventura - Fantasia",
    sinopse: "Aang e o Avatar, mestre dos quatro elementos, destinado a trazer a paz ao mundo em guerra.",
    episodios: 61, temporadas: 3, avaliacao: 5.0,
    status: "Concluido",
    personagens: [("Aang", "Protagonista", "\u{1F30A}"),
                  ("Katara", "Aliada", "\u{1F4A7}"),
                  ("Zuko", "Antagonista", "\u{1F525}")]
)

let strangerThings = Programa(
    nome: "Stranger Things", tipo: "Serie", emoji: "\u{1F526}",
    genero: "Terror - Ficcao Cientifica",
    sinopse: "Um grupo de amigos descobre forcas sobrenaturais e experimentos secretos em sua cidade.",
    episodios: 34, temporadas: 4, avaliacao: 4.7,
    status: "Em exibicao",
    personagens: [("Eleven", "Protagonista", "\u{1F526}"),
                  ("Mike Wheeler", "Lider", "\u{1F9D1}"),
                  ("Demogorgon", "Antagonista", "\u{1F479}")]
)

let muriloMariella = Programa(
    nome: "Murilo & Mariella", tipo: "Serie", emoji: "\u{1F496}",
    genero: "Romance - Aventura",
    sinopse: "Nerd se apaixona pela japonesa popular mais bela da faculdade.",
    episodios: 10, temporadas: 2, avaliacao: 2.3,
    status: "Finalizado",
    personagens: [("Mariella", "Protagonista", "\u{1F496}"),
                  ("Murilo", "Protagonista", "\u{1F9D1}"),
                  ("Spinossauro", "Antagonista", "\u{1F479}"),
                  ("Godzilla", "Amigo do Protagonista", "\u{1F479}")]
)

let programas = [naruto, avatar, strangerThings, muriloMariella]
