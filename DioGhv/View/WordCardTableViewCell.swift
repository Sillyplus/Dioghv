//
//  WordCardTableViewCell.swift
//  DioGhvKeyboard
//
//  Created by silly on 08/04/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class WordCardTableViewCell: UITableViewCell {

    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var pronLabel: UILabel!
    
    var rowId: Int64?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
