//
//  HomeModel.swift
//  CourseShare
//
//  Created by Ian Hanken on 2/3/16.
//  Copyright © 2016 Ian Hanken. All rights reserved.
//

// ian

import Foundation

protocol HomeModelProtocol {
    func itemsDownloaded(items: NSArray)
}

class HomeModel: NSObject, HomeModelProtocol, NSURLConnectionDataDelegate {
    
    var downloadedData: NSMutableData = NSMutableData()
    
    var delegate: HomeModelProtocol? = nil
    
    func itemsDownloaded(items: NSArray) {
        // Must initialize function to adhere to protocol.
    }
    
    // Download all students from the database.
    func downloadItems() {
        downloadedData = NSMutableData()
        
        // Download the json file.
        let jsonFileUrl = NSURL(string: "http://localhost/~ihanken/service.php")
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(jsonFileUrl!, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print("error: \(error!.localizedDescription): \(error!.userInfo)")
            }
            else if data != nil {
                if let str = NSString(data: data!, encoding: NSUTF8StringEncoding) {
                    print("Received data:\n\(str)")
                    self.downloadedData.appendData(data!)
                    
                    // Create an array to store the locations
                    let students = NSMutableArray()
                    var jsonArray: NSArray = NSArray()
                    
                    // Parse the JSON that came in.
                    do {
                        jsonArray = try NSJSONSerialization.JSONObjectWithData(self.downloadedData, options: NSJSONReadingOptions.AllowFragments) as! NSArray
                    }
                    catch {
                        print("Error: \(error)")
                    }
                    
                    // Loop through Json objects, create question objects and add them to our questions array.
                    for i in 0..<jsonArray.count {
                        let jsonElement: NSDictionary = jsonArray[i] as! NSDictionary
                        
                        // Create a new location object and set its properties to JsonElement properties.
                        let newStudent = Student();
                        newStudent.name = jsonElement["Name"] as! NSString
                        newStudent.year = jsonElement["Year"] as! NSString
                        newStudent.majors = jsonElement["Majors"] as! NSString
                        newStudent.progression = jsonElement["Progression"] as! NSString
                        
                        // Add this student to the locations array.
                        print("Student Name: \(newStudent.name)")
                        students.addObject(newStudent)
                    }
                    
                    // Ready to notify delegate that data is ready and pass back items.
                    print("Students: \(students)")
                    
                    self.delegate?.itemsDownloaded(students)
                }
                else {
                    print("unable to convert data to text")
                }
            }
        })
        
        task.resume()
    }
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        downloadedData = NSMutableData()
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        downloadedData.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        
        print("Got to function.")
        // Create an array to store the locations
        let students = NSMutableArray()
        var jsonArray: NSArray = NSArray()
        
        // Parse the JSON that came in
        do {
            jsonArray = try NSJSONSerialization.JSONObjectWithData(downloadedData, options: NSJSONReadingOptions.AllowFragments) as! NSArray
        }
        catch {
            print("Error: \(error)")
        }
        
        // Loop through Json objects, create question objects and add them to our questions array
        for i in 0..<jsonArray.count {
            let jsonElement: NSDictionary = jsonArray[i] as! NSDictionary
            
            // Create a new location object and set its props to JsonElement properties
            let newStudent = Student();
            newStudent.name = jsonElement["Name"] as! NSString
            newStudent.year = jsonElement["Year"] as! NSString
            newStudent.majors = jsonElement["Majors"] as! NSString
            newStudent.progression = jsonElement["Progression"] as! NSString
            
            // Add this question to the locations array
            print(newStudent)
            students.addObject(newStudent)
        }
        
        // Ready to notify delegate that data is ready and pass back items
        delegate?.itemsDownloaded(students)
    }
}
