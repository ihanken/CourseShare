//
//  ClassCell.swift
//  CourseShare
//
//  Created by Ian Hanken on 2/24/16.
//  Copyright © 2016 Ian Hanken. All rights reserved.
//

import Foundation
import UIKit

protocol ClassCellDelegate: class {
    func didChangeSwitchState(sender: ClassCell, isOn: Bool)
}

class ClassCell: UITableViewCell {
    
    @IBOutlet weak var className: UILabel!
    @IBOutlet weak var classID: UILabel!
    @IBOutlet weak var classSwitch: UISwitch!
    
    weak var cellDelegate: ClassCellDelegate?
    
    @IBAction func handledSwitchChange(sender: UISwitch) {
        self.cellDelegate?.didChangeSwitchState(self, isOn: classSwitch.on)
        print("Switch changed.")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}