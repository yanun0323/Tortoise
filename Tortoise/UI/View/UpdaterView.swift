import SwiftUI
import Sparkle

struct UpdaterView: View {
    var updater = SPUStandardUpdaterController(startingUpdater: true, updaterDelegate: nil, userDriverDelegate: nil).updater
    var body: some View {
        Button("檢查更新") {
            updater.checkForUpdates()
        }
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    UpdaterView()
}
