import Foundation

/// Расширение для массива, содержащее метод для поиска первого индекса элемента с совпадающим идентификатором.
extension Array where Element: Identifiable {
    
    /// Метод для поиска первого индекса элемента с совпадающим идентификатором.
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if(self[index].id == matching.id)
            {
                return index;
            }
        }
        return nil;
    }
}

/// Расширение для массива, содержащее свойство, возвращающее единственный элемент массива.
extension Array {
    
    /// Свойство, возвращающее единственный элемент массива.
    var only: Element? {
        count == 1 ? first : nil
    }
}
