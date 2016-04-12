//
//  ClassSelectionViewController.swift
//  CourseShare
//
//  Created by Ian Hanken on 2/24/16.
//  Copyright © 2016 Ian Hanken. All rights reserved.
//

import Foundation
import UIKit

// An extension of Arrays that allows me to filter out duplicate classes.
// This does require the equatable protocol in the class.
extension Array where Element : Equatable {
    var unique: [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            if !uniqueValues.contains(item) {
                uniqueValues += [item]
            }
        }
        return uniqueValues
    }
}

class ClassSelectionViewController: UIViewController, ClassCellDelegate, HomeModelProtocol {
    
    @IBOutlet var classTable: UITableView!
    
    @IBOutlet weak var createUserButton: UIButton!
    
    var feedItems = NSMutableArray()
    var homeModel = HomeModel()
    
    var toPass = [String]()
    var student: Student?
    
    @IBAction func unwindToClassSelectionViewController (sender: UIStoryboardSegue){
        // Pop all view controllers off of the stack until this view controller is reached.
    }
    
    @IBAction func createUserButtonPressed(sender: AnyObject) {
        if student == nil {
            let url = NSURL(string: "http://cs3115.drajn.com/~ishanken/phpWrite.php")
            let urlRequest = NSMutableURLRequest(URL: url!)
            urlRequest.HTTPMethod = "POST"
            
            let noteDataString = NSString(format: "name=%@&year=%@&majors=%@&progression=%@", toPass[0], toPass[1], majorsSelected.description, classesSelected.description)
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
        else {
            let url = NSURL(string: "http://cs3115.drajn.com/~ishanken/phpUpdate.php")
            let urlRequest = NSMutableURLRequest(URL: url!)
            urlRequest.HTTPMethod = "POST"
            
            print(student!.id)
            
            let noteDataString = NSString(format: "student_id=%@&progression=%@", "\(student!.id)", classesSelected.description)
            print(noteDataString)
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
    }
    
    var classes = Dictionary<String, Class>()
    var classArray = [Class]()
    
    var classesSelected = [Class]()
    var majorsSelected = [String]()
    
    func didChangeSwitchState(sender: ClassCell, isOn: Bool) {
        // When a switch is flipped, change the cell and the array of chosen classes.
        let indexPath = self.classTable.indexPathForCell(sender)
        let index = indexPath!.row
        classArray[index].selected = isOn
        classesSelected.removeAll()
        for currentClass in classArray {
            if currentClass.selected == true {
                classesSelected.append(currentClass)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If a user is being updated, change he "Create User" button's text.
        if self.student != nil {
            createUserButton?.setTitle("Update User", forState: .Normal)
        }
    }
    
    func sortClasses(classes: [Class]) -> [Class] {
        var sortedClasses: [Class]
        
        // Sort classes alphabetically.
        if classes.count > 1 {
            sortedClasses = classes.sort({getClassID($0) < getClassID($1)})
        }
        else {
            sortedClasses = classes
        }
        return sortedClasses
    }
    
    func getClassID(currentClass: Class) -> String {
        // Return a classes full ID. Used for sorting an array by ClassID within a closure.
        return currentClass.classDept + "\(currentClass.classID)"
    }
    
    func itemsDownloaded(items: NSMutableArray) {
        // This delegate method will get called when the items are finished downloading
        
        // Reload the table view
        dispatch_async(dispatch_get_main_queue()) {
            // Set the downloaded items to the array
            self.feedItems = items
            self.classTable.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "credentialsSegue" {
            // When moving to the credentials screen, pass all relevant database information.
            let cvc = segue.destinationViewController as! CredentialsViewController
            cvc.student = student
            cvc.toPass = toPass
            cvc.majorsSelected = majorsSelected
            cvc.classesSelected = classesSelected
        }
    }
}

extension ClassSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        for major in majorsSelected {
            if major == "Computer Science" { classArray += ComputerScience().classArray }
            if major == "Computer Engineering" { classArray += ComputerEngineering().classArray }
            if major == "Electrical Engineering" { classArray += ElectricalEngineering().classArray }
        }
        
        classArray = classArray.unique
        classArray = sortClasses(classArray)
        
        return classArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
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
