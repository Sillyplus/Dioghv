//
//  Dboard.swift
//  DioGhvKeyboard
//
//  Created by silly on 07/03/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import SnapKit

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
        
        switch key.type {
        case .character:
            currentInputString += key.lowercaseOutput!
            updateBanner()
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
        
        if inputString != "" {
            ret.append("你好")
            ret.append("世界")
            ret.append("食茶")
            ret.append("潮汕话")
            ret.append("测试")
            ret.append("謎語")
            ret.append("汕頭")
            ret.append("潮語")
            ret.append("更新")
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
