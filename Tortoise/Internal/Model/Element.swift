import SwiftUI

struct Element {
    var id: Int64 = 0
    var rowID: Int64 = 0
    var order: Int = -1
    
    var name: String
    var style: ElementStyle
    var value: String?
    var action: ElementAction?
    var extend: String?
}

extension Element: Codable, Hashable {}
extension Element {}
fileprivate extension Element {}

// MARK: - ElementStyle
enum ElementStyle: String {
    case text = "text"
    case button = "button"
    
    init(_ string: String) {
        guard let style = ElementStyle(rawValue: string) else {
            self = .text
            return
        }
        self = style
    }
}

extension ElementStyle: Codable, Hashable, CaseIterable {}

// MARK: - ElementAction
enum ElementAction: String {
    case copy = "copy"
    case link = "link"
    case `none` = ""
    
    init(_ string: String) {
        guard let action = ElementAction(rawValue: string) else {
            self = .none
            return
        }
        self = action
    }
}

extension ElementAction: Codable, Hashable, CaseIterable {}
