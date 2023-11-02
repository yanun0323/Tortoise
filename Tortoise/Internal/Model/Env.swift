import SwiftUI
import Ditto

struct Env {
    var id: Int64
    var name: String
    var pages: [Page]
    
    init(id: Int64 = 0, name: String, pages: [Page] = []) {
        self.id = id
        self.name = name
        self.pages = pages
    }
}

extension Env: Codable, Hashable, Identifiable {}

extension Env {
    static var empty = Env(name: "New Environment")
}

extension Env {
    init?(_ json: String) {
        guard let json = json.data(using: .utf8) else {
            return nil
        }
        let decoded = System.doCatch("transfer json") {
            return try JSONDecoder().decode(Env.self, from: json)
        }
        
        guard let decoded = decoded else { return nil }
        self = decoded
    }
    
    func json() -> String? {
        let data = System.doCatch("encode to json data") {
            return try JSONEncoder().encode(self)
        }
        guard let data = data else { return nil }
        
        return String(data: data, encoding: String.Encoding.utf8)
    }
}
