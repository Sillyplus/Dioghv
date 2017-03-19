//
//  HomeViewController.swift
//  DioGhvKeyboard
//
//  Created by silly on 11/03/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Foundation
import SnapKit
import DboardKit

class HomeViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    @IBAction func setUpBtnClicked(_ sender: Any) {
        
        self.textView.text = ""
        
    }
    
    
    @IBAction func testBtnClicked(_ sender: Any) {
        
        
//        let fileURL = Bundle.main.url(forResource: "dieziu.dict", withExtension: ".yaml")
//        do {
//            self.textView.text = self.textView.text + "\(String(describing: fileURL)) \n"
//            let file = try String(contentsOf: fileURL!, encoding: .utf8)
//            let db = DBManager.singleton.connection
//            if db != nil {
//                DBManager.dropTable(named: "dieziu")
//                let dieziu = DBManager.createTable(named: "dieziu")
//                file.enumerateLines(invoking: { (line, ioB) in
//                    let comps = line.components(separatedBy: " ")
//                    do {
//                        try db!.run(dieziu!.insert(DBManager.nameEx <- comps[0], DBManager.pronunciationEx <- comps[1]))
//                    } catch {
//                        self.textView.text = self.textView.text + "insert failed \n"
//                    }
//                })
//                do {
//                    self.textView.text = self.textView.text + "\(try db!.scalar(dieziu!.count)) \n"
//                }
//            } else {
//                self.textView.text = self.textView.text + "db connected failed \n"
//            }
//        } catch {
//            self.textView.text = self.textView.text + "file read failed \n"
//        }

        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let db = DBManager.singleton.connection
        if db != nil {
            
        } else {
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
