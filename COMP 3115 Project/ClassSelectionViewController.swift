//
//  ClassSelectionViewController.swift
//  CourseShare
//
//  Created by Ian Hanken on 2/24/16.
//  Copyright © 2016 Ian Hanken. All rights reserved.
//

import Foundation
import UIKit

class ClassSelectionViewController: UITableViewController, ClassCellDelegate,HomeModelProtocol {
    
    @IBOutlet var classTable: UITableView!
    
    @IBOutlet weak var createUserButton: UIButton!
    
    var feedItems = NSArray()
    var homeModel = HomeModel()
    
    @IBAction func createUserButtonPressed(sender: AnyObject) {
        let url = NSURL(string: "http://localhost/~ihanken/phpWrite.php")
        let urlRequest = NSMutableURLRequest(URL: url!)
        urlRequest.HTTPMethod = "POST"
        
        let noteDataString = NSString(format: "name=%@&year=%@&majors=%@&progression=%@", toPass[0], toPass[1], toPass[2], classesSelected.description)
        urlRequest.HTTPBody = noteDataString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let defaultSession = NSURLSession.sharedSession()
        
        let dataTask = defaultSession.dataTaskWithRequest(urlRequest, completionHandler: {(data, response, error) in
            
            var json: NSDictionary
            
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                let status = json["status"] as! NSString
                
                if status == "1" {
                    // Reload the table view
                    self.homeModel.downloadItems()
                }
                else {
                    print("Error when trying to write.")
                }
            }
            catch {
                print("This is the caught error")
                print("Error: \(error)")
            }
            
        });
        
        dataTask.resume()
    }
    
    var toPass = [String]()
    
    var classes = ComputerScience().majorFlow
    var classArray = ComputerScience().classArray
    
    var classesSelected = [Class]()
    
    @IBAction func handledSwitchChange(sender: UISwitch) {
        //didChangeSwitchState(sender, isOn: sender.on)
        classTable.reloadData()
        classesSelected.removeAll()
    }
    
    func didChangeSwitchState(sender: ClassCell, isOn: Bool) {
        let indexPath = self.tableView.indexPathForCell(sender)
        let index = indexPath!.row
        classArray[index].selected = isOn
        classTable.reloadData()
        classesSelected.removeAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.classTable.contentInset = UIEdgeInsetsMake(20.0, 0.0, 0.0, 0.0);
        
        print(toPass)
    }
    
    func itemsDownloaded(items: NSArray) {
        // This delegate method will get called when the items are finished downloading
        
        // Set the downloaded items to the array
        self.feedItems = items
        
        // Reload the table view
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView.reloadData()
        }
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
        cell.classSwitch.setOn(classArray[indexPath.row].selected, animated: false)
        
        if classArray[indexPath.row].selected == true {
            classesSelected.append(classArray[indexPath.row])
        }
        
        cell.cellDelegate = self

        return cell
    }
}