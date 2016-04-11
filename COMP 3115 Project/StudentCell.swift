//
//  StudentCell.swift
//  CourseShare
//
//  Created by Ian Hanken on 4/10/16.
//  Copyright © 2016 Ian Hanken. All rights reserved.
//

import Foundation
import UIKit

class StudentCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    weak var cellDelegate: ClassCellDelegate?
    weak var tableView: UITableView?
    weak var indexPath: NSIndexPath?
    weak var swipeGestureRecognizer: UISwipeGestureRecognizer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
