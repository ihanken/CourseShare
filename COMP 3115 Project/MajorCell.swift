//
//  MajorCell.swift
//  CourseShare
//
//  Created by Ian Hanken on 4/10/16.
//  Copyright © 2016 Ian Hanken. All rights reserved.
//

import Foundation
import UIKit

protocol MajorCellDelegate: class {
    func didChangeSwitchState(sender: MajorCell, isOn: Bool)
}

class MajorCell: UITableViewCell {
    
    @IBOutlet weak var majorName: UILabel!
    @IBOutlet weak var majorSwitch: UISwitch!
    
    weak var cellDelegate: MajorCellDelegate?
    
    @IBAction func handledSwitchChange(sender: UISwitch) {
        self.cellDelegate?.didChangeSwitchState(self, isOn: majorSwitch.on)
        print("Switch changed.")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}