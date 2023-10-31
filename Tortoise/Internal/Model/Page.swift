import SwiftUI

struct Page {
    var id: Int64 = 0
    var order: Int = -1
    
    var name: String
    var sections: [Section] = []
}

extension Page: Codable, Hashable, Identifiable {}

extension Page {
    static var empty = Page(name: "empty")
}
