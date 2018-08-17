//
//  CustomWorkoutMakerTableViewController.swift
//  Vigor
//
//  Created by Jason Shu on 6/29/18.
//  Copyright © 2018 Jason Shu. All rights reserved.
//

import UIKit

var selectedWorkout = Workout()

// picker
let pickerData = ["Arms", "Back", "Chest", "Core", "Legs", "Plyometrics", "Shoulders"]

class CustomWorkoutMakerTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    var customName: String = ""
    var customBodyPart = "Arms"

    override func viewDidLoad() {
        super.viewDidLoad()

        // title
        self.navigationItem.title = ""

        // remove extra cells
        tableView.tableFooterView = UIView()

        // remove bottom border line
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none

        // close keyboard on tap
        let tapper = UITapGestureRecognizer(target: self, action: #selector(doneButtonTextField))
        tapper.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapper)

        // create, save and add to today
        let button = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.plain, target: self, action: #selector(selectExercises))
        self.navigationItem.rightBarButtonItem = button

        // nav bar
        navigationItem.largeTitleDisplayMode = .never

        tableView.isScrollEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // table methods
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // name
        if section == 0 {
            return "Workout Name:"
        }
        return "Body Part:"
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.thin)
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64.0
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let frame: CGRect = cell.frame

        // untappable cells
        cell.selectionStyle = UITableViewCellSelectionStyle.none

        // name field
        if indexPath.section == 0 {
            let textField = UITextField(frame: CGRect(x: 5, y: 5, width: frame.width - 10, height: frame.height - 10))
            textField.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.thin)
            textField.placeholder = "Name"
            textField.autocorrectionType = .no
            textField.adjustsFontSizeToFitWidth = true
            textField.borderStyle = UITextBorderStyle.roundedRect
            textField.returnKeyType = UIReturnKeyType.done
            textField.clearButtonMode = UITextFieldViewMode.whileEditing
            textField.addTarget(nil, action: Selector(("firstResponderAction:")), for: .editingDidEndOnExit)

            textField.addTarget(nil, action: #selector(nameTextFieldChanged), for: .editingChanged)

            cell.addSubview(textField)
        }

        // body part picker
        if indexPath.section == 1 {

            let picker = UIPickerView(frame: CGRect(x: 5, y: 5, width: frame.width - 10, height: frame.height - 10))
            picker.delegate = self
            picker.dataSource = self
            picker.selectRow(0, inComponent: 0, animated: true)
            picker.showsSelectionIndicator = true
            picker.isHidden = false

            cell.addSubview(picker)
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        // body part picker
        if indexPath.section == 1 {
            return 128.0
        }

        return UITableViewAutomaticDimension
    }

    // picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        customBodyPart = pickerData[row]
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: UIFont.Weight.thin)
        label.textAlignment = NSTextAlignment.center
        label.text = pickerData[row]
        return label
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 36.0
    }

    // close text fields
    @objc func doneButtonTextField() {
        self.view.endEditing(true)
    }

    // save name
    @objc func nameTextFieldChanged(_sender: UITextField) {
        customName = _sender.text!
    }

    // add/save button
    @objc func selectExercises() {

        // alerts for invalid inputs...add later
        if customName == "" {

            let alert = UIAlertController(title: "Please enter a Workout Name.", message: "", preferredStyle: UIAlertControllerStyle.alert)

            // OK option
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                // do nothing
            }))

            self.present(alert, animated: true, completion: nil)
        }

        else {
            selectedWorkout = Workout(name: customName, bodyPart: customBodyPart, exercises: [], workoutDoneBefore: false)
            let imageView = storyboard?.instantiateViewController(withIdentifier: "CustomSelectExercises")
            self.navigationController?.pushViewController(imageView!, animated: true)
        }
    }

}

