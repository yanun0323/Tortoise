import SwiftUI
import Ditto

struct Env {
    var id: Int64 = 0
    var name: String = ""
    var pages: [Page] = []
}

extension Env: Codable, Hashable, Identifiable {}

extension Env {
    static var empty = Env(name: "")
}

extension Env {
    init?(_ json: String) {
        guard let json = json.data(using: .utf8) else {
            return
        }
        System.doCatch("transfer json") {
            self = try JSONDecoder().decode(Env.self, from: json)
        }
    }
}
