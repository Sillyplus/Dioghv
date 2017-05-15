//
//  AdvanceSettingViewController.swift
//  DioGhvKeyboard
//
//  Created by silly on 28/03/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import DboardKit
import SQLite

class AdvanceSettingViewController: UIViewController {

    let searchBar = UISearchBar()
    let table = UITableView()
    let hermes = Hermes.default

    var dataArray: [Row] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationItem.title = "高级设置"
        
        // Implement Add Item NavigationBar Button
        
        let topMargin = UIApplication.shared.statusBarFrame.height + self.navigationController!.navigationBar.frame.height
        self.view.addSubview(searchBar)
        searchBar.barStyle = .default
        searchBar.placeholder = "搜索"
        searchBar.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.top.equalTo(topMargin)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        searchBar.delegate = self
        
        self.view.addSubview(table)
        table.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom).priority(998)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().priority(997)
        }
        table.delegate = self
        table.dataSource = self
        table.separatorInset = UIEdgeInsets.zero
        table.tableFooterView = UIView(frame: CGRect.zero)
        table.register(UINib(nibName: "WordCardTableViewCell", bundle: nil) , forCellReuseIdentifier: "WordCardCell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension AdvanceSettingViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        let searchWord = searchBar.text!
        self.dataArray = hermes.search(with: searchWord)
        self.table.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.dataArray = []
            self.table.reloadData()
        }
    }
    
}

extension AdvanceSettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordCardCell", for: indexPath) as! WordCardTableViewCell
        if indexPath.section == 0 && indexPath.row < self.dataArray.count {
            let row = dataArray[indexPath.row]
            cell.wordLabel.text = row[Zeus.nameEx]
            cell.setPronLabelText(with: row[Zeus.pronunciationEx])
            cell.rowId = row[Zeus.idEx]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! WordCardTableViewCell
        // TODO: show editor view
        print(cell.rowId!)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
