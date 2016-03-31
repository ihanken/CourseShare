//
//  ClassSelectionViewController.swift
//  CourseShare
//
//  Created by Ian Hanken on 2/24/16.
//  Copyright © 2016 Ian Hanken. All rights reserved.
//

import Foundation
import UIKit

class ClassSelectionViewController: UITableViewController, ClassCellDelegate, HomeModelProtocol {
    
    @IBOutlet var classTable: UITableView!
    
    @IBOutlet weak var createUserButton: UIButton!
    
    var feedItems = NSArray()
    var homeModel = HomeModel()
    
    var toPass = [String]()
    var student: Student?
    
    @IBAction func createUserButtonPressed(sender: AnyObject) {
        if student == nil {
            let url = NSURL(string: "http://localhost/~ihanken/phpWrite.php")
            let urlRequest = NSMutableURLRequest(URL: url!)
            urlRequest.HTTPMethod = "POST"
            
            let noteDataString = NSString(format: "name=%@&year=%@&majors=%@&progression=%@", toPass[0], toPass[1], toPass[2], classesSelected.description)
            urlRequest.HTTPBody = noteDataString.dataUsingEncoding(NSUTF8StringEncoding)
            
            let defaultSession = NSURLSession.sharedSession()
            
            let dataTask = defaultSession.dataTaskWithRequest(urlRequest, completionHandler: {(data, response, error) in
                
                print(data!)
                
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
        else {
            let url = NSURL(string: "http://localhost/~ihanken/phpUpdate.php")
            let urlRequest = NSMutableURLRequest(URL: url!)
            urlRequest.HTTPMethod = "POST"
            
            print(student!.id)
            
            let noteDataString = NSString(format: "student_id=%@&progression=%@", "\(student!.id)", classesSelected.description)
            urlRequest.HTTPBody = noteDataString.dataUsingEncoding(NSUTF8StringEncoding)
            
            let defaultSession = NSURLSession.sharedSession()
            
            let dataTask = defaultSession.dataTaskWithRequest(urlRequest, completionHandler: {(data, response, error) in
                
                print(data!)
                
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
    }
    
    var classes = Dictionary<String, Class>()
    var classArray = [Class]()
    
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
        
        if toPass[2] == "Computer Science" {
            classes = ComputerScience().majorFlow
            classArray = ComputerScience().classArray
        }
        else if toPass[2] == "Computer Engineering" {
            classes = ComputerEngineering().majorFlow
            classArray = ComputerEngineering().classArray
        }
        else {
            classes = ElectricalEngineering().majorFlow
            classArray = ElectricalEngineering().classArray
        }
        
        self.classTable.contentInset = UIEdgeInsetsMake(20.0, 0.0, 0.0, 0.0);
        
        //toPass.removeAtIndex(3)
    }
    
    func itemsDownloaded(items: NSArray) {
        // This delegate method will get called when the items are finished downloading
        
        // Reload the table view
        dispatch_async(dispatch_get_main_queue()) {
            // Set the downloaded items to the array
            self.feedItems = items
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
        
        // Rotate the switch 180 degrees.
        cell.classSwitch.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        
        cell.className.text = classArray[indexPath.row].className
        cell.classID.text = "\(classArray[indexPath.row].classDept) \(classArray[indexPath.row].classID)"
        if toPass.count >= 4 {
            if toPass[3].rangeOfString(cell.classID.text!) != nil {
                cell.classSwitch.setOn(true, animated: false)
                classArray[indexPath.row].selected = true
                toPass[3] = toPass[3].stringByReplacingOccurrencesOfString(cell.classID.text!, withString: "")
            }
        }
        cell.classSwitch.setOn(classArray[indexPath.row].selected, animated: false)
        
        if cell.classSwitch.on == true {
            classesSelected.append(classArray[indexPath.row])
        }
        
        cell.cellDelegate = self

        return cell
    }
}