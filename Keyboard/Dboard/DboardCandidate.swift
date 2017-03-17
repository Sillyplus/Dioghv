//
//  DboardCandidate.swift
//  DioGhvKeyboard
//
//  Created by silly on 08/03/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import SnapKit


class DboardCandidateView: ExtraView {
    
    var scrollView: UIScrollView = UIScrollView()
    var inputKeyView: UIView = UIView()
    var inputKeyLabel: UILabel = UILabel()
    var topSeparator: UIView = UIView()
    var middleSeparator: UIView = UIView()
    
    required init(globalColors: GlobalColors.Type?, darkMode: Bool, solidColorMode: Bool) {
        super.init(globalColors: globalColors, darkMode: darkMode, solidColorMode: solidColorMode)
        
        // Setup Candidate View
        
        self.addSubview(scrollView)
        self.addSubview(middleSeparator)
        self.addSubview(inputKeyView)
        self.inputKeyView.addSubview(inputKeyLabel)
        self.addSubview(topSeparator)
        
        topSeparator.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview().priority(1000)
            make.height.equalTo(0.5).priority(999)
        }
        
        inputKeyView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(topSeparator.snp.bottom).priority(998)
            make.height.equalTo(15).priority(997)
        }
        
        inputKeyLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsetsMake(0, 5, 0, 5)).priority(993)
        }
        
        middleSeparator.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(inputKeyView.snp.bottom).priority(996)
            make.height.equalTo(0.5).priority(995)
        }
        
        scrollView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(middleSeparator.snp.bottom).priority(994)
        }
        
        scrollView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        inputKeyView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        inputKeyLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        topSeparator.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        middleSeparator.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        self.inputKeyLabel.font = UIFont.systemFont(ofSize: 12.0)
        self.inputKeyLabel.text = ""

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var contentSize: CGSize = self.scrollView.contentSize
        let candidateStringHeight: CGFloat = self.scrollView.frame.height
        var candidateStringCurrentPosition: CGFloat = 0.0
        
        for view in self.scrollView.subviews {
            if view is UIButton {
                let r = view.frame
                view.frame = CGRect(x: candidateStringCurrentPosition, y: 0, width: r.size.width, height: candidateStringHeight)
                candidateStringCurrentPosition += view.frame.size.width
                
                // Update ScrollView Content Size If Necessary
                if candidateStringCurrentPosition >= contentSize.width {
                    contentSize = CGSize(width: candidateStringCurrentPosition, height: contentSize.height)
                    self.scrollView.contentSize = contentSize
                }
            }
        }
        
        if candidateStringCurrentPosition == 0.0 {
            contentSize = CGSize(width: candidateStringCurrentPosition, height: contentSize.height)
            self.scrollView.contentSize = contentSize
        }
        
    }
    
}

extension DboardCandidateView {
    
    
    func updateBanner(candidateList: [String], inputKeyString:String) {
        
        self.inputKeyLabel.text = inputKeyString
        self.scrollView.subviews.forEach { $0.removeFromSuperview() }
        for s in candidateList {
            self.addString(s: s)
        }
        self.setNeedsLayout()
        
    }
    
    func addString(s:String) {
        
        let btn:UIButton = CandidateButton(type: .custom)
        btn.setTitle(s, for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(DboardCandidateView.tapBtn(btn:)), for: .touchUpInside)
        
        let size = CGSize()
        let fontAttributes = [NSFontAttributeName: btn.titleLabel!.font]
        let r = s.boundingRect(with: size, options: .usesFontLeading, attributes: fontAttributes as Any as? [String : Any], context: nil)
        btn.frame = CGRect(x: r.origin.x, y: r.origin.y, width: r.size.width + 20, height: r.size.height)
        
        self.scrollView.addSubview(btn)
        
    }
    
    func clearBanner() {
        
        self.scrollView.subviews.forEach { $0.removeFromSuperview() }
        self.inputKeyLabel.text = ""
        
    }
    
    func tapBtn(btn: UIButton) {
        
        let candidateString = btn.titleLabel!.text!
        let candidateSelectedNotification = Notification.Name.init(rawValue: "CandidateSelectedNotification")
        NotificationCenter.default.post(name: candidateSelectedNotification, object: nil, userInfo: ["DboardCandidate": candidateString])
        
    }

}
