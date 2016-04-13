//
//  CredentialsViewController.swift
//  CourseShare
//
//  Created by Ian Hanken on 4/11/16.
//  Copyright © 2016 Ian Hanken. All rights reserved.
//

import Foundation
import UIKit

class CredentialsViewController: UIViewController, UITextFieldDelegate, HomeModelProtocol {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    
    var feedItems = NSMutableArray()
    var homeModel = HomeModel()
    
    var studentID: Int?
    var username: String = "NULL"
    var password: String = "NULL"
    
    var student: Student?
    var toPass = [String]()
    
    var classesSelected = [Class]()
    var majorsSelected = [String]()
    
    @IBAction func updateButtonPressed(sender: UIButton) {
        if student == nil {
            let url = NSURL(string: "http://cs3115.drajn.com/~ishanken/phpCredentials.php")
            let urlRequest = NSMutableURLRequest(URL: url!)
            urlRequest.HTTPMethod = "POST"
            
            let noteDataString = NSString(format: "name=%@&year=%@&majors=%@&progression=%@&username=%@&password=%@", toPass[0], toPass[1], majorsSelected.description, classesSelected.description, username, password)
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
            let url = NSURL(string: "http://cs3115.drajn.com/~ishanken/phpCredentialsUpdate.php")
            let urlRequest = NSMutableURLRequest(URL: url!)
            urlRequest.HTTPMethod = "POST"
            
            let noteDataString = NSString(format: "student_id=%@&progression=%@&username=%@&password=%@", "\(student!.id)", classesSelected.description, username as String, password as String)
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
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 25
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        let nextTag = textField.tag + 1
        // Try to find next responder
        let nextResponder = textField.superview?.viewWithTag(nextTag) as UIResponder!
        
        if (nextResponder != nil) {
            // Found next responder, so set it.
            nextResponder?.becomeFirstResponder()
        }
        else {
            // Not found, so remove keyboard
            textField.resignFirstResponder()
        }
        
        // Update the username or password based on what the user enters into the fields.
        if textField.tag == 1 { username = textField.text! }
        else { password = textField.text! }
        
        return true
    }
    
    func itemsDownloaded(items: NSMutableArray) {
        dispatch_async(dispatch_get_main_queue()) {
            // Set the downloaded items to the array
            self.feedItems = items
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
