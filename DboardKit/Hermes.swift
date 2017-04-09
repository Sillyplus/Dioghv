//
//  Hermes.swift
//  DioGhvKeyboard
//
//  Created by silly on 20/03/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import SQLite

public struct Candy {
    public var id: Int64
    public var word: String
    
    public init() {
        id = -1
        word = ""
    }
    
    init(id: Int64, word: String) {
        self.id = id
        self.word = word
    }
}

public class Hermes {
    
    lazy var dbM: Zeus = {
        let zeus = Zeus.singleton
        return zeus
    }()

    public static let `default`: Hermes = {
        let instance = Hermes()
        return instance
    }()
    
    private init() {
        
    }
    
}

extension Hermes {
    
    public func candidates(with str: String) -> [Candy] {
        
        var ret: [Candy] = []
        
        if str == "" {
            return ret
        }
        
        let tableName = Zeus.stringNameBy(PrimaryArea: Zeus.singleton.primaryArea!, AndType: Zeus.singleton.chineseType!)
        if let db = dbM.connection {
            let tb = Table(tableName)
            var likeString = "%"
            for c in str.characters {
                likeString = likeString + "\(c)" + "%"
            }
            let query = tb.filter(Zeus.pronunciationEx.like(likeString)).order(Zeus.frequencyEx.desc).limit(30)
            
            do {
                for row in try db.prepare(query) {
                    ret.append(Candy(id: row[Zeus.idEx], word: row[Zeus.nameEx]))
                }
            } catch {
                
            }
        } else {
            
        }

        return ret
    }
    
    public func predictions(with str: String) -> [Candy] {
        // TODO: Return predictions from selected string str
        return []
    }
    
    public func confirm(selected candyId: Int64) {
        
        let tableName = Zeus.stringNameBy(PrimaryArea: Zeus.singleton.primaryArea!, AndType: Zeus.singleton.chineseType!)
        if let db = dbM.connection {
            let tb = Table(tableName)
            
            do {
                var freq = 0.0
                if let candy = try db.pluck(tb.filter(Zeus.idEx == candyId)) {
                    freq = candy[Zeus.frequencyEx]
                } else {
                    print("Get Freq. Failed")
                }
                if try db.run(tb.filter(Zeus.idEx == candyId).update(Zeus.frequencyEx <- (freq + 1.0))) == 1 {
                    print("Update Freq. Success")
                } else {
                    print("No Freq. Updated")
                }
            } catch {
                print("Update Freq. Failed")
            }
        }
    }
    
    
    public func search(with word: String) -> [Row] {
        var ret: [Row] = []

        let tableName = Zeus.stringNameBy(PrimaryArea: Zeus.singleton.primaryArea!, AndType: Zeus.singleton.chineseType!)
        if let db = dbM.connection {
            let tb = Table(tableName)
            let likeString = "%\(word)%"
            let query = tb.filter(Zeus.nameEx.like(likeString)).order(Zeus.frequencyEx.desc)
            do {
                for row in try db.prepare(query) {
                    ret.append(row)
                }
            } catch {
                print("Prepare Data Failed")
            }
        } else {
            print("Connect to DB Failed")
        }
        
        return ret
    }
}
