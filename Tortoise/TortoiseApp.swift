import SwiftUI
import Ditto

@main
struct TortoiseApp: App {
//    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
//    @Environment(\.scenePhase) var scenePhase
    @State private var container = DIContainer(isMock: true)
    @State private var menubarState: Bool = false
    var body: some Scene {
        MenuBarExtra("", systemImage: "tortoise.fill") {
            MenubarView()
                .frame(size: Config.menuBarSize)
                .inject(container)
                .onReceive(container.appstate.menubarState) { menubarState = $0 }
        }
        .menuBarExtraStyle(.window)
        .menuBarExtraAccess(isPresented: $menubarState)
        
        Window(Config.settingsWindowTitle, id: Config.settingsWindowID) {
            UpdaterView()
                .inject(container)
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    public var statusItem: NSStatusItem?
    private var popOver = NSPopover()
//    private var container = DIContainer(isMock: false)
    private var isAppOpen = false
    
    @MainActor func applicationDidFinishLaunching(_ notification: Notification) {
//        NSApp.appearance = container.interactor.preference.getAppearance()
        
        popOver.setValue(true, forKeyPath: "shouldHideAnchor")
        popOver.contentSize = CGSize(width: 400, height: 600)
        popOver.behavior = .transient
        popOver.animates = true
        popOver.contentViewController = NSViewController()
        popOver.contentViewController = NSHostingController(rootView: MenubarView()
//            .environment(\.injected, container)
            .environment(\.popOver, popOver)
        )
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
//        _ = container.appstate.pubOpenMenubarAppTrigger.sink { self.isAppOpen = $0 }
        
        if let statusButton = statusItem?.button {
#if DEBUG
            statusButton.image = NSImage(systemSymbolName: "tortoise.fill", accessibilityDescription: nil)
#else
            statusButton.image = NSImage(systemSymbolName: "tortoise", accessibilityDescription: nil)
#endif
            statusButton.action = #selector(togglePopover)
        }
    }
    
    @objc public func togglePopover() {
        if let button = statusItem?.button {
//            self.container.interactor.system.pushOpenMenubarAppTrigger(self.isAppOpen)
            self.popOver.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.maxY)
        }
        
    }
}

extension NSPopover: EnvironmentKey {
    public static var defaultValue: NSPopover { NSPopover() }
}

extension EnvironmentValues {
    public var popOver: NSPopover {
        get { self[NSPopover.self] }
        set { self[NSPopover.self] = newValue }
    }
}
