//
//  ViewController.swift
//  CourseShare
//
//  Created by Ian Hanken on 2/3/16.
//  Copyright © 2016 Ian Hanken. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HomeModelProtocol {
    
    var feedItems = NSArray()
    var homeModel = HomeModel()

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var newUserButton: UIButton!
    
    @IBAction func newUserButtonPressed(sender: AnyObject) {
        
        let url = NSURL(string: "http://localhost/~ihanken/phpWrite.php")
        let urlRequest = NSMutableURLRequest(URL: url!)
        urlRequest.HTTPMethod = "POST"
        
        let noteDataString = NSString(format: "name=%@&year=%@&majors=%@&progression=%@", "Test", "Freshman", "Computer Engineering", "Test")
        urlRequest.HTTPBody = noteDataString.dataUsingEncoding(NSUTF8StringEncoding)

        let defaultSession = NSURLSession.sharedSession()
        
        let dataTask = defaultSession.dataTaskWithRequest(urlRequest, completionHandler: {(data, response, error) in
            
            let urlContent = NSString(data: data!, encoding: NSUTF8StringEncoding) as NSString!
            print("Data: \(urlContent)");
            
            var json: NSDictionary
            
            do {
                print("Trying serialization.")
                json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                print("Past serialization.")
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set this view controller object as the delegate and data source for the table view
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Set this view controller object as the delegate for the home model object
        homeModel.delegate = self
        
        // Call the download items method of the home model object
        homeModel.downloadItems()
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(feedItems.count)
        return feedItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Retrieve cell
        let cellIdentifier = "TestCell"
        let myCell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)!
        
        // Get the location to be shown
        let item: Student = feedItems[indexPath.row] as! Student
        
        // Get references to labels of cell
        myCell.textLabel!.text = item.name as String
        myCell.detailTextLabel!.text = "\(item.year) in \(item.majors)"
        
        return myCell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

