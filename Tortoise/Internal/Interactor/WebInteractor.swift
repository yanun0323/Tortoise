import SwiftUI
import Ditto

struct WebInteractor {
    private let appstate: AppState
    private let repo: Repository
    
    init(appstate: AppState, repo: Repository) {
        self.appstate = appstate
        self.repo = repo
    }
}

enum WebError: Error {
    case fetchDataError
    case mismatchStatusCode(code: Int)
    case wrapError(desc: String, err: Error)
    
    var description: String {
        switch self {
            case .fetchDataError:
                return "fetch data error"
            case let .mismatchStatusCode(code):
                return "mismatch status code: \(code)"
            case let .wrapError(desc, err):
                return "\(desc), err: \(err)"
        }
    }
}



extension WebInteractor {
    func fetchCloudData(url: String) -> (Env?, Error?) {
        let (env, statucCode, err) = Http.sendRequest(.GET, toUrl: url, type: Env.self) { _ in }
        if let err = err {
            return (nil, WebError.wrapError(desc: "fetch cloud data", err: err))
        }
        guard let code = statucCode, code >= 200 && code < 300 else {
            return (nil, WebError.mismatchStatusCode(code: statucCode ?? -1))
        }
        guard let env = env else {
            return (nil, WebError.fetchDataError)
        }
        
        return (env, nil)
    }
}
