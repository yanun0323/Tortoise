import SwiftUI

struct RowView: View {
    var row: Rowx
    var width: CGFloat
    var gap: CGFloat
    var padding: CGFloat
    
    var body: some View {
        if row.elements.count == 0 {
            EmptyView()
        } else {
            build(row.elements)
        }
    }
    
    @ViewBuilder
    private func build(_ elems: [Element]) -> some View {
        HStack(spacing: gap) {
            let count = CGFloat(elems.count)
            let w = (width - (count-1)*gap - 2*padding) / count
            ForEach(elems, id:\.self) { elem in
                ElementView(element: elem, width: w)
            }
        }
    }
}

#if DEBUG
struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RowView(row: .previewText, width: 600, gap: 15, padding: 30)
            RowView(row: .previewButton, width: 600, gap: 15, padding: 30)
        }
    }
}
#endif
