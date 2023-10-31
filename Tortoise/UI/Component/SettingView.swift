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
    var body: some View {
        NavigationSplitView {
            sidebar()
                .navigationSplitViewColumnWidth(200)
        } detail: {
            detail()
        }
    }
    
    @ViewBuilder
    private func sidebar() -> some View {
        VStack {
            if envs.count == 0 {
                Button(width: 150, height: 22, colors: [.green, .yellow], radius: 5) {
                    
                } content: {
                    Text("New Env")
                        .foregroundColor(.white)
                        .shadow(color: .section, radius: 2)
                }
                .shadow(color: .section, radius: 5)
                .padding(.vertical, 10)
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(envs) { e in
                        sidebarButton(e)
                            .contextMenu {
                                Button("Edit") {}
                                Button("Delete", role: .destructive) {}
                            }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func sidebarButton(_ e: Env) -> some View {
        Button(width: 180, height: 25, color: .section, radius: 7) {
            selected = e
        } content: {
            Text(e.name.count != 0 ? e.name : e.id.description)
        }

    }
    
    @ViewBuilder
    private func detail() -> some View {
        Text("This is Detail")
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .inject(.default)
    }
}
