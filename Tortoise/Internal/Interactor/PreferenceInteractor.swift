import SwiftUI
import Ditto

struct PreferenceInteractor {
    private let appstate: AppState
    
    init(appstate: AppState) {
        self.appstate = appstate
    }
}

extension PreferenceInteractor {
    func get(bool key: BoolKey) -> Bool {
        switch key {
            case .copyAndCloseApp:
                return UserDefaults.copyAndCloseApp
            case .openAndCloseApp:
                return UserDefaults.openAndCloseApp
            default:
                return false
        }
    }
    
    func set(bool key: BoolKey, value: Bool) {
        switch key {
            case .copyAndCloseApp:
                UserDefaults.copyAndCloseApp = value
            case .openAndCloseApp:
                UserDefaults.openAndCloseApp = value
            default:
                return
        }
    }
}

extension PreferenceInteractor {
    enum BoolKey {
        case copyAndCloseApp
        case openAndCloseApp
        case `unknown`
    }
}

extension UserDefaults {
    @UserDefaultState(key: "copy_and_close_app", defaultValue: true)
    static var copyAndCloseApp: Bool
    
    @UserDefaultState(key: "open_and_close_app", defaultValue: false)
    static var openAndCloseApp: Bool
}
