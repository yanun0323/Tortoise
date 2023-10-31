import SwiftUI

struct Rowx {
    var id: Int64 = 0
    var sectionID: Int64 = 0
    var order: Int = -1
    
    var elements: [Element] = []
}

extension Rowx: Codable, Hashable, Identifiable {}
