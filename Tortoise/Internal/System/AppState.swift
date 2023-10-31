import SwiftUI
import Combine

struct AppState {
    private static var `default`: Self? = nil
    
    var menubarState = PassthroughSubject<Bool, Never>()
}

extension AppState {
    static func get() -> Self {
        if Self.default == nil {
            Self.default = Self()
        }
        return Self.default!
    }
}
