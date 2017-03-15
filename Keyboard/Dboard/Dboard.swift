//
//  Dboard.swift
//  DioGhvKeyboard
//
//  Created by silly on 07/03/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import SnapKit
import SQLite

class Dboard: KeyboardViewController {
    
    var currentInputString: String = ""
    var candidateSet: [String] = []
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.currentInputString = ""
        
        let candidateSelectedNotification = Notification.Name.init(rawValue: "CandidateSelectedNotification")
        NotificationCenter.default.addObserver(self, selector: #selector(Dboard.candidateSelected(_:)), name: candidateSelectedNotification, object: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func keyPressed(_ key: Key) {
        
        let textDocumentProxy = self.textDocumentProxy
        
        print(key)
        
        switch key.type {
        case .character:
            currentInputString += self.shiftState != .disabled ? key.uppercaseKeyCap! : key.lowercaseOutput!
            updateBanner()
        case .return:
            if currentInputString != "" {
                textDocumentProxy.insertText(currentInputString)
                self.currentInputString = ""
                updateBanner()
            } else {
                textDocumentProxy.insertText(key.lowercaseOutput!)
            }
        default:
            textDocumentProxy.insertText(key.lowercaseOutput!)
        }
        
    }
    
    override func setupKeys() {
        super.setupKeys()
    }
    
    override func createBanner() -> ExtraView? {
        return DboardCandidateView(globalColors: type(of: self).globalColors, darkMode: false, solidColorMode: false)
    }
    
}

extension Dboard {
    
    func candidatesBy(_ inputString: String) -> [String] {
        var ret = [String]()
        
        if inputString == "" {
            return ret
        }
        
        let db = DBManager.singleton.connection
        if db != nil {
            let dieziu = Table("dieziu")
            var likeString = "%"
            for c in inputString.characters {
                likeString = likeString  + "\(c)" + "%"
            }
            let query = dieziu.filter(DBManager.pronunciationEx .like(likeString)).order(DBManager.frequencyEx.desc).limit(20)
            print(query)
            do {
                for row in try db!.prepare(query) {
                    ret.append(row[DBManager.nameEx])
                }
            } catch {
                print("Data Prepare Failed")
            }
            
        }
        
        return ret
    }
    
    func updateBanner() {
        let candidateView = self.bannerView as! DboardCandidateView
        candidateView.updateBanner(candidateList: candidatesBy(currentInputString), inputKeyString: currentInputString)
    }

    func candidateSelected(_ notification: Notification) {
        
        let userInfo = notification.userInfo
        let candidateString = userInfo!["DboardCandidate"] as! String
        let textDocumentProxy = self.textDocumentProxy
        textDocumentProxy.insertText(candidateString)
        currentInputString = ""
        updateBanner()
        
    }
    
}
