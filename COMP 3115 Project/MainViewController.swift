//
//  ViewController.swift
//  CourseShare
//
//  Created by Ian Hanken on 2/3/16.
//  Copyright © 2016 Ian Hanken. All rights reserved.
//

import UIKit

// String extension so I can filter a JSON encoded string into a normal string.

extension String {
    func removeCharsFromString(text: String) -> String {
        let okayChars : Set<Character> =
            Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-*=(),.:!_".characters)
        return String(text.characters.filter {okayChars.contains($0) })
    }
}

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HomeModelProtocol {
    
    var feedItems = NSMutableArray()
    var homeModel = HomeModel()
    var studentItems = [Student]()
    
    var cellIndex: Int?
    
    @IBAction func unwindToMainViewController (sender: UIStoryboardSegue) {
        // Pop view controllers off of the stack until the MainViewController is reached.
    }

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var newUserButton: UIButton!
    
    @IBAction func newUserButtonPressed(sender: AnyObject) {
        
    }
    
    override func viewDidAppear(animated: Bool) {
        // Set this view controller object as the delegate for the home model object
        homeModel.delegate = self
        
        // Call the download items method of the home model object
        print("Downloading items")
        homeModel.downloadItems()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set this view controller object as the delegate and data source for the table view
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func itemsDownloaded(items: NSMutableArray) {
        // This delegate method will get called when the items are finished downloading
        
        // Set the downloaded items to the array
        self.feedItems = items
        
        // Make this an array of students for sorting purposes.
        
        studentItems.removeAll()
        for i in 0..<feedItems.count {
            studentItems.append(feedItems[i] as! Student)
        }
        studentItems = sortStudents(studentItems)
        
        // Reload the table view
        dispatch_async(dispatch_get_main_queue()) {
            print("Reloading the table.")
            self.tableView.numberOfRowsInSection(items.count)
            self.tableView.reloadData()
        }
    }
    
    func getStudentName(student: Student) -> String {
        // Used to grab a student's name for comparison within a sort closure.
        let fullName = student.name as String
        let fullNameArr = fullName.characters.split{$0 == " "}.map(String.init)
        return fullNameArr.last!
    }
    
    func sortStudents(students: [Student]) -> [Student] {
        var sortedStudents: [Student]
        
        // Only attempt to sort if there is more than one student.
        if students.count > 1 {
            sortedStudents = students.sort({getStudentName($0) < getStudentName($1)})
        }
        else {
            sortedStudents = students
        }
        return sortedStudents
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentItems.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.cellIndex = indexPath.row
        self.performSegueWithIdentifier("classSelectionFromMain", sender: self)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        // If the user presses delete, delete the database row and delete the entry in the feeditems array.
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let url = NSURL(string: "http://cs3115.drajn.com/~ishanken/phpDelete.php")
            let urlRequest = NSMutableURLRequest(URL: url!)
            urlRequest.HTTPMethod = "POST"
            
            let noteDataString = NSString(format: "student_id=%@", "\(studentItems[indexPath.row].id)")
            print(noteDataString)
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
            studentItems.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Retrieve cell
        let cellIdentifier = "studentCell"
        let myCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! StudentCell
        
        myCell.tableView = tableView
        myCell.indexPath = indexPath
        let swipeGestureRecognizer = UISwipeGestureRecognizer()
        myCell.addGestureRecognizer(swipeGestureRecognizer)
        
        
        // Get the location to be shown
        let item = studentItems[indexPath.row]
        
        // Get references to labels of cell
        myCell.name.text = item.name as String
        myCell.subtitle.text = "\(item.year) in \(String().removeCharsFromString(item.majors.description))"
        
        return myCell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "classSelectionFromMain" {
            // When a user is selected, pass the class selection view controller all of the data needed.
            let csvc = segue.destinationViewController as! ClassSelectionViewController
            let item = studentItems[cellIndex!]
            csvc.toPass = ["\(item.name)", "\(item.year)", "\(item.majors)", "\(item.progression)"]
            csvc.majorsSelected = "\(item.majors)".componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: "\\[,]\"")).filter{ (($0 as String) != "" && ($0 as String) != " ")}.map{ ($0 as String) }
            csvc.student = item
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

