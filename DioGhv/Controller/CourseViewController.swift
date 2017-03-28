//
//  CourseViewController.swift
//  DioGhvKeyboard
//
//  Created by silly on 28/03/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class CourseViewController: UIViewController {

    let courseWebView = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationItem.title = "教程"
        
        self.view.addSubview(courseWebView)
        courseWebView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        courseWebView.loadRequest(URLRequest(url: URL(string: "https://kahaani.github.io/gatian")!))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
