//
//  ViewController.swift
//  CourseShare
//
//  Created by Ian Hanken on 2/3/16.
//  Copyright © 2016 Ian Hanken. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HomeModelProtocol {
    
    var feedItems = NSArray()
    var homeModel = HomeModel()
    
    @IBAction func unwindToMainViewController (sender: UIStoryboardSegue){
        
    }

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var newUserButton: UIButton!
    
    @IBAction func newUserButtonPressed(sender: AnyObject) {
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

