import SwiftUI
import Ditto

extension DIContainer {
    var appstate: AppState { AppState.get() }
    var interactor: Interactor { Interactor.get(isMock: self.isMock) }
}

struct Interactor {
    private static var `default`: Self? = nil
    
    let system: SystemInteractor
    let preference: PreferenceInteractor
    
    init(appstate: AppState, isMock: Bool) {
        let repo: Repository = Dao()
        self.system = SystemInteractor(appstate: appstate, repo: repo)
        self.preference = PreferenceInteractor(appstate: appstate)
    }
}

extension Interactor {
    static func get(isMock: Bool) -> Self {
        if Self.default == nil {
            Self.default = Interactor(appstate: AppState.get(), isMock: isMock)
        }
        return Self.default!
    }
}
