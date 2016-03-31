//
//  Student.swift
//  CourseShare
//
//  Created by Ian Hanken on 2/3/16.
//  Copyright © 2016 Ian Hanken. All rights reserved.
//

import Foundation

class Student: NSObject {
    var id: NSNumber
    var name: NSString
    var year: NSString
    var majors: NSString
    var progression: NSString
    
    init(id: NSNumber, name: NSString, year: NSString, majors: NSString, progression: NSString) {
        self.id = id
        self.name = name
        self.year = year
        self.majors = majors
        self.progression = progression
    }
    
    // Default initializer
    override init() {
        self.id = -1
        self.name = "name"
        self.year = "year"
        self.majors = "majors"
        self.progression = "progression"
    }
}
