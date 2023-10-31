import SwiftUI
import SQLite

extension ElementStyle: Value {
    typealias Datatype = String
    
    static var declaredDatatype: String {
        return String.declaredDatatype
    }
    
    static func fromDatatypeValue(_ datatypeValue: String) -> ElementStyle {
        return ElementStyle(datatypeValue)
    }
    
    var datatypeValue: String {
        return self.rawValue
    }
}

extension ElementAction: Value {
    typealias Datatype = String
    
    static var declaredDatatype: String {
        return String.declaredDatatype
    }
    
    static func fromDatatypeValue(_ datatypeValue: String) -> ElementAction {
        return ElementAction(datatypeValue)
    }
    
    var datatypeValue: String {
        return self.rawValue
    }
}
