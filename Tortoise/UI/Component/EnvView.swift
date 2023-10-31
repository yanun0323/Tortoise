import SwiftUI
import Ditto

struct EnvView: View {
    @Binding var env: Env
    var width: CGFloat
    var height: CGFloat
    
    private let spacing: CGFloat = 15
    @State private var selectedPage: Page
    @State private var selected: Int
    
    init(env: Binding<Env>, size: CGSize) {
        self.init(env: env, width: size.width, height: size.height)
    }
    
    init(env: Binding<Env>, width: CGFloat, height: CGFloat) {
        self._env = env
        self.width = width
        self.height = height
        self.selected = 0
        
        var p = Page.empty
        if env.wrappedValue.pages.count != 0 {
            let page = env.wrappedValue.pages[0]
            if p != page {
                p = page
            }
        }
        self.selectedPage = p
    }
    
    
    var body: some View {
        build(env)
            .onChange(of: selected) { selectedChanged($0) }
    }
    
    @ViewBuilder
    private func build(_ home: Env) -> some View {
        if home.pages.count == 0 {
            Block()
        } else {
            content(home.pages)
        }
    }
    
    @ViewBuilder
    private func content(_ pages: [Page]) -> some View {
        VStack(spacing: spacing){
            pagesTab(pages)
            page()
        }
        .frame(height: height)
    }
    
    @ViewBuilder
    private func pagesTab(_ pages: [Page]) -> some View {
        let tabWidth: CGFloat = width/CGFloat(pages.count)
        let tabHeight: CGFloat = 30
        let tabCorner: CGFloat = 12
        ZStack {
            Color.section
            HStack(spacing: 0) {
                ForEach(0..<selected, id: \.self) { _ in
                    Block(width: tabWidth, height: tabHeight)
                }
                LinearGradient(colors: [.blue, .glue], startPoint: .topLeading, endPoint: .trailing)
                    .frame(width: tabWidth, height: tabHeight)
                    .cornerRadius(tabCorner)
                ForEach(selected..<(pages.count-1), id: \.self) { _ in
                    Block(width: tabWidth, height: tabHeight)
                }
            }
            HStack(spacing: 0) {
                ForEach(pages.indices, id: \.self) { i in
                    Button(width: tabWidth, height: tabHeight) {
                        withAnimation(.regular) {
                            selected = i
                        }
                    } content: {
                        Text(pages[i].name)
                            .foregroundColor(selected == i ? .white : .gray)
                    }
                    .onHover {
                        if !$0 { return }
                        withAnimation(.regular) {
                            selected = i
                        }
                    }
                }
            }
        }
        .frame(width: width, height: tabHeight)
        .cornerRadius(tabCorner)
    }
    
    @ViewBuilder
    private func page() -> some View {
        PageView(page: $selectedPage, width: width)
            .animation(.none, value: selected)
    }
}

fileprivate extension EnvView {
    func selectedChanged(_ selected: Int) {
        withAnimation(.regular) {
            if selected >= env.pages.count {
                selectedPage = .empty
                return
            }
            
            let page = env.pages[selected]
            if selectedPage == page { return }
            selectedPage = page
        }
    }
    
    func homeChanged() {
        selected = 0
        selectedChanged(selected)
    }
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        EnvView(env: .constant(.preview), width: Config.menuBarSize.width, height: Config.menuBarSize.height)
    }
}
#endif
