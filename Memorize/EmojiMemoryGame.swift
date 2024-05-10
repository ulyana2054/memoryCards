import Foundation

/// Класс EmojiMemoryGame
class EmojiMemoryGame: ObservableObject{
    /// Модель игры памяти.
    @Published private var model:MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    /// Создание новой игры.
    private static func createMemoryGame() -> MemoryGame<String> {
        var emojis: Array<String> = []
        for _ in 0...4 {
            emojis.append(String(UnicodeScalar(Int.random(in: 0x1F601...0x1F64F)) ?? "-"))
        }
        return MemoryGame<String>(numberOfPairOfCards: Int.random(in: 2..<6)) { pairIndex in
            return emojis[pairIndex]
        }
    }
       
    /// Проверка завершения игры.
    func isEndGame() -> Bool{
        return model.isEndGame;
    }
    
    /// Начать новую игру.
    func newGame() -> Void{
        model = EmojiMemoryGame.createMemoryGame();
    }
    
    // MARK: - Доступ к модели
    
    /// Свойство, предоставляющее доступ к массиву карт.
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Намерения
    
    /// Выбор карты.
    func choose(card: MemoryGame<String>.Card){
        model.choose(card: card)
    }
}
