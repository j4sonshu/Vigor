//
//  BodyPartExercisesTableViewController.swift
//  Vigor
//
//  Created by Jason Shu on 6/19/18.
//  Copyright © 2018 Jason Shu. All rights reserved.
//

import UIKit

var bodyPartExerciseIndexTracker = 0

class BodyPartExercisesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // remove extra cells
        tableView.tableFooterView = UIView()

        // title
        if bodyPartWorkoutSectionTracker == 0 {
            self.title = bodyParts[bodyPartIndexTracker].getWorkouts()[bodyPartWorkoutIndexTracker].getFullWorkoutName()
        }

        if bodyPartWorkoutSectionTracker == 1 {
            self.title = bodyParts[bodyPartIndexTracker].getStretches()[bodyPartWorkoutIndexTracker].getFullWorkoutName()
        }

        // when button is pressed, change (not push/present) into Today view
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWorkoutToToday))
        self.navigationItem.rightBarButtonItem = button

        // nav bar
        navigationItem.largeTitleDisplayMode = .never
        
        // reload table
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // table methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if bodyPartWorkoutSectionTracker == 0 {
            return bodyParts[bodyPartIndexTracker].getWorkouts()[bodyPartWorkoutIndexTracker].getExercises().count
        }
        return bodyParts[bodyPartIndexTracker].getStretches()[bodyPartWorkoutIndexTracker].getExercises().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        var workout = Workout()

        if bodyPartWorkoutSectionTracker == 0 {
            workout = bodyParts[bodyPartIndexTracker].getWorkouts()[bodyPartWorkoutIndexTracker]
        }

        else {
            // no detail text for stretches
            workout = bodyParts[bodyPartIndexTracker].getStretches()[bodyPartWorkoutIndexTracker]
        }

        let exercise = workout.getExercises()[indexPath.row]

        if (exercise.getSets() != "" || exercise.getReps() != "" || exercise.getWeight() != "") {

            // all 3
            if ((exercise.getSets() != "" || exercise.getReps() != "") && exercise.getWeight() != "") {
                cell.detailTextLabel?.text = exercise.getSetsAndReps() + " on " + exercise.getWeight() + " lbs"
            }

            // just weight
            if ((exercise.getSets() == "" && exercise.getReps() == "") && exercise.getWeight() != "") {
                cell.detailTextLabel?.text = "on " + exercise.getWeight() + " lbs"
            }

            // just reps/sets
            if ((exercise.getSets() != "" || exercise.getReps() != "") && exercise.getWeight() == "") { // weight == ""
                cell.detailTextLabel?.text = exercise.getSetsAndReps()
            }
        }
        else {
            cell.detailTextLabel?.text = ""
        }

        cell.textLabel?.text = String(indexPath.row + 1) + ". " + exercise.getExerciseName()
        cell.textLabel?.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.thin)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        bodyPartExerciseIndexTracker = indexPath.row
    }

    // swiping
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        var workout = Workout()

        if bodyPartWorkoutSectionTracker == 0 {
            workout = bodyParts[bodyPartIndexTracker].getWorkouts()[bodyPartWorkoutIndexTracker]
        }

        else {
            workout = bodyParts[bodyPartIndexTracker].getStretches()[bodyPartWorkoutIndexTracker]
        }

        let exercise = workout.getExercises()[indexPath.row]

        // set sets
        let setSets = UIContextualAction(style: .normal, title: "Sets") { (action, view, handler) in

            // alert to set sets
            let alert = UIAlertController(title: "Sets for \"" + exercise.getExerciseName() + "\"", message: "", preferredStyle: UIAlertControllerStyle.alert)

            alert.addTextField { (textField: UITextField!) -> Void in
                textField.placeholder = "Sets"
                textField.keyboardType = .numberPad
            }

            // OK option
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in

                // user input
                let sets = alert.textFields!.first!.text!
                // set the user input
                exercise.setSets(sets: sets)

                // defaults
                let bodyPartsData = try! JSONEncoder().encode(bodyParts)
                defaults.set(bodyPartsData, forKey: "bodyParts")

                self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.left)
                tableView.reloadData()
            }))

            // cancel option
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                // do nothing
                self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.bottom)
                tableView.reloadData()
            }))

            self.present(alert, animated: true, completion: nil)
        }

        // set reps
        let setReps = UIContextualAction(style: .normal, title: "Reps") { (action, view, handler) in

            // alert to set weight
            let alert = UIAlertController(title: "Reps for \"" + exercise.getExerciseName() + "\"", message: "", preferredStyle: UIAlertControllerStyle.alert)

            alert.addTextField { (textField: UITextField!) -> Void in
                textField.placeholder = "Reps"
                textField.keyboardType = .numberPad
            }

            // OK option
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in

                // user input
                let reps = alert.textFields!.first!.text!
                // set the user input
                exercise.setReps(reps: reps)

                // defaults
                let bodyPartsData = try! JSONEncoder().encode(bodyParts)
                defaults.set(bodyPartsData, forKey: "bodyParts")

                self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.left)
                tableView.reloadData()
            }))

            // cancel option
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                // do nothing
                self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.bottom)
                tableView.reloadData()
            }))

            self.present(alert, animated: true, completion: nil)
        }

        // set weight swipe
        let setWeight = UIContextualAction(style: .normal, title: "Weight") { (action, view, handler) in

            // alert to set weight
            let alert = UIAlertController(title: "Weight for \"" + exercise.getExerciseName() + "\"", message: "", preferredStyle: UIAlertControllerStyle.alert)

            alert.addTextField { (textField: UITextField!) -> Void in
                textField.placeholder = "Weight (lbs)"
                textField.keyboardType = .numberPad
            }

            // OK option
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in

                // user input
                let weight = alert.textFields!.first!.text!
                // set the user input
                exercise.setWeight(weight: weight)

                // defaults
                let bodyPartsData = try! JSONEncoder().encode(bodyParts)
                defaults.set(bodyPartsData, forKey: "bodyParts")

                self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.left)
                tableView.reloadData()
            }))

            // cancel option
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                // do nothing
                self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.bottom)
                tableView.reloadData()
            }))

            self.present(alert, animated: true, completion: nil)
        }

        setSets.backgroundColor = .lightGray
        setReps.backgroundColor = .lightGray
        setWeight.backgroundColor = .lightGray

        let configuration = UISwipeActionsConfiguration(actions: [setSets, setReps, setWeight])
        configuration.performsFirstActionWithFullSwipe = false
        
        // no yoga
        if bodyPartIndexTracker == 7 {
            return UISwipeActionsConfiguration()
        }
        
        return configuration
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeights[indexPath] = cell.frame.size.height
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let height = cellHeights[indexPath] else { return 70.0 }
        return height
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let configuration = UISwipeActionsConfiguration(actions: [])
        return configuration
    }

    // button helper function
    @objc func addWorkoutToToday() {
        if bodyPartWorkoutSectionTracker == 0 {
            addWorkoutToTodayHelper(workout: bodyParts[bodyPartIndexTracker].getWorkouts()[bodyPartWorkoutIndexTracker], tabBar: self.tabBarController!, viewController: self, nav: self.navigationController!)
        }
        else {
            addWorkoutToTodayHelper(workout: bodyParts[bodyPartIndexTracker].getStretches()[bodyPartWorkoutIndexTracker], tabBar: self.tabBarController!, viewController: self, nav: self.navigationController!)
        }
    }
    
    @objc func loadList() {
        loadListHelper(vc: self)
    }
}
