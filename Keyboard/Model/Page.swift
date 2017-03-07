//
//  Page.swift
//  DioGhvKeyboard
//
//  Created by silly on 07/03/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation

class Page {
    var rows: [[Key]]
    
    init() {
        self.rows = []
    }
    
    func addKey(_ key: Key, row: Int) {
        if self.rows.count <= row {
            for _ in self.rows.count...row {
                self.rows.append([])
            }
        }
        
        self.rows[row].append(key)
    }
}
