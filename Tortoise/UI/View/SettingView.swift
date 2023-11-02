import SwiftUI
import Ditto

struct SettingView: View {
    @Environment(\.injected) private var container
    #if DEBUG
    @State private var envs: [Env] = [.preview]
    #else
    @State private var envs: [Env] = []
    #endif
    @State private var selected: Env = .empty
//    @State private var detail: (() -> some View)? = nil
    var body: some View {
        NavigationSplitView {
            sidebar()
                .navigationSplitViewColumnWidth(Config.settingSidebarWidth)
        } detail: {
            Text("detail")
        }
        .frame(size: Config.settingOutlineSize)
    }
    
    @ViewBuilder
    private func sidebar() -> some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                HStack {
                    Text("Environment")
                    Spacer()
                    Button(width: 22, height: 22) {
                        envs.append(Env(name: "Empty"))
                    } content: {
                        Image(systemName: "plus")
                            .foregroundColor(.blue)
                            .shadow(color: .section, radius: 2)
                    }
                    .shadow(color: .section, radius: 5)
                }
                .frame(width: 180)
                
                
                ForEach(envs) { e in
                    sidebarButton(e)
                        .contextMenu {
                            Button("Edit \(e.name)") {}
                            Button("Delete \(e.name)", role: .destructive) {}
                        }
                }
                
            }
        }
    }
    
    @ViewBuilder
    private func sidebarButton(_ e: Env) -> some View {
        NavigationLink {
            EditorView(env: e)
                .frame(size: Config.settingContentSize)
        } label: {
            HStack {
                Spacer()
                Text(e.name)
                Spacer()
            }
            .frame(width: 160)
        }
    }
    
    @ViewBuilder
    private func detail() -> some View {
        #if DEBUG
        EditorView(env: .preview)
        #else
        EditorView(env: .empty)
        #endif
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .inject(.default)
    }
}
