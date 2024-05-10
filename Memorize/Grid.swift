import SwiftUI

/// Структура Grid
struct Grid<Item: Identifiable, ItemView: View>: View {
    /// Массив элементов
    private var items:[Item]
    /// Замыкание для создания представления для каждого элемента
    private var viewForItem: (Item) -> ItemView
    
    /// Инициализатор
    init(_ items:[Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    /// Отображение
    var body: some View {
        GeometryReader{ geometry in
            self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
    }
    
    /// Определение тела для указанной сетки
    func body(for layout: GridLayout) -> some View{
        ForEach(items){ item in
            self.body(for: item, in: layout)
        }
    }
    
    /// Определение тела для указанного элемента в указанной сетке
    func body(for item: Item, in layout: GridLayout) -> some View{
        let index = items.firstIndex(matching: item)!
        return viewForItem(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: index))
    }
    
}
