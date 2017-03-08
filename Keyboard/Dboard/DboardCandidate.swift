//
//  DboardCandidate.swift
//  DioGhvKeyboard
//
//  Created by silly on 08/03/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class DboardCandidateView: ExtraView {
    
    var layoutButton: UIButton = UIButton(frame: CGRect(x: 0, y: 5, width: 80, height: 20))
    var keyInputLabel: UILabel = UILabel()
    
    required init(globalColors: GlobalColors.Type?, darkMode: Bool, solidColorMode: Bool) {
        super.init(globalColors: globalColors, darkMode: darkMode, solidColorMode: solidColorMode)
        
        // Setup Candidate View
        self.addSubview(self.layoutButton)
        self.addSubview(self.keyInputLabel)
        self.layoutButton.addTarget(self, action: #selector(DboardCandidateView.reLayoutCandiateView), for: .touchUpInside)
        self.layoutButton.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)

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

extension DboardCandidateView {
    
    func reLayoutCandiateView() {
        print("Yooooooo")
        print(self.frame)
        print(self.superview?.frame ?? "superview not exit")
    }
    
}
