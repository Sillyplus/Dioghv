//
//  Zeus.swift
//  DioGhvKeyboard
//
//  Created by silly on 17/03/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import SQLite

public enum DboardChineseType: Int {
    case simplified
    case traditional
}

public enum DboardPrimaryArea: Int {
    case suantau
    case dieziu
    case dioion
    case gekion
    case riaupeng
    case tenghai
}


public class Zeus {
    
    // Table Columns
    public static let idEx = Expression<Int64>("id")
    public static let nameEx = Expression<String>("name")
    public static let pronunciationEx = Expression<String>("pron")
    public static let frequencyEx = Expression<Double>("freq")
    
    static let keyEx = Expression<String>("key")
    static let valueEx = Expression<Int>("value")
    
    public var connection: Connection?
    
    public var primaryArea: DboardPrimaryArea? {
        get {
            let primaryAreaInt = Zeus.settingGetValue(forKey: "DboardPrimaryArea")
            return DboardPrimaryArea(rawValue: primaryAreaInt)
        }
        set {
            let newArea = newValue
            if newArea != nil {
                Zeus.settingSet(value: newArea!.rawValue, forKey: "DboardPrimaryArea")
            }
        }
    }
    
    public var chineseType: DboardChineseType? {
        get {
            let chineseTypeInt = Zeus.settingGetValue(forKey: "DboardChineseType")
            return DboardChineseType(rawValue: chineseTypeInt)
        }
        set {
            let newType = newValue
            if newType != nil {
                Zeus.settingSet(value: newType!.rawValue, forKey: "DboardChineseType")
            }
        }
    }
    
    
    private init() {
        do {
            self.connection = try Connection(Utility.appGroupContainerPath()! + "/" + "Dboard.sqlite3")
            print(self.connection ?? "No Connection")
        } catch {
            self.connection = nil
        }
    }
    
    public static let singleton: Zeus = {
        let instance = Zeus()
        return instance
    }()
    
}

extension Zeus {
    
    public class func createTable(named name: String) -> Table? {
        let db = Zeus.singleton.connection
        if db != nil {
            let table = Table(name)
            do {
                try db!.run(table.create(ifNotExists: true) { t in
                    t.column(Zeus.idEx, primaryKey: true)
                    t.column(Zeus.nameEx)
                    t.column(Zeus.pronunciationEx)
                    t.column(Zeus.frequencyEx, defaultValue: 0.0)
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
        let db = Zeus.singleton.connection
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
    
    public class func createSetting() {
        let db = Zeus.singleton.connection
        if db != nil {
            let settingTable = Table("Setting")
            do {
                try db!.run(settingTable.create(ifNotExists: true) { t in
                    t.column(Zeus.idEx, primaryKey: true)
                    t.column(Zeus.keyEx)
                    t.column(Zeus.valueEx, defaultValue: 0)
                })
            } catch {
                print("Create Setting Failed")
            }
        }
    }
    
    class func settingSet(value: Int, forKey key: String) {
        let db = Zeus.singleton.connection
        let settingTable = Table("Setting")
        let keyRow = settingTable.filter(Zeus.keyEx == key)
        do {
            if try db!.run(keyRow.update(Zeus.valueEx <- value)) > 0 {
                print("Update Success")
            } else {
                print("Nothing Updated")
            }
        } catch {
            print("Update Failed: \(error)")
        }
    }
    
    class func settingGetValue(forKey key: String) -> Int {
        var ret = 0
        
        let db = Zeus.singleton.connection
        let settingTable = Table("Setting")
        let query = settingTable.filter(Zeus.keyEx == key)
        
        do {
            if let row = try db!.pluck(query) {
                ret = row[Zeus.valueEx]
                return ret
            } else {
                print("try to insert new key")
                try db!.run(settingTable.insert(Zeus.keyEx <- key))
            }
        } catch {
            print("Get Value Failed: \(error)")
        }
        
        return ret
    }
    
}
