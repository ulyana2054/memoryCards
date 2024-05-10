import SwiftUI

/// Структура GridLayout
struct GridLayout {
    /// Размер сетки.
    private(set) var size: CGSize
    /// Количество строк.
    private(set) var rowCount: Int = 0
    /// Количество столбцов.
    private(set) var columnCount: Int = 0
    
    /// Инициализатор
    init(itemCount: Int, nearAspectRatio desiredAspectRatio: Double = 1, in size: CGSize) {
        self.size = size
        // Если ширина или высота равна нулю, или количество элементов не больше нуля,
        // то у нас нет работы (поскольку количество строк и столбцов будет равно нулю)
        guard size.width != 0, size.height != 0, itemCount > 0 else { return }
        // Находим наилучший макет,
        // т.е. тот, который дает ячейкам наименьшее отклонение
        // от желаемого соотношения сторон.
        // Этот код не обязательно самый оптимальный для этого,
        // но он легко читаемый (надеюсь)
        var bestLayout: (rowCount: Int, columnCount: Int) = (1, itemCount)
        var smallestVariance: Double?
        let sizeAspectRatio = abs(Double(size.width/size.height))
        for rows in 1...itemCount {
            let columns = (itemCount / rows) + (itemCount % rows > 0 ? 1 : 0)
            if (rows - 1) * columns < itemCount {
                let itemAspectRatio = sizeAspectRatio * (Double(rows)/Double(columns))
                let variance = abs(itemAspectRatio - desiredAspectRatio)
                if smallestVariance == nil || variance < smallestVariance! {
                    smallestVariance = variance
                    bestLayout = (rowCount: rows, columnCount: columns)
                }
            }
        }
        rowCount = bestLayout.rowCount
        columnCount = bestLayout.columnCount
    }
    
    /// Размер элемента.
    var itemSize: CGSize {
        if rowCount == 0 || columnCount == 0 {
            return CGSize.zero
        } else {
            return CGSize(
                width: size.width / CGFloat(columnCount),
                height: size.height / CGFloat(rowCount)
            )
        }
    }
    
    /// Метод определения расположения элемента по индексу.
    func location(ofItemAt index: Int) -> CGPoint {
        if rowCount == 0 || columnCount == 0 {
            return CGPoint.zero
        } else {
            return CGPoint(
                x: (CGFloat(index % columnCount) + 0.5) * itemSize.width,
                y: (CGFloat(index / columnCount) + 0.5) * itemSize.height
            )
        }
    }
}
