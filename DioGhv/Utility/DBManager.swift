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
    
    var connection: Connection?
    
    private init() {
        do {
            self.connection = try Connection(Utilities.appGroupContainerPath()! + "/" + "Dboard.sqlite3")
        } catch {
            self.connection = nil
        }
    }

    static let `default`: DBManager = {
        let singleton = DBManager()
        return singleton
    }()
    
}
