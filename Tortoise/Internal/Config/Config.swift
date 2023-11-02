import SwiftUI

struct Config {}

extension Config {
    static let elementHeight: CGFloat = 20
    static let settingSidebarWidth: CGFloat = 200
    
    static let menuBarSize: CGSize = CGSize(width: 500, height: 700)
    static let settingContentSize: CGSize = CGSize(width: 1000, height: 700)
    static let settingOutlineSize: CGSize = CGSize(width: 1000 + settingSidebarWidth, height: 700)
    
    static let settingsWindowTitle: LocalizedStringKey = "settings"
    static let settingsWindowID = "settings-window"
}
