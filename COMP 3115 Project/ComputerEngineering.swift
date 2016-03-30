//
//  ComputerEngineering.swift
//  CourseShare
//
//  Created by Ian Hanken on 3/30/16.
//  Copyright © 2016 Ian Hanken. All rights reserved.
//

import Foundation

class ComputerEngineering {
    
    var majorFlow: Dictionary<String, Class> = Dictionary<String, Class>()
    var classArray = [Class]()
    
    // Initializer arguments should always be empty, as everyone takes the same courseflow.
    init() {
        // ENGL 3603
        let engl3603 = Class(className: "Engineering Communications", classDept: "ENGL", classID: 3603)
        majorFlow["ENGL 3603"] = engl3603
        classArray.append(engl3603)
        
        // MATH 1730
        let math1730 = Class(className: "Pre-Calculus", classDept: "MATH", classID: 1730)
        majorFlow["MATH 1730"] = math1730
        classArray.append(math1730)
        
        // MATH 1910
        let math1910 = Class(className: "Calculus I", classDept: "MATH", classID: 1910)
        majorFlow["MATH 1910"] = math1910
        classArray.append(math1910)
        
        // MATH 1920
        let math1920 = Class(className: "Calculus II", classDept: "MATH", classID: 1920, prereq1: math1910)
        majorFlow["MATH 1920"] = math1920
        classArray.append(math1920)
        
        // MATH 2110
        let math2110 = Class(className: "Calculus III", classDept: "MATH", classID: 2110, prereq1: math1920)
        majorFlow["MATH 2110"] = math2110
        classArray.append(math2110)
        
        // MATH 3120
        let math3120 = Class(className: "Intro to Differential Equations", classDept: "MATH", classID: 3120, prereq1: math1920)
        majorFlow["MATH 3120"] = math3120
        classArray.append(math3120)
        
        // COMP 1900
        let comp1900 = Class(className: "Intro to CS", classDept: "COMP", classID: 1900)
        majorFlow["COMP 1900"] = comp1900
        classArray.append(comp1900)
        
        // COMP 2150
        let comp2150 = Class(className: "CS2: Data Structures", classDept: "COMP", classID: 2150, prereq1: comp1900)
        majorFlow["COMP 2150"] = comp2150
        classArray.append(comp2150)
        
        // COMP 2700
        let comp2700 = Class(className: "CS2: Data Structures", classDept: "COMP", classID: 2700, prereq1: comp2150, prereq2: math1910)
        majorFlow["COMP 2700"] = comp2700
        classArray.append(comp2700)
        
        // MATH 3242
        let math3242 = Class(className: "Linear Algebra", classDept: "MATH", classID: 3242, prereq1: math1920, prereq2: comp2700)
        majorFlow["MATH 3242"] = math3242
        classArray.append(math3242)
        
        // MATH 4614
        let math4614 = Class(className: "Probability/Statistics", classDept: "MATH", classID: 4614, prereq1: math1920, prereq2: comp2700)
        majorFlow["MATH 4614"] = math4614
        classArray.append(math4614)
        
        // PHYS 2110
        let phys2110 = Class(className: "Engineering Physics I", classDept: "PHYS", classID: 2110, prereq1: math1910)
        majorFlow["PHYS 2110"] = phys2110
        classArray.append(phys2110)
        
        // PHYS 2120
        let phys2120 = Class(className: "Engineering Physics II", classDept: "PHYS", classID: 2120, prereq1: math1910, prereq2: phys2110)
        majorFlow["PHYS 2120"] = phys2120
        classArray.append(phys2120)
        
        // EECE 1202
        let eece1202 = Class(className: "Electrical/Computer Engineering Concepts", classDept: "EECE", classID: 1202)
        majorFlow["EECE 1202"] = eece1202
        classArray.append(eece1202)
        
        // EECE 2201
        let eece2201 = Class(className: "Circuit Analysis I", classDept: "EECE", classID: 2201, prereq1: phys2120, prereq2: math1920)
        majorFlow["EECE 2201"] = eece2201
        classArray.append(eece2201)
        
        // EECE 2207
        let eece2207 = Class(className: "Engineering Math Applications", classDept: "EECE", classID: 2207, prereq1: eece1202)
        majorFlow["EECE 2207"] = eece2207
        classArray.append(eece2207)
        
        // EECE 2222
        let eece2222 = Class(className: "Digital Circuit Design", classDept: "EECE", classID: 2222, prereq1: comp1900)
        majorFlow["EECE 2222"] = eece2222
        classArray.append(eece2222)
        
        // EECE 3201
        let eece3201 = Class(className: "Circuit Analysis II", classDept: "EECE", classID: 3201, prereq1: eece2201, prereq2: eece2207, prereq3: math3120)
        majorFlow["EECE 3201"] = eece3201
        classArray.append(eece3201)
        
        // EECE 3203
        let eece3203 = Class(className: "Signals and Systems I", classDept: "EECE", classID: 3203, prereq1: eece2201, prereq2: eece2207, prereq3: math3120)
        majorFlow["EECE 3203"] = eece3203
        classArray.append(eece3203)
        
        // EECE 3204
        let eece3204 = Class(className: "Signals and Systems II", classDept: "EECE", classID: 3204, prereq1: eece3203)
        majorFlow["EECE 3204"] = eece3204
        classArray.append(eece3204)
        
        // EECE 3211
        let eece3211 = Class(className: "Electronics I", classDept: "EECE", classID: 3211, prereq1: eece2201, prereq2: eece2207)
        majorFlow["EECE 3211"] = eece3211
        classArray.append(eece3211)
        
        // EECE 3240
        let eece3240 = Class(className: "Electromagnetic Field Theory", classDept: "EECE", classID: 3240, prereq1: math2110, prereq2: math3120)
        majorFlow["EECE 3240"] = eece3240
        classArray.append(eece3240)
        
        // EECE 3270
        let eece3270 = Class(className: "Intro to Microprocessors", classDept: "EECE", classID: 3270, prereq1: eece2222)
        majorFlow["EECE 3270"] = eece3270
        classArray.append(eece3270)
        
        // EECE 4201
        let eece4201 = Class(className: "Energy Conversion", classDept: "EECE", classID: 4201, prereq1: eece3201)
        majorFlow["EECE 4201"] = eece4201
        classArray.append(eece4201)
        
        // EECE 4278
        let eece4278 = Class(className: "Computer Organization", classDept: "EECE", classID: 4278, prereq1: eece3270)
        majorFlow["EECE 4278"] = eece4278
        classArray.append(eece4278)
        
        // EECE 4279
        let eece4279 = Class(className: "Professional Development", classDept: "EECE", classID: 4279, prereq1: eece3270, prereq2: eece3211, prereq3: eece3201)
        majorFlow["EECE 4279"] = eece4279
        classArray.append(eece4279)
        
        // EECE 4991
        let eece4991 = Class(className: "Projects I", classDept: "EECE", classID: 4991, prereq1: eece3201, prereq2: eece3203, prereq3: eece3211)
        majorFlow["EECE 4991"] = eece4991
        classArray.append(eece4991)
        
        // EECE 4280
        let eece4280 = Class(className: "Senior Design", classDept: "EECE", classID: 4280, prereq1: eece4279, prereq2: eece3204, prereq3: eece4991)
        majorFlow["EECE 4280"] = eece4280
        classArray.append(eece4280)
        
        // COMP 4270
        let comp4270 = Class(className: "Operating Systems", classDept: "COMP", classID: 4270, prereq1: comp2150, prereq2: eece4278)
        majorFlow["COMP 4270"] = comp4270
        classArray.append(comp4270)
    }
}