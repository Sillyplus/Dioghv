//
//  DboardCandidate.swift
//  DioGhvKeyboard
//
//  Created by silly on 08/03/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class DboardCandidateView: ExtraView {
    
    required init(globalColors: GlobalColors.Type?, darkMode: Bool, solidColorMode: Bool) {
        super.init(globalColors: globalColors, darkMode: darkMode, solidColorMode: solidColorMode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}
