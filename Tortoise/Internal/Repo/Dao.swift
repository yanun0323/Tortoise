import SwiftUI
import Sworm

struct Dao {
    init() {
        SQL.getDriver().migrate([
            Element.self,
            Rowx.self,
            Section.self,
            Page.self,
            Env.self
        ])
    }
}

extension Dao: Repository {}
