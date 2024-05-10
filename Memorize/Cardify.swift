import SwiftUI

/// Структура Cardify
struct Cardify: AnimatableModifier {
    /// Угол поворота
    var rotation: Double
    
    /// Инициализатор
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    /// Флаг лицевой стороны карты
    var isFaceUp: Bool {
        rotation < 90
    }
    
    /// Анимируемые данные
    var animatableData: Double{
        get { rotation }
        set { rotation = newValue}
    }
    
    /// Создание представления
    func body(content: Content) -> some View{
        ZStack{
            Group {
                RoundedRectangle(cornerRadius:cornerRadius).fill(Color(UIColor.systemBackground))
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content
            }.opacity(isFaceUp ? 1 : 0)
            
            RoundedRectangle(cornerRadius: cornerRadius).fill(Color(UIColor.systemOrange))
                .opacity(isFaceUp ? 0 : 1)
        }.rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
        
    }
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
}

/// Расширение для представления
extension View {
    /// Метод, добавляющий модификатор Cardify к представлению
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
