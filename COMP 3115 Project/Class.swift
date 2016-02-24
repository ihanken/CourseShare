//
//  Major.swift
//  CourseShare
//
//  Created by Ian Hanken on 2/24/16.
//  Copyright © 2016 Ian Hanken. All rights reserved.
//

import Foundation

class Class {
    // Class Identifiers
    let className: String
    let classDept: String
    let classID: Int
    
    // Prerequisites
    let prereq1: Class?
    let prereq2: Class?
    let prereq3: Class?
    let prereq4: Class?
    let prereq5: Class?
    
    func listPrerequisites() {
        if prereq1 == nil {
            print("No prerequisites exist for this class.")
        }
        if prereq1 != nil {
            print("Prerequisite One: \(prereq1)")
        }
        if prereq2 != nil {
            print("Prerequisite Two: \(prereq2)")
        }
        if prereq3 != nil {
            print("Prerequisite Three: \(prereq3)")
        }
        if prereq4 != nil {
            print("Prerequisite Four: \(prereq4)")
        }
        if prereq5 != nil {
            print("Prerequisite Five: \(prereq5)")
        }
    }
    
    // Initializer
    init(className: String, classDept: String, classID: Int) {
        self.className = className
        self.classDept = classDept
        self.classID = classID
        self.prereq1 = nil
        self.prereq2 = nil
        self.prereq3 = nil
        self.prereq4 = nil
        self.prereq5 = nil
    }
    
    init(className: String, classDept: String, classID: Int, prereq1: Class?, prereq2: Class?, prereq3: Class?, prereq4: Class?, prereq5: Class?) {
        self.className = className
        self.classDept = classDept
        self.classID = classID
        self.prereq1 = prereq1
        self.prereq2 = prereq2
        self.prereq3 = prereq3
        self.prereq4 = prereq4
        self.prereq5 = prereq5
    }
    
    // Empty initializer
    init() {
        self.className = "className"
        self.classDept = "classDept"
        self.classID = -1
        self.prereq1 = nil
        self.prereq2 = nil
        self.prereq3 = nil
        self.prereq4 = nil
        self.prereq5 = nil
    }
    
}