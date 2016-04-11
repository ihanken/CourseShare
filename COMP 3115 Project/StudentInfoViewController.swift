//
//  StudentInfo.swift
//  CourseShare
//
//  Created by Ian Hanken on 2/27/16.
//  Copyright © 2016 Ian Hanken. All rights reserved.
//

import Foundation
import UIKit

class StudentInfoViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var yearPicker: UIPickerView!
    
    @IBOutlet weak var majorPicker: UIPickerView!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var chooseClassesButton: UIButton!
    
    var name: String = "Test Test"
    
    var year: String = "Freshman"
    
    var major: String = "Computer Science"
    
    var yearPickerDataSource = ["Freshman", "Sophomore", "Junior", "Senior"]
    
    var majorPickerDataSource = ["Computer Science", "Computer Engineering", "Electrical Engineering"]
    
    @IBAction func unwindToStudentInfoViewController (sender: UIStoryboardSegue){
        
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 50
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        name = textField.text!
        
        return true
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == self.yearPicker {
            return yearPickerDataSource.count
        }
        else {
            return majorPickerDataSource.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == self.yearPicker {
            return yearPickerDataSource[row]
        }
        else {
            return majorPickerDataSource[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if pickerView == self.yearPicker {
            year = yearPickerDataSource[row]
        }
        else {
            major = majorPickerDataSource[row]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.yearPicker.dataSource = self
        self.majorPicker.delegate = self
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "chooseClassesSegue") {
            let csvc = segue.destinationViewController as! ClassSelectionViewController
            
            csvc.toPass = [name, year, major]
            
        }
    }
    
}