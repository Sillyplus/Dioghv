//
//  DBManager.swift
//  DioGhvKeyboard
//
//  Created by silly on 17/03/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import SQLite

public class DBManager {
    
    // Table Columns
    public static let idEx = Expression<Int64>("id")
    public static let nameEx = Expression<String>("name")
    public static let pronunciationEx = Expression<String>("pron")
    public static let frequencyEx = Expression<Double>("freq")
    
    public var connection: Connection?
    
    private init() {
        do {
            self.connection = try Connection(Utility.appGroupContainerPath()! + "/" + "Dboard.sqlite3")
        } catch {
            self.connection = nil
        }
    }
    
    public static let singleton: DBManager = {
        let instance = DBManager()
        return instance
    }()
    
}

extension DBManager {
    
    public class func createTable(named name: String) -> Table? {
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
    
    public class func dropTable(named name: String) {
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
