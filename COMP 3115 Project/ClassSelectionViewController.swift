//
//  ClassSelectionViewController.swift
//  CourseShare
//
//  Created by Ian Hanken on 2/24/16.
//  Copyright © 2016 Ian Hanken. All rights reserved.
//

import Foundation
import UIKit

class ClassSelectionViewController: UITableViewController {
    
    @IBOutlet var classTable: UITableView!
    
    var classes = ComputerScience().majorFlow
    var classArray = ComputerScience().classArray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.classTable.contentInset = UIEdgeInsetsMake(20.0, 0.0, 0.0, 0.0);
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.classTable.dequeueReusableCellWithIdentifier("classCell") as! ClassCell
        
        cell.classSwitch.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        
        cell.className.text = classArray[indexPath.row].className
        cell.classID.text = "\(classArray[indexPath.row].classDept) \(classArray[indexPath.row].classID)"

        return cell
    }
}