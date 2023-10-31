import SwiftUI
import Ditto

enum MenubarRouter {
    case content, setting
}

struct MenubarView: View {
    @Environment(\.injected) private var container
    @Environment(\.openWindow) private var openWindow
    #if DEBUG
    @State private var env: Env = .preview
    #else
    @State private var env: Env = .empty
    #endif
    @State private var selectedEnv: String = "Golang"
    private let padding: CGFloat = 15
    private let spacing: CGFloat = 10
    private let headerHeight: CGFloat = 15
    
    var body: some View {
       build()
    }
    
    @ViewBuilder
    private func build() -> some View {
        ZStack {
            mainLayer()
            coverLayer()
        }
    }
    
    @ViewBuilder
    private func mainLayer() -> some View{
        VStack(spacing: spacing) {
            header(height: headerHeight)
            contentRouter()
        }
        .padding(padding)
        .background(Color.background)
    }
    
    @ViewBuilder
    private func coverLayer() -> some View{
        
    }
    
    @ViewBuilder
    private func contentRouter() -> some View {
        EnvView(env: $env, size: contentSize())
    }
    
    @ViewBuilder
    private func header(height: CGFloat) -> some View {
        HStack {
            Button(width: height, height: height, colors: [], radius: height*0.2) {
                container.interactor.system.pushMenubarState(false)
                openSettingsWindow()
            } content: {
                Image(systemName: "gearshape")
                    .foregroundColor(.gray)
                    .font(.system(size: height))
            }
            Spacer()
            
            Menu {
                Picker(selection: $env) {
                    ForEach(["Golang", "Sre", "Rails", "Bito"], id: \.self) { e in
                        Text(e).tag(e)
                    }
                } label: {}
                    .pickerStyle(.inline)
            } label: {
                Text(selectedEnv)
                    .font(.system(size: 11, weight: .light))
                    .foregroundColor(.gray)
            }
            .frame(width: 100, height: height+2, alignment: .center)
            .background(Color.section)
            .menuStyle(.borderlessButton)
            .cornerRadius(5)


            
//            Button(width: 50, height: height+2, color: .section, radius: height*0.2) {
//                container.interactor.system.pushMenubarState(false)
//                openSettingsWindow()
//            } content: {
//                Text("Env")
//                    .font(.system(size: 11, weight: .light))
//                    .foregroundColor(.gray)
//            }
        }
        .padding(.horizontal, 5)
        .frame(width: contentSize().width, height: height)
    }
}

fileprivate extension MenubarView {
    func contentSize() -> CGSize {
        return CGSize(width: Config.menuBarSize.width-2*padding, height: Config.menuBarSize.height-headerHeight-2*padding-spacing)
    }
    
    func openSettingsWindow() {
        openWindow(id: Config.settingsWindowID)
        NSApplication.shared.windows.forEach { window in
            if window.identifier?.rawValue == Config.settingsWindowID {
                NSApp.activate(ignoringOtherApps: true)
                window.makeKeyAndOrderFront(nil)
                
            }
        }
    }
}

struct MenubarView_Previews: PreviewProvider {
    static var previews: some View {
        MenubarView()
            .frame(size: Config.menuBarSize)
    }
}
