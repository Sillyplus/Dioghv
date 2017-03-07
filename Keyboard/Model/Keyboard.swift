//
//  Keyboard.swift
//  DioGhvKeyboard
//
//  Created by silly on 07/03/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation

enum ShiftState {
    case disabled
    case enabled
    case locked
    
    func uppercase() -> Bool {
        switch self {
        case .disabled:
            return false
        case .enabled:
            return true
        case .locked:
            return true
        }
    }
}

class Keyboard {
    var pages: [Page]
    
    init() {
        self.pages = []
    }
    
    func addKey(_ key: Key, row: Int, page: Int) {
        if self.pages.count <= page {
            for _ in self.pages.count...page {
                self.pages.append(Page())
            }
        }
        
        self.pages[page].addKey(key, row: row)
    }
}

extension Keyboard {
    
    class func defaultKeyboard() -> Keyboard {
        let defaultKeyboard = Keyboard()
        
        for key in ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"] {
            let keyModel = Key(.character)
            keyModel.setLetter(key)
            defaultKeyboard.addKey(keyModel, row: 0, page: 0)
        }
        
        for key in ["A", "S", "D", "F", "G", "H", "J", "K", "L"] {
            let keyModel = Key(.character)
            keyModel.setLetter(key)
            defaultKeyboard.addKey(keyModel, row: 1, page: 0)
        }
        
        let keyModel = Key(.shift)
        defaultKeyboard.addKey(keyModel, row: 2, page: 0)
        
        for key in ["Z", "X", "C", "V", "B", "N", "M"] {
            let keyModel = Key(.character)
            keyModel.setLetter(key)
            defaultKeyboard.addKey(keyModel, row: 2, page: 0)
        }
        
        let backspace = Key(.backspace)
        defaultKeyboard.addKey(backspace, row: 2, page: 0)
        
        let keyModeChangeNumbers = Key(.modeChange)
        keyModeChangeNumbers.uppercaseKeyCap = "123"
        keyModeChangeNumbers.toMode = 1
        defaultKeyboard.addKey(keyModeChangeNumbers, row: 3, page: 0)
        
        let keyboardChange = Key(.keyboardChange)
        defaultKeyboard.addKey(keyboardChange, row: 3, page: 0)
        
        let settings = Key(.settings)
        defaultKeyboard.addKey(settings, row: 3, page: 0)
        
        let space = Key(.space)
        space.uppercaseKeyCap = "space"
        space.uppercaseOutput = " "
        space.lowercaseOutput = " "
        defaultKeyboard.addKey(space, row: 3, page: 0)
        
        let returnKey = Key(.return)
        returnKey.uppercaseKeyCap = "return"
        returnKey.uppercaseOutput = "\n"
        returnKey.lowercaseOutput = "\n"
        defaultKeyboard.addKey(returnKey, row: 3, page: 0)
        
        for key in ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"] {
            let keyModel = Key(.specialCharacter)
            keyModel.setLetter(key)
            defaultKeyboard.addKey(keyModel, row: 0, page: 1)
        }
        
        for key in ["-", "/", ":", ";", "(", ")", "$", "&", "@", "\""] {
            let keyModel = Key(.specialCharacter)
            keyModel.setLetter(key)
            defaultKeyboard.addKey(keyModel, row: 1, page: 1)
        }
        
        let keyModeChangeSpecialCharacters = Key(.modeChange)
        keyModeChangeSpecialCharacters.uppercaseKeyCap = "#+="
        keyModeChangeSpecialCharacters.toMode = 2
        defaultKeyboard.addKey(keyModeChangeSpecialCharacters, row: 2, page: 1)
        
        for key in [".", ",", "?", "!", "'"] {
            let keyModel = Key(.specialCharacter)
            keyModel.setLetter(key)
            defaultKeyboard.addKey(keyModel, row: 2, page: 1)
        }
        
        defaultKeyboard.addKey(Key(backspace), row: 2, page: 1)
        
        let keyModeChangeLetters = Key(.modeChange)
        keyModeChangeLetters.uppercaseKeyCap = "ABC"
        keyModeChangeLetters.toMode = 0
        defaultKeyboard.addKey(keyModeChangeLetters, row: 3, page: 1)
        
        defaultKeyboard.addKey(Key(keyboardChange), row: 3, page: 1)
        
        defaultKeyboard.addKey(Key(settings), row: 3, page: 1)
        
        defaultKeyboard.addKey(Key(space), row: 3, page: 1)
        
        defaultKeyboard.addKey(Key(returnKey), row: 3, page: 1)
        
        for key in ["[", "]", "{", "}", "#", "%", "^", "*", "+", "="] {
            let keyModel = Key(.specialCharacter)
            keyModel.setLetter(key)
            defaultKeyboard.addKey(keyModel, row: 0, page: 2)
        }
        
        for key in ["_", "\\", "|", "~", "<", ">", "€", "£", "¥", "•"] {
            let keyModel = Key(.specialCharacter)
            keyModel.setLetter(key)
            defaultKeyboard.addKey(keyModel, row: 1, page: 2)
        }
        
        defaultKeyboard.addKey(Key(keyModeChangeNumbers), row: 2, page: 2)
        
        for key in [".", ",", "?", "!", "'"] {
            let keyModel = Key(.specialCharacter)
            keyModel.setLetter(key)
            defaultKeyboard.addKey(keyModel, row: 2, page: 2)
        }
        
        defaultKeyboard.addKey(Key(backspace), row: 2, page: 2)
        
        defaultKeyboard.addKey(Key(keyModeChangeLetters), row: 3, page: 2)
        
        defaultKeyboard.addKey(Key(keyboardChange), row: 3, page: 2)
        
        defaultKeyboard.addKey(Key(settings), row: 3, page: 2)
        
        defaultKeyboard.addKey(Key(space), row: 3, page: 2)
        
        defaultKeyboard.addKey(Key(returnKey), row: 3, page: 2)
        
        return defaultKeyboard
    }

}

