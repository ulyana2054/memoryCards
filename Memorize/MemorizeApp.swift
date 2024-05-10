import SwiftUI

/// Основная структура приложения.
@main
struct MemorizeApp: App {
    /// Экземпляр игры Emoji Memory.
    var game = EmojiMemoryGame()
    
    /// Точка входа в приложение.
    var body: some Scene {
        /// Отображение основного окна.
        WindowGroup {
            /// Отображение представления игры Emoji Memory с переданным viewModel.
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
