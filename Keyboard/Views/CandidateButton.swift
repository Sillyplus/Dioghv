//
//  CandidateButton.swift
//  DioGhvKeyboard
//
//  Created by silly on 10/03/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import UIKit

class CandidateButton: UIButton {
    
    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            if newValue {
                backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
            } else {
                backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            super.isHighlighted = newValue
        }
    }
    
}
