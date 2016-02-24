//
//  Student.swift
//  CourseShare
//
//  Created by Ian Hanken on 2/3/16.
//  Copyright © 2016 Ian Hanken. All rights reserved.
//

import Foundation

class Student: NSObject {
    
    var name: NSString
    var year: NSString
    var majors: NSString
    var progression: NSString
    
    init(name: NSString, year: NSString, majors: NSString, progression: NSString) {
        self.name = name
        self.year = year
        self.majors = majors
        self.progression = progression
    }
    
    // Default initializer
    override init() {
        self.name = "name"
        self.year = "year"
        self.majors = "majors"
        self.progression = "progression"
    }
}
