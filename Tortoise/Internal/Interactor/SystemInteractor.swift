import SwiftUI
import Ditto

struct SystemInteractor {
    private let appstate: AppState
    private let repo: Repository
    
    init(appstate: AppState, repo: Repository) {
        self.appstate = appstate
        self.repo = repo
    }
}

extension SystemInteractor {
    func pushMenubarState(_ state: Bool) {
        System.async {
            appstate.menubarState.send(state)
        }
    }
}
