import SwiftUI

#if DEBUG
extension Element {
    static let previewTextPure = Element(name: "Text Pure", style: .text)
    static let previewTextCopy = Element(name: "Text Copy", style: .text, value: "hello world", action: .copy)
    static let previewTextLink = Element(name: "Text Link", style: .text, value: "https://www.google.com", action: .link)
    static let previewButtonCopy = Element(name: "Copy", style: .button, value: "hello world", action: .copy)
    static let previewButtonCopyTimestamp = Element(name: "Copy Timestamp", style: .button, value: "*yyyyMMdd.hhmmss*", action: .copy)
    static let previewButtonLink = Element(name: "Link", style: .button, value: "https://www.google.com", action: .link)
    static let previewButtonLinkAndCopyTimestamp = Element(name: "Link Copy Timestamp", style: .button, value: "https://www.google.com", action: .link, extend: "*yyyyMMdd.hhmmss*")
    static let previewBlock = Element(name: "", style: .text)
}

extension Rowx {
    static let previewText = Rowx(elements: [
        .previewTextPure,
        .previewBlock,
        .previewTextCopy,
        .previewTextLink,
    ])
    static let previewButton = Rowx(elements: [
        .previewButtonCopy,
        .previewButtonCopyTimestamp,
        .previewButtonLink,
        .previewButtonLinkAndCopyTimestamp,
    ])
}

extension Section {
    static let previewTitled = Section(title: "Preview Section", background: true, rows: [.previewText, .previewButton])
    static let previewNoTitle = Section(rows: [.previewText, .previewButton])
}

extension Page {
    static let preview = Page(name: "Preview Page", sections: [.previewTitled, .previewNoTitle])
}

extension Env {
    static let preview = Env(name: "Preview", pages: [.preview, .preview])
}

struct Preview {}
extension Preview {
    static let json: String = """
{
    "pages": [
        {
            "name": "Text",
            "sections": [
                {
                    "rows": [
                        {
                            "elements": [
                                {
                                    "name": "純文字",
                                    "style": "text"
                                }
                            ]
                        },
                        {
                            "elements": [
                                {
                                    "name": "文字連結",
                                    "style": "text",
                                    "action": "link",
                                    "value": "https://google.com.tw"
                                }
                            ]
                        }
                    ]
                },
                {
                    "title": "Text To Copy",
                    "background": true,
                    "rows": [
                        {
                            "elements": [
                                {
                                    "name": "點我複製文字",
                                    "style": "text",
                                    "action": "copy",
                                    "value": "https://google.com.tw"
                                }
                            ]
                        }
                    ]
                }
            ]
        },
        {
            "name": "按鈕",
            "sections": [
                {
                    "title": "基礎按鈕",
                    "background": true,
                    "rows": [
                        {
                            "elements": [
                                {
                                    "name": "複製網站連結",
                                    "style": "button",
                                    "action": "copy",
                                    "value": "https://google.com.tw"
                                }
                            ]
                        },
                        {
                            "elements": [
                                {
                                    "name": "前往網站",
                                    "style": "button",
                                    "action": "link",
                                    "value": "https://google.com.tw"
                                }
                            ]
                        }
                    ]
                }
            ]
        },
        {
            "name": "特殊規則",
            "sections": [
                {
                    "title": "特殊按鈕",
                    "background": true,
                    "rows": [
                        {
                            "elements": [
                                {
                                    "name": "複製時間戳",
                                    "style": "button",
                                    "action": "copy",
                                    "value": "*yyyyMMdd.hhmmss*",
                                },
                                {
                                    "name": "前往網站並複製文字",
                                    "style": "button",
                                    "action": "link",
                                    "value": "https://google.com.tw",
                                    "extend": "我複製了一段文字"
                                },
                                {
                                    "name": "前往網站並複製時間戳",
                                    "style": "button",
                                    "action": "link",
                                    "value": "https://google.com.tw",
                                    "extend": "*yyyyMMdd.hhmmss*"
                                }
                            ]
                        }
                    ]
                }
            ]
        }
    ]
}
"""
}
#endif
