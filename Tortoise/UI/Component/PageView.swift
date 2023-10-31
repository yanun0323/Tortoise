import SwiftUI
import Ditto

struct PageView: View {
    @Binding var page: Page
    var width: CGFloat
    var sectionGap: CGFloat = 15
    
    var body: some View {
        build(page)
    }
    
    @ViewBuilder
    private func build(_ page: Page) -> some View {
        if page.sections.count == 0 {
            Block(width: width)
        } else {
            sections(page.sections)
        }
    }
    
    @ViewBuilder
    private func sections(_ sections: [Section]) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: sectionGap) {
                ForEach(sections, id:\.self) { section in
                    SectionView(section: section, width: width)
                }
                .animation(.none, value: page)
            }
            .transition(.opacity)
        }
    }
}

#if DEBUG
struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PageView(page: .constant(.preview), width: 600)
        }
    }
}
#endif
