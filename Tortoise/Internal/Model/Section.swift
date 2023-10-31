import SwiftUI

struct Section {
    var id: Int64 = 0
    var pageID: Int64 = 0
    var order: Int = -1
    
    var title: String?
    var background: Bool?
    var rows: [Rowx] = []
}

extension Section: Codable, Hashable, Identifiable {}
