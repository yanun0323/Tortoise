import SwiftUI

struct SectionView: View {
    var section: Section
    var width: CGFloat
    var title: Font = Font.system(size: 10, weight: .regular)
    
    private let gap: CGFloat = 10
    private let padding: CGSize = CGSize(width: 10, height: 20)
    
    var body: some View {
       build(section)
    }
    
    @ViewBuilder
    private func build(_ section: Section) -> some View {
        if section.rows.count == 0 {
            EmptyView()
        } else {
            if section.background == true {
                sectionWithBackground(section)
            } else {
                sectionWithoutBackground(section)
            }
        }
    }
    
    @ViewBuilder
    private func sectionWithBackground(_ section: Section) -> some View {
        VStack(spacing: 2) {
            if section.title != nil {
                HStack {
                    Text(section.title!)
                        .lineLimit(1)
                        .foregroundColor(.gray.opacity(0.4))
                        .font(title)
                    Spacer()
                }
                .padding(.leading, 10)
            }
            RoundedRectangle(cornerRadius: 15)
                .frame(height: height())
                .foregroundColor(.section.opacity(0.5))
                .overlay {
                    rows(section.rows)
                }
        }
        .frame(width: width)
    }
    
    @ViewBuilder
    private func sectionWithoutBackground(_ section: Section) -> some View {
        rows(section.rows)
            .frame(width: width, height: height())
    }
    
    @ViewBuilder
    private func rows(_ rows: [Rowx]) -> some View {
        VStack(spacing: gap) {
            let w = width - 2*padding.width
            ForEach(rows, id:\.self) { row in
                RowView(row: row, width: w, gap: gap, padding: padding.width)
            }
        }
        .frame(width: width, height: height())
    }
}

fileprivate extension SectionView {
    func count() -> CGFloat {
        return CGFloat(section.rows.count)
    }
    
    func height() -> CGFloat {
        let count = count()
        var sumGap = gap*(count-1)
        if sumGap <= 0 {
            sumGap = 0
        }
        return Config.elementHeight*count + 2*padding.height + sumGap
    }
}

#if DEBUG
struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SectionView(section: .previewTitled, width: 700)
            SectionView(section: .previewNoTitle, width: 700)
        }
    }
}
#endif
