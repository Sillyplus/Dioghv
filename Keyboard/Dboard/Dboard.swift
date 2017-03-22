//
//  Dboard.swift
//  DioGhvKeyboard
//
//  Created by silly on 07/03/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import SnapKit
import DboardKit

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
            currentInputString += (self.shiftState != .disabled ? key.uppercaseKeyCap! : key.lowercaseOutput!)
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
        
        for page in keyboard.pages {
            for rowKeys in page.rows {
                for key in rowKeys {
                    if let keyModel = self.layout?.viewForKey(key) {
                        if key.type == .backspace {
                            keyModel.removeTarget(self, action: nil, for: .touchDown)
                            keyModel.addTarget(self, action: #selector(Dboard.backspaceDown(_:)), for: .touchDown)
                            keyModel.addTarget(self, action: #selector(KeyboardViewController.highlightKey(_:)), for: .touchDown)
                            keyModel.addTarget(self, action: #selector(KeyboardViewController.playKeySound), for: .touchDown)
                        }
                    }
                }
            }
        }
        
    }
    
    override func backspaceDown(_ sender: KeyboardKey) {
        self.cancelBackspaceTimers()
        
        if currentInputString == "" {
            self.textDocumentProxy.deleteBackward()
        } else {
            currentInputString = currentInputString.substring(to: currentInputString.index(before: currentInputString.endIndex))
            self.updateBanner()
        }
        
        self.setCapsIfNeeded()
        
        // trigger for subsequent deletes
        self.backspaceDelayTimer = Timer.scheduledTimer(timeInterval: backspaceDelay - backspaceRepeat, target: self, selector: #selector(Dboard.backspaceDelayCallback), userInfo: nil, repeats: false)
    }
    
    override func backspaceDelayCallback() {
        self.backspaceDelayTimer = nil
        self.backspaceRepeatTimer = Timer.scheduledTimer(timeInterval: backspaceRepeat, target: self, selector: #selector(Dboard.backspaceRepeatCallback), userInfo: nil, repeats: true)
    }
    
    override func backspaceRepeatCallback() {
        self.playKeySound()
        if currentInputString == "" {
            self.textDocumentProxy.deleteBackward()
        } else {
            currentInputString = currentInputString.substring(to: currentInputString.index(before: currentInputString.endIndex))
            self.updateBanner()
        }
        self.setCapsIfNeeded()
    }
    
    
    override func createBanner() -> ExtraView? {
        return DboardCandidateView(globalColors: type(of: self).globalColors, darkMode: false, solidColorMode: false)
    }
    
}

extension Dboard {
    
    func candidatesBy(_ inputString: String) -> [Candy] {
        var ret: [Candy] = []
        
        let hermes = Hermes.default
        ret = hermes.candidates(with: inputString)

        return ret
    }
    
    func updateBanner() {
        let candidateView = self.bannerView as! DboardCandidateView
        candidateView.updateBanner(candidateList: candidatesBy(currentInputString), inputKeyString: currentInputString)
    }

    func candidateSelected(_ notification: Notification) {
        
        let userInfo = notification.userInfo
        let candy = userInfo!["DboardCandidate"] as! Candy
        let textDocumentProxy = self.textDocumentProxy
        textDocumentProxy.insertText(candy.word)
        
        let hermes = Hermes.default
        hermes.confirm(selected: candy.id)
        print("Candy: \(candy)")
        
        currentInputString = ""
        updateBanner()
        
    }
    
}
