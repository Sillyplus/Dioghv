//
//  HomeViewController.swift
//  DioGhvKeyboard
//
//  Created by silly on 11/03/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import SnapKit
import SQLite

class HomeViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    @IBAction func setUpBtnClicked(_ sender: Any) {
        
        self.textView.text = ""
        
    }
    
    
    @IBAction func testBtnClicked(_ sender: Any) {
        
        do {
            let dbName = "Dboard.sqlite3"
            let containerPath = Utilities.appGroupContainerPath()!
            print(containerPath)
            let db = try Connection(containerPath + "/" + dbName)
            print(db)
        } catch {
            print("connect DB failed")
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let db = DBManager.default.connection
        if db != nil {
            
        } else {
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
