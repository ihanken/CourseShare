//
//  ElectricalEngineering.swift
//  CourseShare
//
//  Created by Ian Hanken on 3/30/16.
//  Copyright © 2016 Ian Hanken. All rights reserved.
//

import Foundation

class ElectricalEngineering {
    var majorFlow: Dictionary<String, Class> = Dictionary<String, Class>()
    var classArray = [Class]()
    
    // Initializer arguments should always be empty, as everyone takes the same courseflow.
    init() {
        // MATH 1730
        let math1730 = Class(className: "Pre-Calculus", classDept: "MATH", classID: 1730)
        majorFlow["MATH 1730"] = math1730
        classArray.append(math1730)
        
        // MATH 1910
        let math1910 = Class(className: "Calculus I", classDept: "MATH", classID: 1910)
        majorFlow["MATH 1910"] = math1910
        classArray.append(math1910)
        
        // MATH 1920
        let math1920 = Class(className: "Calculus II", classDept: "MATH", classID: 1920, prereq1: math1910, prereq2: nil, prereq3: nil, prereq4: nil, prereq5: nil)
        majorFlow["MATH 1920"] = math1920
        classArray.append(math1920)
        
        // MATH 2110
        let math2110 = Class(className: "Calculus III", classDept: "MATH", classID: 2110, prereq1: math1920, prereq2: nil, prereq3: nil, prereq4: nil, prereq5: nil)
        majorFlow["MATH 2110"] = math2110
        classArray.append(math2110)
        
        // MATH 3120
        let math3120 = Class(className: "Intro to Differential Equations", classDept: "MATH", classID: 3120, prereq1: math2110, prereq2: nil, prereq3: nil, prereq4: nil, prereq5: nil)
        majorFlow["MATH 3120"] = math3120
        classArray.append(math3120)
        
        // COMP 1900
        let comp1900 = Class(className: "Intro to CS", classDept: "COMP", classID: 1900, prereq1: math1910, prereq2: nil, prereq3: nil, prereq4: nil, prereq5: nil)
        majorFlow["COMP 1900"] = comp1900
        classArray.append(comp1900)
        
        // PHYS 2110
        let phys2110 = Class(className: "Electrical/Computer Engineering Concepts", classDept: "EECE", classID: 1202)
        
        // EECE 1202
        let eece1202 = Class(className: "Electrical/Computer Engineering Concepts", classDept: "EECE", classID: 1202)
        majorFlow["EECE 1202"] = eece1202
        classArray.append(eece1202)
    }
}