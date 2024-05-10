import SwiftUI

/// Структура Pie
struct Pie: Shape {
    /// Начальный угол
    var startAngle: Angle
    /// Конечный угол
    var endAngle: Angle
    /// Направление обхода (по часовой стрелке или против)
    var clockWise: Bool = false
    
    /// Анимируемые данные
    var animatableData: AnimatablePair<Double,Double>{
        get{
            AnimatablePair(startAngle.radians, endAngle.radians)
        }
        set{
            startAngle = Angle.radians(newValue.first)
            endAngle = Angle.radians(newValue.second)
        }
    }
    
    /// Создание пути
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(
            x: center.x + radius * cos(CGFloat(startAngle.radians)),
            y: center.y + radius * sin(CGFloat(startAngle.radians))
        )
        
        var p = Path();
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: clockWise
        )
        return p;
    }
}
