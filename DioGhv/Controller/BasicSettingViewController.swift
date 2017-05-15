//
//  BasicSettingViewController.swift
//  DioGhvKeyboard
//
//  Created by silly on 21/03/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import DboardKit
import PKHUD

class BasicSettingViewController: UIViewController {
    
    let zeus = Zeus.singleton
    
    var settingTable: UITableView = UITableView()
    var traditionalSwitch: UISwitch = UISwitch()
    var chineseTypeCell: UITableViewCell = UITableViewCell()
    
    var suantauAreaCell: UITableViewCell = UITableViewCell()
    var dieziuAreaCell: UITableViewCell = UITableViewCell()
    var dioionAreaCell: UITableViewCell = UITableViewCell()
    var gekionAreaCell: UITableViewCell = UITableViewCell()
    var riaupengAreaCell: UITableViewCell = UITableViewCell()
    var tenghaiAreaCell: UITableViewCell = UITableViewCell()
    
    var buildCell: UITableViewCell = UITableViewCell()
    
    var resetCell: UITableViewCell = UITableViewCell()
    
    var selectedIndex: Int {
        get {
            return zeus.primaryArea!.rawValue
        }
        set {
            let newIndex = newValue
            zeus.primaryArea = DboardPrimaryArea(rawValue: newIndex)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationItem.title = "基础设置"

        settingTable = UITableView(frame: self.view.bounds, style: .grouped)
        settingTable.delegate = self
        settingTable.dataSource = self
        settingTable.backgroundColor = UIColor(red: 0.6, green: 0.9, blue: 0.9, alpha: 1)
        self.view.addSubview(settingTable)
        
        chineseTypeCell.textLabel?.text = "啟用繁體"
        chineseTypeCell.accessoryView = traditionalSwitch
        traditionalSwitch.addTarget(self, action: #selector(self.switchTrigger(sender:)), for: .valueChanged)
        if zeus.chineseType!.rawValue == 0 {
            traditionalSwitch.isOn = false
        } else {
            traditionalSwitch.isOn = true
        }
        
        suantauAreaCell.textLabel?.text = "汕头音"
        dieziuAreaCell.textLabel?.text = "潮州音"
        dioionAreaCell.textLabel?.text = "潮阳音"
        gekionAreaCell.textLabel?.text = "揭阳音"
        riaupengAreaCell.textLabel?.text = "饶平音"
        tenghaiAreaCell.textLabel?.text = "澄海音"

        buildCell.textLabel?.text = "创建词库"
        buildCell.textLabel?.textAlignment = .center
        
        resetCell.textLabel?.text = "重置数据"
        resetCell.textLabel?.textAlignment = .center
        resetCell.textLabel?.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        
        settingTable.reloadData()

    }
    
    func switchTrigger(sender: UISwitch) {
        if sender.isOn {
            self.zeus.chineseType = DboardChineseType(rawValue: 1)
        } else {
            self.zeus.chineseType = DboardChineseType(rawValue: 0)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension BasicSettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 6
        case 2:
            return 1
        case 3:
            return 1
        default:
            fatalError("Unknow Sections")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        // Hack ?
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return self.chineseTypeCell
            default:
                fatalError("Unknow Cell At Section 0")
            }
        case 1:
            switch indexPath.row {
            case 0:
                if selectedIndex == 0 {
                    self.suantauAreaCell.accessoryType = .checkmark
                } else {
                    self.suantauAreaCell.accessoryType = .none
                }
                return self.suantauAreaCell
            case 1:
                if selectedIndex == 1 {
                    self.dieziuAreaCell.accessoryType = .checkmark
                } else {
                    self.dieziuAreaCell.accessoryType = .none
                }
                return self.dieziuAreaCell
            case 2:
                if selectedIndex == 2 {
                    self.dioionAreaCell.accessoryType = .checkmark
                } else {
                    self.dioionAreaCell.accessoryType = .none
                }
                return self.dioionAreaCell
            case 3:
                if selectedIndex == 3 {
                    self.gekionAreaCell.accessoryType = .checkmark
                } else {
                    self.gekionAreaCell.accessoryType = .none
                }
                return self.gekionAreaCell
            case 4:
                if selectedIndex == 4 {
                    self.riaupengAreaCell.accessoryType = .checkmark
                } else {
                    self.riaupengAreaCell.accessoryType = .none
                }
                return self.riaupengAreaCell
            case 5:
                if selectedIndex == 5 {
                    self.tenghaiAreaCell.accessoryType = .checkmark
                } else {
                    self.tenghaiAreaCell.accessoryType = .none
                }
                return self.tenghaiAreaCell
            default:
                fatalError("Unknow Cell At Section 1")
            }
        case 2:
            switch indexPath.row {
            case 0:
                return self.buildCell
            default:
                fatalError("Unknow Cell At Section 2")
            }
        case 3:
            switch indexPath.row {
            case 0:
                return self.resetCell
            default:
                fatalError("Unknow Cell At Section 3")
            }
        default:
            fatalError("Unknow Section")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                print("select \(indexPath)")
            default:
                fatalError("Unknow Cell At Section 0")
            }
        case 1:
            self.selectedIndex = indexPath.row
        case 2:
            switch indexPath.row {
            case 0:
                self.showBuildAlert()
            default:
                fatalError("Unknow Cell At Section 2")
            }
        case 3:
            switch indexPath.row {
            case 0:
                self.showResetAlert()
            default:
                fatalError("Unknow Cell At Section 3")
            }
        default:
            fatalError("Unknow Section")
        }
        
        self.settingTable.reloadData()
    }
    
    func showResetAlert() {
        let alert = UIAlertController(title: "重置数据", message: "此操作不可逆，是否继续", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (action) in
            // Do nothing
        }))
        alert.addAction(UIAlertAction(title: "确认", style: .default, handler: { (action) in
            HUD.show(.progress)
            self.delay(1, closure: { 
                let tableName = Zeus.stringNameBy(PrimaryArea: Zeus.singleton.primaryArea!, AndType: Zeus.singleton.chineseType!)
                Zeus.dropTable(named: tableName)
                print("确认重置")
                HUD.flash(.success)
            })
        }))
        self.present(alert, animated: true) { 
            // Do Something after alert presented
        }
    }
    
    func showBuildAlert() {
        let alert = UIAlertController(title: "生成词库", message: "根据当前语言创建词库，此操作可能需消耗较多时间，请耐心等待", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (action) in
            // Do nothing
        }))
        alert.addAction(UIAlertAction(title: "确认", style: .default, handler: { (action) in
            HUD.show(.progress)
            self.delay(1, closure: {
                // Update DB here 
                let area = Zeus.singleton.primaryArea!
                let type = Zeus.singleton.chineseType!
                let buildState = Zeus.buildSource(WithPrimaryArea: area, AndType: type)
                switch buildState {
                case .success:
                    HUD.flash(.success, delay: 1)
                    print("确认生成")
                case .failed:
                    HUD.flash(.error, delay: 1)
                    print("生成失败")
                case .exist:
                    HUD.flash(.labeledSuccess(title: "数据已存在", subtitle: nil))
                }
            })
        }))
        self.present(alert, animated: true) {
            // Do nothing
        }
    }
    
    func delay(_ delay: Double, closure:@escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
}

