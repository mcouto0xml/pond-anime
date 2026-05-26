# Ponderada Anime
### Alunos Envolvidos:

- Murilo Couto Oliveira
- Mariella Sayumi Mercado Kamezawa


---

## 1. Visão geral do projeto

O projeto consiste em um app iOS desenvolvido em SwiftUI que exibe um catálogo de programas de TV, animes e desenhos. O app tem duas telas principais:

- **Tela 1:** lista os programas em cards visuais, cada um com informações resumidas
- **Tela 2:** exibe os detalhes completos do programa selecionado, sinopse, episódios, temporadas, status e personagens principais

O modelo de dados (`Programa.swift`) foi fornecido pelo professor e contém três objetos prontos: `naruto`, `avatar` e `strangerThings`. A partir disso, a tarefa foi construir toda a interface visual.

---

## 2. Processo de aprendizado

### Referências e fontes consultadas

Apesar de já termos tido contato com os conceitos em aula, o desenvolvimento prático levanta dúvidas mais específicas que precisam de pesquisa direta. As principais fontes que consultamos foram:

- **Documentação oficial da Apple — View Fundamentals:**  
  [https://developer.apple.com/documentation/swiftui/view-fundamentals](https://developer.apple.com/documentation/swiftui/view-fundamentals)  

- **W3Schools Swift UI intro:**  
  [https://www.w3schools.com/swift/swift_ui_intro.asp](https://www.w3schools.com/swift/swift_ui_intro.asp)  


- **Documentação dos componentes individuais:**  
  Durante a construção, consultamos a documentação específica de cada componente (`HStack`, `VStack`, `ZStack`, `NavigationStack`, `ForEach`, `Capsule`, `Rectangle`) para confirmar o comportamento esperado e os modificadores disponíveis.

- **SF Symbols:**  
  [https://developer.apple.com/sf-symbols/](https://developer.apple.com/sf-symbols/)  


### Uso de IA como apoio de sintaxe

Em alguns momentos, consultamos IA generativa para tirar dúvidas pontuais de sintaxe — não para gerar o código, mas para confirmar a forma correta de escrever algo que já tínhamos planejado. Por exemplo: sabíamos que queríamos um retângulo com 6pt de largura na lateral do card, mas queríamos confirmar se o modificador correto era `.frame(width: 6)` ou `.frame(minWidth: 6)`. Esse tipo de consulta foi o uso que fizemos da IA ao longo do projeto.

---

## 3. Planejamento e organização do projeto

Antes de escrever qualquer código, dedicamos um tempo para planejar a estrutura de cada tela e componente. Escrevemos pseudocódigos descrevendo a hierarquia visual de cada parte — quais elementos precisariam estar lado a lado, quais empilhados verticalmente, quais sobrepostos. Esse exercício nos ajudou a mapear qual stack do SwiftUI resolveria cada situação antes de nos preocupar com a sintaxe.

Também definimos a ordem de desenvolvimento com base nas dependências: começar pelos componentes menores (`ShowCard`, `InfoBadge`, `CharacterRow`) antes de montar as telas, já que as telas dependem desses componentes existirem. Testar cada componente isolado no Preview do Xcode antes de integrá-lo à tela foi uma decisão que nos poupou bastante tempo de debug.

---

## 4. Construção da Tela 1 - Lista de Programas

### Decisões de estrutura

Com o planejamento em mãos, a estrutura da Tela 1 ficou clara: um `VStack` com os três cards, cada um envolto em um `NavigationLink` que sabe para qual tela navegar ao ser tocado. O `NavigationStack` envolve tudo como container raiz de navegação.

- `VStack` → empilha os cards verticalmente
- `NavigationStack` → gerencia a pilha de telas do app
- `NavigationLink` → define o destino ao tocar no card
- `.buttonStyle(.plain)` → remove o efeito azul padrão que o SwiftUI aplica automaticamente em links

### Por que começamos pelo ShowCard e não pela ListaView

Seguindo a dica do próprio enunciado, começamos pelos componentes antes das telas. O `ShowCard` é isolado e pode ser testado no Preview sem precisar montar a lista inteira, o que nos permitiu ajustar o visual do card antes de integrá-lo.

### Estrutura final da Tela 1

```swift
NavigationStack {
    ScrollView {
        VStack(spacing: 16) {
            ForEach(programas, id: \.nome) { programa in
                NavigationLink(destination: ProgramaDetailView(programa: programa)) {
                    ShowCard(programa: programa)
                }
                .buttonStyle(.plain)
            }
        }
    }
    .navigationTitle("Programas")
}
```

---

## 5. Construção da Tela 2 — Detalhe do Programa

### O hero com ZStack

O hero é a parte de cima da tela com fundo colorido, emoji grande centralizado e o nome do programa sobre um gradiente escuro. A solução foi um `ZStack`, que sobrepõe elementos em camadas. A ordem de declaração dentro do `ZStack` define qual elemento fica na frente:

1. Fundo colorido (mais embaixo)
2. Emoji grande (no meio)
3. `LinearGradient` escuro de baixo para cima (escurece o fundo para o texto branco ser legível)
4. Badge de tipo + nome do programa (na frente de tudo, alinhados ao canto inferior esquerdo)

### ignoresSafeArea

O modificador `.ignoresSafeArea(edges: .top)` foi necessário para o hero preencher até o topo da tela sem o espaço branco padrão abaixo da câmera. Sem ele, o fundo colorido ficava recuado.

### ForEach nos personagens

A lista de personagens no modelo é um array de tuplas, e tuplas não conformam o protocolo `Identifiable` — o que impede o uso direto no `ForEach`. A solução foi usar `Array(programa.personagens.enumerated())` com `id: \.offset`, que usa o índice de cada item como identificador único.

---

## 6. Componentes reutilizáveis

### ShowCard

O `ShowCard` recebe um `Programa` e monta o card completo. A propriedade computada `tipoColor` centraliza a lógica de cor baseada no tipo do programa, evitando repetir o `switch` nos três lugares onde a cor é usada (barra lateral, thumbnail e badge).

A função `starName(for:rating:)` foi uma decisão que tomamos para tratar meias estrelas — em vez de apenas estrelas cheias e vazias, ela reconhece notas como 4.7 e exibe 4 estrelas cheias e meia, o que ficou mais fiel à avaliação real.

### InfoBadge

Componente que recebe ícone, valor, rótulo e cor, e monta um badge com fundo suave e borda fina. Usamos `.overlay()` para aplicar a borda sem afetar o tamanho do componente — diferente de `.border()`, que adiciona a borda por fora e altera o espaçamento.

### CharacterRow

Representa um personagem com emoji em círculo à esquerda e nome e papel à direita. O `.clipShape(Circle())` recorta o fundo quadrado em formato circular, dando o visual de avatar. O fundo usa `Color(.secondarySystemBackground)`, que se adapta automaticamente ao modo claro e escuro.

---

## 7. Ir Além — a versão escalável

O enunciado oferecia pontos extras para uma versão mais escalável do app. Em vez de criar três `DetailViews` separadas com dados fixos, `NarutoDetailView`, `AvatarDetailView` e `StrangerDetailView`, implementamos uma única `ProgramaDetailView` que recebe qualquer `Programa` como parâmetro.

### O que mudou na ListaView

A versão base pedia três `NavigationLinks` fixos, um para cada programa. Na versão "Ir Além", substituímos isso por um `ForEach` sobre um array de programas:

```swift
// Versão base (três links fixos)
NavigationLink(destination: NarutoDetailView()) { ShowCard(programa: naruto) }
NavigationLink(destination: AvatarDetailView()) { ShowCard(programa: avatar) }
NavigationLink(destination: StrangerDetailView()) { ShowCard(programa: strangerThings) }

// Versão Ir Além (ForEach sobre o array)
let programas: [Programa] = [naruto, avatar, strangerThings]

ForEach(programas, id: \.nome) { programa in
    NavigationLink(destination: ProgramaDetailView(programa: programa)) {
        ShowCard(programa: programa)
    }
}
```

### Por que essa abordagem é melhor

Com a versão base, adicionar um quarto programa exigiria criar um novo arquivo de DetailView e um novo `NavigationLink` manualmente. Com a versão "Ir Além", basta incluir o novo programa no array `programas` , a lista e a navegação se atualizam automaticamente, sem alterar nenhum outro arquivo.

---


## 8. Dificuldades e aprendizados

### O que exigiu mais atenção

**A ordem das camadas no ZStack** não foi imediata. Saber que o SwiftUI renderiza os elementos na ordem em que são declarados, o primeiro fica embaixo, o último fica na frente, é um detalhe que só ficou claro na prática, testando e ajustando.

**Tuplas sem Identifiable** foi um obstáculo no `ForEach` dos personagens. A lista de personagens no modelo usa tuplas, e o SwiftUI exige que cada item tenha um identificador único para renderizar a lista corretamente. A solução com `enumerated()` e `id: \.offset` resolveu o problema de forma limpa.

**O modificador `.ignoresSafeArea`** foi algo que precisamos pesquisar, o comportamento padrão do SwiftUI de respeitar a safe area é útil na maioria dos casos, mas para o hero da Tela 2 precisávamos do fundo colorido preenchendo até o topo.

### O que consolidamos durante o projeto

- A lógica declarativa do SwiftUI, descrever o resultado visual em vez de instruções passo a passo, ficou muito mais clara depois de implementar as duas telas na prática
- Componentes reutilizáveis reduzem código e centralizam responsabilidades, o `ShowCard` sendo reaproveitado três vezes sem repetição foi a demonstração mais direta disso
- Planejar a estrutura antes de codar, mesmo que de forma simples, economiza tempo de retrabalho durante a implementação