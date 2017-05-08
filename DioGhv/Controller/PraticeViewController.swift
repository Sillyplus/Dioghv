//
//  PraticeViewController.swift
//  DioGhvKeyboard
//
//  Created by silly on 28/03/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import DboardKit

class PraticeViewController: UIViewController {

    let hermes = Hermes.default
    let tableBackView = UIView()
    let table = UITableView()
    let inputFieldBackView = UIView()
    let inputField = UITextField()
    var inputWord: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationItem.title = "练习"
        
        let topMargin = UIApplication.shared.statusBarFrame.height + self.navigationController!.navigationBar.frame.height
        self.view.addSubview(table)
        table.snp.makeConstraints { (make) in
            make.height.equalTo(topMargin + 60)
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }

        table.delegate = self
        table.dataSource = self
        table.isScrollEnabled = false
        table.separatorInset = UIEdgeInsets.zero
        table.tableFooterView = UIView(frame: CGRect.zero)
        table.register(UINib(nibName: "WordCardTableViewCell", bundle: nil) , forCellReuseIdentifier: "WordCardCell")
        table.reloadData()
        
        self.view.addSubview(inputFieldBackView)
        inputFieldBackView.snp.makeConstraints { (make) in
            make.top.equalTo(table.snp.bottom).priority(988)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(40)
        }
        inputFieldBackView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        inputFieldBackView.addSubview(inputField)
        inputField.borderStyle = .roundedRect
        inputField.addTarget(self, action: #selector(inputFieldDidChange(_:)), for: .editingChanged)
        inputField.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsetsMake(2, 4, 2, 4))
        }
        inputField.backgroundColor = UIColor(red: 0.6, green: 0.9, blue: 0.9, alpha: 1)
        
    }
    
    func inputFieldDidChange(_ textField: UITextField) {
        if let inputStr = textField.text {
            if inputStr == inputWord {
                table.reloadData()
                textField.text = ""
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension PraticeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath) as! WordCardTableViewCell
//        tableView.deselectRow(at: indexPath, animated: false)
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordCardCell", for: indexPath) as! WordCardTableViewCell

        if let randRow = hermes.randomRow() {
            cell.wordLabel.text = randRow[Zeus.nameEx]
            cell.pronLabel.text = randRow[Zeus.pronunciationEx]
            cell.rowId = randRow[Zeus.idEx]
            self.inputWord = cell.wordLabel.text!
        }
        
        return cell
    }
    
}

