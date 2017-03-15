//
//  DBManager.swift
//  DioGhvKeyboard
//
//  Created by silly on 11/03/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import SQLite

class DBManager {
    
    // Table Columns
    static let idEx = Expression<Int64>("id")
    static let nameEx = Expression<String>("name")
    static let pronunciationEx = Expression<String>("pron")
    static let frequencyEx = Expression<Double>("freq")
    
    var connection: Connection?
    
    private init() {
        do {
            self.connection = try Connection(Utilities.appGroupContainerPath()! + "/" + "Dboard.sqlite3")
        } catch {
            self.connection = nil
        }
    }

    static let singleton: DBManager = {
        let instance = DBManager()
        return instance
    }()
    
}

extension DBManager {
    
    class func createTable(named name: String) -> Table? {
        let db = DBManager.singleton.connection
        if db != nil {
            let table = Table(name)
            do {
                try db!.run(table.create(ifNotExists: true) { t in
                    t.column(DBManager.idEx, primaryKey: true)
                    t.column(DBManager.nameEx)
                    t.column(DBManager.pronunciationEx)
                    t.column(DBManager.frequencyEx, defaultValue: 0.0)
                })
                return table
            } catch {
                print("Create Table Failed")
                return nil
            }
        } else {
            print("Connect to DB failed")
            return nil
        }
    }
    
    class func dropTable(named name: String) {
        let db = DBManager.singleton.connection
        if db != nil {
            let table = Table(name)
            do {
                try db!.run(table.drop(ifExists: true))
            } catch {
                print("Drop Table Failed")
            }
        } else {
            print("Connect DB Failed")
        }
    }
    
}
