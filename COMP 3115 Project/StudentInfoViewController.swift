//
//  StudentInfo.swift
//  CourseShare
//
//  Created by Ian Hanken on 2/27/16.
//  Copyright © 2016 Ian Hanken. All rights reserved.
//

import Foundation
import UIKit

class StudentInfoViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, MajorCellDelegate {
    
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var yearPicker: UIPickerView!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var chooseClassesButton: UIButton!
    
    @IBOutlet weak var majorTableView: UITableView!
    
    var name: String = "Test Test"
    
    var year: String = "Freshman"
    
    var majors: String = "Computer Science"
    
    var yearPickerDataSource = ["Freshman", "Sophomore", "Junior", "Senior"]
    
    var majorPickerDataSource = ["Computer Science", "Computer Engineering", "Electrical Engineering"]
    
    var majorsSelected = [String]()
    
    @IBAction func unwindToStudentInfoViewController (sender: UIStoryboardSegue){
        // Pop all view controllers off of the stack until this view controller is reached.
    }
    
    @IBAction func handledSwitchChange(sender: UISwitch) {
        majorsSelected.removeAll()
        majorTableView.reloadData()
    }
    
    func didChangeSwitchState(sender: MajorCell, isOn: Bool) {
        let indexPath = self.majorTableView.indexPathForCell(sender)
        let index = indexPath!.row
        //majorPickerDataSource[index].selected = isOn
        majorsSelected.removeAll()
        majorTableView.reloadData()
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
        return yearPickerDataSource.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print(yearPickerDataSource[row])
        return yearPickerDataSource[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        year = yearPickerDataSource[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.yearPicker.dataSource = self
        self.majorTableView.delegate = self
        self.majorTableView.dataSource = self
        
        nameField.autocapitalizationType = UITextAutocapitalizationType.Words
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "chooseClassesSegue") {
            let csvc = segue.destinationViewController as! ClassSelectionViewController
            print(majorsSelected)
            csvc.toPass = [name, year, majorsSelected.description]
            csvc.majorsSelected = majorsSelected
            print(csvc)
        }
    }
}

extension StudentInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(majorPickerDataSource.count)
        return majorPickerDataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.majorTableView.dequeueReusableCellWithIdentifier("majorCell") as! MajorCell
        
        // Rotate the switch 180 degrees.
        cell.majorSwitch.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        
        cell.majorName.text = majorPickerDataSource[indexPath.row]
        print(cell.majorName.text)
        if cell.majorSwitch.on == true {
            majorsSelected.append(majorPickerDataSource[indexPath.row])
        }
        
        //cell.cellDelegate = self
        
        return cell
    }
}