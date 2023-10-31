import SwiftUI

struct Util {}

extension Util {
    static func copyTimestamp(_ format: String) {
        copy(timestamp(format))
    }
    
    static func timestamp(_ format: String) -> String {
        return Date.now.string(format)
    }
    
    static func copy(_ stringToCopy: String) {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(stringToCopy, forType: .string)
    }
}
