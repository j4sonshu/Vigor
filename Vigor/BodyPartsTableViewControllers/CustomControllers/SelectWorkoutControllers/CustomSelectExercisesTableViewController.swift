//
//  CustomSelectExercisesTableViewController.swift
//  Vigor
//
//  Created by Jason Shu on 7/5/18.
//  Copyright © 2018 Jason Shu. All rights reserved.
//

import UIKit

var selectedExercises = [Exercise]()

var customSelectExerciseIndexTracker = 0
var customSelectExerciseSectionTracker = 0

var cellHeights: [IndexPath: CGFloat] = [:]

class CustomSelectExercisesTableViewController: UITableViewController {

    var selectExercises = [[Exercise]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // remove extra cells
        tableView.tableFooterView = UIView()

        // arms 0, back 1, chest 2, core 3, legs 4, ply 5, shoulders 6
        // example: forearms = customExercises[0][0]

        // sub body parts: arms 0-2, back 3-6, chest 7, core 8, legs 9-12, plyo 13, shoulders 14
        switch selectedWorkout.getBodyPart() {
        case "Arms":
            selectExercises = customExercises[0]
        case "Back":
            selectExercises = customExercises[1]
        case "Chest":
            selectExercises = customExercises[2]
        case "Core":
            selectExercises = customExercises[3]
        case "Legs":
            selectExercises = customExercises[4]
        case "Plyometrics":
            selectExercises = customExercises[5]
        case "Shoulders":
            selectExercises = customExercises[6]
        default:
            selectExercises = [[Exercise]]()
        }

        // title
        self.title = selectedWorkout.getWorkoutName()

        // nav bar
        navigationItem.largeTitleDisplayMode = .never

        // save button
        let button = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.plain, target: self, action: #selector(seeSelectedExercises))
        self.navigationItem.rightBarButtonItem = button
        
        // reset when backing
        selectedExercises = [Exercise]()
        
        // reload table
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // table methods
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        let arms = ["Forearms", "Triceps", "Biceps"]
        let back = ["Lats", "Middle Back", "Lower Back", "Traps"]
        let legs = ["Quadriceps", "Hamstrings", "Calves", "Glutes"]

        switch selectedWorkout.getBodyPart() {
        case "Arms": return arms[section]
        case "Back": return back[section]
        case "Chest": return "Chest"
        case "Core": return "Core"
        case "Legs": return legs[section]
        case "Plyometrics": return "Plyometrics"
        case "Shoulders": return "Shoulders"
        default: return ""
        }
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.thin)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        switch selectedWorkout.getBodyPart() {
        case "Arms": return customExercises[0].count
        case "Back": return customExercises[1].count
        case "Chest": return customExercises[2].count
        case "Core": return customExercises[3].count
        case "Legs": return customExercises[4].count
        case "Plyometrics": return customExercises[5].count
        case "Shoulders": return customExercises[6].count
        default: return 0
        }
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64.0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectedWorkout.getBodyPart() {
        case "Arms": return customExercises[0][section].count
        case "Back": return customExercises[1][section].count
        case "Chest": return customExercises[2][section].count
        case "Core": return customExercises[3][section].count
        case "Legs": return customExercises[4][section].count
        case "Plyometrics": return customExercises[5][section].count
        case "Shoulders": return customExercises[6][section].count
        default: return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        var exercise = Exercise()

        // Configure the cell...
        switch selectedWorkout.getBodyPart() {
        case "Arms": cell.textLabel?.text = customExercises[0][indexPath.section][indexPath.row].getExerciseName()

            exercise = customExercises[0][indexPath.section][indexPath.row]
        case "Back": cell.textLabel?.text = customExercises[1][indexPath.section][indexPath.row].getExerciseName()

            exercise = customExercises[1][indexPath.section][indexPath.row]
        case "Chest": cell.textLabel?.text = customExercises[2][indexPath.section][indexPath.row].getExerciseName()

            exercise = customExercises[2][indexPath.section][indexPath.row]
        case "Core": cell.textLabel?.text = customExercises[3][indexPath.section][indexPath.row].getExerciseName()

            exercise = customExercises[3][indexPath.section][indexPath.row]
        case "Legs": cell.textLabel?.text = customExercises[4][indexPath.section][indexPath.row].getExerciseName()

            exercise = customExercises[4][indexPath.section][indexPath.row]
        case "Plyometrics": cell.textLabel?.text = customExercises[5][indexPath.section][indexPath.row].getExerciseName()

            exercise = customExercises[5][indexPath.section][indexPath.row]
        case "Shoulders": cell.textLabel?.text = customExercises[6][indexPath.section][indexPath.row].getExerciseName()

            exercise = customExercises[6][indexPath.section][indexPath.row]
        default: cell.textLabel?.text = ""
        }

        cell.textLabel?.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.thin)

        if (selectedExercises.contains(exercise) == true) {
            cell.accessoryType = .checkmark
        }

        if (selectedExercises.contains(exercise) == false) {
            cell.accessoryType = .none
        }
        
        if exercise.done == true {
            cell.backgroundColor = .green
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        customSelectExerciseIndexTracker = indexPath.row
        customSelectExerciseSectionTracker = indexPath.section
    }

    // trailing swipes to add to selectED
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        var exercise = Exercise()

        // Configure the cell...
        switch selectedWorkout.getBodyPart() {
        case "Arms": exercise = customExercises[0][indexPath.section][indexPath.row]
        case "Back": exercise = customExercises[1][indexPath.section][indexPath.row]
        case "Chest": exercise = customExercises[2][indexPath.section][indexPath.row]
        case "Core": exercise = customExercises[3][indexPath.section][indexPath.row]
        case "Legs": exercise = customExercises[4][indexPath.section][indexPath.row]
        case "Plyometrics": exercise = customExercises[5][indexPath.section][indexPath.row]
        case "Shoulders": exercise = customExercises[6][indexPath.section][indexPath.row]
        default: exercise = Exercise()
        }

        // done
        let add = UIContextualAction(style: .normal, title: "Add") { (action, view, handler) in

            selectedExercises.append(exercise)
            self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.top)
            tableView.reloadData()
        }

        // undo
        let remove = UIContextualAction(style: .normal, title: "Remove") { (action, view, handler) in

            selectedExercises.remove(at: selectedExercises.index(of: exercise)!)
            self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.bottom)
            tableView.reloadData()
        }

        add.backgroundColor = .green
        remove.backgroundColor = .red

        // alternating swipe options
        if (selectedExercises.contains(exercise) == true) {
            let configuration = UISwipeActionsConfiguration(actions: [remove])
            configuration.performsFirstActionWithFullSwipe = false
            return configuration
        }

        else {
            let configuration = UISwipeActionsConfiguration(actions: [add])
            configuration.performsFirstActionWithFullSwipe = false
            return configuration
        }
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeights[indexPath] = cell.frame.size.height
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let height = cellHeights[indexPath] else { return 70.0 }
        return height
    }

    // button helper function
    @objc func seeSelectedExercises() {

        if (selectedExercises.count) == 0 {
            let alert = UIAlertController(title: "Please select a least 1 exercise.", message: "", preferredStyle: UIAlertControllerStyle.alert)

            // OK option
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                // do nothing
            }))

            self.present(alert, animated: true, completion: nil)
        }

        else {
            let imageView = storyboard?.instantiateViewController(withIdentifier: "CustomSelectedExercises")
            self.navigationController?.pushViewController(imageView!, animated: true)
        }

    }
    
    @objc func loadList() {
        loadListHelper(vc: self)
    }
    
}
