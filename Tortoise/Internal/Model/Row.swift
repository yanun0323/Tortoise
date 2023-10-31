import SwiftUI

struct Rowx {
    var elements: [Element]?
}

extension Rowx: Codable, Hashable, Identifiable {
    var id: Self { self }
}
