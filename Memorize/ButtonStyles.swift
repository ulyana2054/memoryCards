import SwiftUI

/// Структура FilledButtonStyle
struct FilledButtonStyle: ButtonStyle {
    /// Цвет фона кнопки
    var backgroundColor: Color
    /// Радиус скругления углов
    let cornerRadius:CGFloat = 10

    /// Создание тела кнопки
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(20)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .blendMode(.overlay)
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .fill(backgroundColor)
                }
            )
            .foregroundColor(.primary)
    }
}
