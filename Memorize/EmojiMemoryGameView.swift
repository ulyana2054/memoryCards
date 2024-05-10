import SwiftUI

/// Представление для отображения игры Emoji Memory.
struct EmojiMemoryGameView: View {
    /// ViewModel игры Emoji Memory.
    @ObservedObject var viewModel: EmojiMemoryGame
    /// Продолжительность анимации.
    let duration: Double = 0.350
    
    var body: some View {
        ZStack{
            // Размещение сетки карточек
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    // Обработка нажатия на карточку с анимацией
                    withAnimation(.linear(duration:duration)) {
                        self.viewModel.choose(card: card)
                    }
                }
                .padding()
            }.padding()
            .foregroundColor(.orange)
            
            // Проверка на конец игры и отображение кнопки для новой игры
            if viewModel.isEndGame() {
                HStack{
                    Button(action: { withAnimation(.easeInOut(duration:duration)){
                        self.viewModel.newGame()
                    } } , label: {
                        Text("New Game".uppercased()).foregroundColor(Color(UIColor.label))
                    })
                }.buttonStyle(FilledButtonStyle(backgroundColor: Color(UIColor.systemGray4)))
            }
        }
    }
}

/// Представление карточки игры.
struct CardView: View {
    /// Карточка игры.
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    /// Запуск анимации оставшегося времени бонуса
    private func startBonusTimeAnimation(){
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View{
        // Отображение карточки, если она лицевой стороной вверх или не совпавшая
        if card.isFaceUp || !card.isMatched{
            ZStack{
                // Отображение круговой анимации, если бонусное время еще не истекло
                if card.isConsumingBonusTime {
                    Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockWise: true).padding(5).opacity(0.4)
                        .onAppear {
                            self.startBonusTimeAnimation()
                        }
                }
                else{
                    Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockWise: true).padding(5).opacity(0.4)
                }
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }.cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    // Константы для отображения карточки
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
    private let fontScalingFactor: CGFloat = 0.75
    
    /// Расчет размера шрифта для текста на карточке
    func fontSize(for size: CGSize) -> CGFloat{
        min(size.width,size.height) * fontScalingFactor
    }
}

/// Представление для предпросмотра игры.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame();
        game.choose(card: game.cards[0]);
        return EmojiMemoryGameView(viewModel: game)
    }
}
