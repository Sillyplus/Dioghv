//
//  CandidateButton.swift
//  DioGhvKeyboard
//
//  Created by silly on 10/03/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import UIKit
import DboardKit

class CandidateButton: UIButton {
    
    var candy: Candy
    
    init(frame: CGRect, candy: Candy) {
        self.candy = candy
        super.init(frame: frame)
    }
    
    override init(frame: CGRect) {
        self.candy = Candy()
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
