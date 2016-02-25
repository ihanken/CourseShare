//
//  ClassCell.swift
//  CourseShare
//
//  Created by Ian Hanken on 2/24/16.
//  Copyright © 2016 Ian Hanken. All rights reserved.
//

import Foundation
import UIKit

class ClassCell: UITableViewCell {
    
    @IBOutlet weak var className: UILabel!
    @IBOutlet weak var classID: UILabel!
    @IBOutlet weak var classSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}