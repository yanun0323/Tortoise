import SwiftUI
import SQLite
import Sworm

extension Env: Migrator {
    static var table: Tablex { Tablex("homes") }
    
    static var id = Expression<Int64>("id")
    
    static func migrate(_ conn: Connection) throws {
        try conn.run(table.create(ifNotExists: true) { t in
            t.column(id, primaryKey: true)
        })
        try conn.run(table.createIndex(id, ifNotExists: true))
    }
    
    static func parse(_ row: Row) throws -> Env {
        return Env(
            id: try row.get(id),
            pages: [])
    }
    
    func setter() -> [Setter] {
        return []
    }
}

extension Page: Migrator {
    static var table: Tablex { Tablex("pages") }
    
    static var id = Expression<Int64>("id")
    static var order = Expression<Int>("order")
    static var name = Expression<String>("name")
    
    static func migrate(_ conn: Connection) throws {
        try conn.run(table.create(ifNotExists: true) { t in
            t.column(id, primaryKey: true)
            t.column(order)
            t.column(name)
        })
        try conn.run(table.createIndex(id, ifNotExists: true))
    }
    
    static func parse(_ row: Row) throws -> Page {
        return Page(
            id: try row.get(id),
            order: try row.get(order),
            name: try row.get(name),
            sections: [])
    }
    
    func setter() -> [Setter] {
        return [
            Page.order <- Page.order,
            Page.name <- name,
        ]
    }
}

extension Section: Migrator {
    static var table: Tablex { Tablex("sections") }
    
    static var id = Expression<Int64>("id")
    static var pageID = Expression<Int64>("page_id")
    static var order = Expression<Int>("order")
    
    static var title = Expression<String?>("title")
    static var background = Expression<Bool?>("background")
    
    static func migrate(_ conn: Connection) throws {
        try conn.run(table.create(ifNotExists: true) { t in
            t.column(id, primaryKey: true)
            t.column(pageID)
            t.column(order)
            t.column(title)
            t.column(background)
        })
        try conn.run(table.createIndex(id, ifNotExists: true))
        try conn.run(table.createIndex(pageID, ifNotExists: true))
    }
    
    static func parse(_ row: Row) throws -> Section {
        return Section(
            id: try row.get(id),
            pageID: try row.get(pageID),
            order: try row.get(order),
            title: try row.get(title),
            background: try row.get(background),
            rows: [])
    }
    
    func setter() -> [Setter] {
        return [
            Section.pageID <- pageID,
            Section.order <- order,
            Section.title <- title,
            Section.background <- background
        ]
    }
}

extension Rowx: Migrator {
    static var table: Tablex { Tablex("rows") }
    
    static var id = Expression<Int64>("id")
    static var sectionID = Expression<Int64>("section_id")
    static var order = Expression<Int>("order")
    
    static func migrate(_ conn: Connection) throws {
        try conn.run(table.create(ifNotExists: true) { t in
            t.column(id, primaryKey: true)
            t.column(sectionID)
            t.column(order)
        })
        try conn.run(table.createIndex(id, ifNotExists: true))
        try conn.run(table.createIndex(sectionID, ifNotExists: true))
    }
    
    static func parse(_ row: Row) throws -> Rowx {
        return Rowx(
            id: try row.get(id),
            sectionID: try row.get(sectionID),
            order: try row.get(order),
            elements: [])
    }
    
    func setter() -> [Setter] {
        return []
    }
}

extension Element: Migrator {
    static var table: Tablex { Tablex("elements") }
    
    static var id = Expression<Int64>("id")
    static var rowID = Expression<Int64>("row_id")
    static var order = Expression<Int>("order")
    static var name = Expression<String>("name")
    static var style = Expression<ElementStyle>("style")
    static var value = Expression<String?>("value")
    static var action = Expression<ElementAction?>("action")
    static var extend = Expression<String?>("extend")
    
    static func migrate(_ conn: Connection) throws {
        try conn.run(table.create(ifNotExists: true) { t in
            t.column(id, primaryKey: true)
            t.column(rowID)
            t.column(order)
            t.column(name)
            t.column(style)
            t.column(value)
            t.column(action)
            t.column(extend)
        })
        
        try conn.run(table.createIndex(id, ifNotExists: true))
        try conn.run(table.createIndex(rowID, ifNotExists: true))
    }
    
    static func parse(_ row: Row) throws -> Element {
        return Element(
            id: try row.get(id),
            name: try row.get(name),
            style: try row.get(style),
            value: try row.get(value),
            action: try row.get(action),
            extend: try row.get(extend)
        )
    }
    
    func setter() -> [Setter] {
        return []
    }
}
