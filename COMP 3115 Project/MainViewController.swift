//
//  ViewController.swift
//  CourseShare
//
//  Created by Ian Hanken on 2/3/16.
//  Copyright © 2016 Ian Hanken. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HomeModelProtocol {
    
    var feedItems = NSMutableArray()
    var homeModel = HomeModel()
    
    var cellIndex: Int?
    
    @IBAction func unwindToMainViewController (sender: UIStoryboardSegue){
        
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
        
        // Reload the table view
        dispatch_async(dispatch_get_main_queue()) {
            print("Reloading the table.")
            self.tableView.numberOfRowsInSection(items.count)
            self.tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItems.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Row \(indexPath.row) selected")
        self.cellIndex = indexPath.row
        self.performSegueWithIdentifier("classSelectionFromMain", sender: self)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let url = NSURL(string: "http://cs3115.drajn.com/~ishanken/phpDelete.php")
        let urlRequest = NSMutableURLRequest(URL: url!)
        urlRequest.HTTPMethod = "POST"
        
        let noteDataString = NSString(format: "student_id=%@", "\((feedItems[indexPath.row] as! Student).id)")
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
        
        feedItems.removeObjectAtIndex(indexPath.row)
        if editingStyle == UITableViewCellEditingStyle.Delete {
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
        let item: Student = feedItems[indexPath.row] as! Student
        
        // Get references to labels of cell
        myCell.name.text = item.name as String
        myCell.subtitle.text = "\(item.year) in \(item.majors)"
        
        return myCell
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if gestureRecognizer.view?.isKindOfClass(UITableViewCell) == true && ((gestureRecognizer as! UISwipeGestureRecognizer).direction == UISwipeGestureRecognizerDirection.Left || (gestureRecognizer as! UISwipeGestureRecognizer).direction == UISwipeGestureRecognizerDirection.Right) {
            return true
        }
        return false
    }
    
    func deleteCell(gestureRecognizer: UIGestureRecognizer) {
        let swipeGestureRecognizer = gestureRecognizer as! UISwipeGestureRecognizer
        let cell = swipeGestureRecognizer.view as! StudentCell
        let tableView = cell.tableView
        let indexPath = cell.indexPath
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "classSelectionFromMain" {
            let csvc = segue.destinationViewController as! ClassSelectionViewController
            print(cellIndex)
            let item = feedItems[cellIndex!] as! Student
            csvc.toPass = ["\(item.name)", "\(item.year)", "\(item.majors)", "\(item.progression)"]
            csvc.student = item
            //csvc.createUserButton.setTitle("Update User", forState: .Normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

