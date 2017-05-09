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
        
        let safariBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "safari"), style: .plain, target: self, action: #selector(openSafari))
//        let outLinkBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openSafari))
        self.navigationItem.rightBarButtonItem = safariBarButton
        
        self.view.addSubview(courseWebView)
        courseWebView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        courseWebView.loadRequest(URLRequest(url: URL(string: "https://kahaani.github.io/gatian")!))
        
    }
    
    func openSafari() {
        UIApplication.shared.open(URL(string: "https://kahaani.github.io/gatian")!, options: [:]) { (result) in
            print(result)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
