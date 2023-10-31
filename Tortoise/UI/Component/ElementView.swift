import SwiftUI
import Ditto

struct ElementView: View {
    @Environment(\.injected) private var container
    @Environment(\.openURL) private var openURL
    var element: Element
    var width: CGFloat
    
    private let miniTextScale: CGFloat = 0.8
    
    var body: some View {
        build(element)
    }
    
    @ViewBuilder
    private func build(_ elem: Element) -> some View {
        if isValid(elem) {
            switch elem.style {
                case .text:
                    text(elem)
                case .button:
                    button(elem)
            }
        } else {
            invalid()
        }
    }
    
    @ViewBuilder
    private func invalid() -> some View {
        Text("?")
            .lineLimit(1)
            .minimumScaleFactor(miniTextScale)
            .frame(width: width, height: Config.elementHeight)
            .foregroundColor(.gray)
            .fontWeight(.light)
    }
    
    @ViewBuilder
    private func text(_ elem: Element) -> some View {
        if elem.value == nil {
            Text(elem.name)
                .lineLimit(1)
                .minimumScaleFactor(miniTextScale)
                .padding(.horizontal)
                .frame(width: width, height: Config.elementHeight)
                .fontWeight(.light)
        } else {
            Button(width: width, height: Config.elementHeight) {
                switch elem.action {
                    case .copy:
                        handleCopy(elem.value!)
                    case .link:
                        handleOpen(elem.value!)
                    default:
                        return
                }
            } content: {
                Text(elem.name)
                    .lineLimit(1)
                    .minimumScaleFactor(miniTextScale)
                    .underline(elem.action == .link)
                    .foregroundColor(elem.action == .link ? .blue : nil)
                    .padding(.horizontal)
                    .fontWeight(.light)
            }
        }
        
    }
    
    @ViewBuilder
    private func button(_ elem: Element) -> some View {
        if elem.value != nil {
            Button(width: width, height: Config.elementHeight, colors: [.blue, .glue], radius: Config.elementHeight*0.3) {
                if elem.action == .copy {
                    handleCopy(elem.value!)
                    return
                }
                
                if elem.action != .link { return }
                
                if elem.extend != nil {
                    handleCopyLinkExtend(elem.extend!)
                }
                
                handleOpen(elem.value!)
            } content: {
                Text(elem.name)
                    .lineLimit(1)
                    .minimumScaleFactor(miniTextScale)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .fontWeight(.light)
            }
            .shadow(radius: 3)
        }
    }
}

fileprivate extension ElementView {
    func handleCopyLinkExtend(_ extend: String) {
        let (format, ok) = tryParseTimestampFormat(extend)
        if ok {
            Util.copy(Date.now.string(format, .us))
            return
        }
        Util.copy(extend)
    }
    
    func handleCopy(_ value: String) {
        defer {
            if container.interactor.preference.get(bool: .copyAndCloseApp) {
                container.interactor.system.pushMenubarState(false)
            }
        }
        let (format, ok) = tryParseTimestampFormat(value)
        if ok {
            Util.copy(Date.now.string(format, .us))
            return
        }
        Util.copy(value)
    }
    
    func handleOpen(_ s: String) {
        defer {
            if container.interactor.preference.get(bool: .openAndCloseApp) {
                container.interactor.system.pushMenubarState(false)
            }
        }
        guard let url = URL(string: s) else { return }
        openURL(url)
    }
    
    func tryParseTimestampFormat(_ string: String) -> (String, Bool) {
        if string.count <= 2 || string.first! != "*" || string.last! != "*"{ return ("", false) }
        return (String(string.dropFirst().dropLast(1)), true)
    }
}

fileprivate extension ElementView {
    func isValid(_ e: Element) -> Bool {
        if isText(e) || isCopyText(e) || isLinkText(e) || isCopyButton(e) || isLinkButton(e) { return true }
        return false
    }

    func isText(_ e: Element) -> Bool { e.style == .text && e.action == nil && e.value == nil && e.extend == nil }
    func isCopyText(_ e: Element) -> Bool { e.style == .text && e.action == .copy && e.value != nil && e.extend == nil }
    func isLinkText(_ e: Element) -> Bool { e.style == .text && e.action == .link && e.value != nil && e.extend == nil }
    func isCopyButton(_ e: Element) -> Bool { e.style == .button && e.action == .copy && e.value != nil && e.extend == nil }
    func isLinkButton(_ e: Element) -> Bool { e.style == .button && e.action == .link && e.value != nil }
}

#if DEBUG
struct ElementView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ElementView(element: .previewTextPure, width: 150)
            ElementView(element: .previewTextCopy, width: 150)
            ElementView(element: .previewTextLink, width: 150)
            ElementView(element: .previewButtonCopy, width: 150)
            ElementView(element: .previewButtonCopyTimestamp, width: 150)
            ElementView(element: .previewButtonLink, width: 150)
            ElementView(element: .previewButtonLinkAndCopyTimestamp, width: 150)
        }
        .padding()
    }
}
#endif
