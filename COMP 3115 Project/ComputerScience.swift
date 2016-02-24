//
//  ComputerScience.swift
//  CourseShare
//
//  Created by Ian Hanken on 2/24/16.
//  Copyright © 2016 Ian Hanken. All rights reserved.
//

import Foundation

class ComputerScience {
    var majorFlow: Dictionary<String, Class> = Dictionary<String, Class>()
    
    // Initializer arguments should always be empty, as everyone takes the same courseflow.
    init() {
        
        // Comp 1800
        let comp1800 = Class(className: "Problem Solving with Computers", classDept: "COMP", classID: 1800)
        majorFlow["COMP 1800"] = comp1800
        
        // Math 1730
        let math1730 = Class(className: "Pre-Calculus", classDept: "MATH", classID: 1730)
        majorFlow["MATH 1730"] = math1730
        
        // Comp 1950
        let comp1950 = Class(className: "Ethics", classDept: "COMP", classID: 1950)
        majorFlow["COMP 1950"] = comp1950
        
        // Comp 1900
        let comp1900 = Class(className: "Intro to CS", classDept: "COMP", classID: 1900, prereq1: comp1800, prereq2: math1730, prereq3: nil, prereq4: nil, prereq5: nil)
        majorFlow["COMP 1900"] = comp1900
        
        // Math 1910
        let math1910 = Class(className: "Calculus I", classDept: "MATH", classID: 1910, prereq1: comp1800, prereq2: math1730, prereq3: nil, prereq4: nil, prereq5: nil)
        majorFlow["MATH 1910"] = math1910
        
        // Math 1920
        let math1920 = Class(className: "Calculus II", classDept: "MATH", classID: 1920, prereq1: math1910, prereq2: nil, prereq3: nil, prereq4: nil, prereq5: nil)
        majorFlow["MATH 1920"] = math1920
        
        // COMP 2700
        let comp2700 = Class(className: "Discrete Math", classDept: "COMP", classID: 2700, prereq1: math1910, prereq2: nil, prereq3: nil, prereq4: nil, prereq5: nil)
        majorFlow["COMP 2700"] = comp2700
        
        // Math 3242
        let math3242 = Class(className: "Linear Algebra", classDept: "MATH", classID: 3242, prereq1: comp2700, prereq2: math1920, prereq3: nil, prereq4: nil, prereq5: nil)
        majorFlow["MATH 3242"] = math3242
        
        // Math 4614
        let math4614 = Class(className: "Probability/Statistics", classDept: "MATH", classID: 4614, prereq1: comp2700, prereq2: math1920, prereq3: nil, prereq4: nil, prereq5: nil)
        majorFlow["MATH 4614"] = math4614
        
        // Comp 2150
        let comp2150 = Class(className: "OOP and Data Structures", classDept: "COMP", classID: 2150, prereq1: comp1900, prereq2: nil, prereq3: nil, prereq4: nil, prereq5: nil)
        majorFlow["COMP 2150"] = comp2150
        
        // Comp 3410
        let comp3410 = Class(className: "Computer Organization/Architecture", classDept: "COMP", classID: 3410, prereq1: comp2150, prereq2: nil, prereq3: nil, prereq4: nil, prereq5: nil)
        majorFlow["COMP 3410"] = comp3410
        
        // Comp 3825
        let comp3825 = Class(className: "Networking/Info Assurance", classDept: "COMP", classID: 3825, prereq1: comp3410, prereq2: nil, prereq3: nil, prereq4: nil, prereq5: nil)
        majorFlow["COMP 3825"] = comp3825
        
        // Comp 4270
        let comp4270 = Class(className: "Operating Systems", classDept: "COMP", classID: 4270, prereq1: comp3410, prereq2: nil, prereq3: nil, prereq4: nil, prereq5: nil)
        majorFlow["COMP 4270"] = comp4270
        
        // Comp 4040
        let comp4040 = Class(className: "Programming Languages", classDept: "COMP", classID: 4040, prereq1: comp2150, prereq2: nil, prereq3: nil, prereq4: nil, prereq5: nil)
        majorFlow["COMP 4040"] = comp4040
        
        // Comp 3115
        let comp3115 = Class(className: "Database Process and Design", classDept: "COMP", classID: 3115, prereq1: comp2150, prereq2: nil, prereq3: nil, prereq4: nil, prereq5: nil)
        majorFlow["COMP 3115"] = comp3115
        
        // Comp 4081
        let comp4081 = Class(className: "Software Engineering", classDept: "COMP", classID: 4081, prereq1: comp3115, prereq2: nil, prereq3: nil, prereq4: nil, prereq5: nil)
        majorFlow["COMP 4081"] = comp4081
        
        // Comp 4030
        let comp4030 = Class(className: "Algorithms", classDept: "COMP", classID: 4030, prereq1: comp2700, prereq2: nil, prereq3: nil, prereq4: nil, prereq5: nil)
        majorFlow["COMP 4030"] = comp4030
        
        // Comp 4601
        let comp4601 = Class(className: "Models of Computation", classDept: "COMP", classID: 4601, prereq1: comp4030, prereq2: nil, prereq3: nil, prereq4: nil, prereq5: nil)
        majorFlow["CCOMP 4601"] = comp4601
        
        // Comp 4882
        let comp4882 = Class(className: "Capstone Project", classDept: "COMP", classID: 4882, prereq1: comp4030, prereq2: comp4081, prereq3: comp3115, prereq4: nil, prereq5: nil)
        majorFlow["COMP 4882"] = comp4882
    }
}