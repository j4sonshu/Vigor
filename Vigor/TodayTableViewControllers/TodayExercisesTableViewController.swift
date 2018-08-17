//
//  TodayExercisesViewTableViewController.swift
//  Vigor
//
//  Created by Jason Shu on 6/20/18.
//  Copyright © 2018 Jason Shu. All rights reserved.
//

import UIKit

var todayExerciseIndexTracker = 0

class TodayExercisesViewTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // remove extra cells
        tableView.tableFooterView = UIView()

        // title
        self.title = todayWorkouts[todayWorkoutsIndexTracker].getFullWorkoutName()

        // nav bar
        navigationItem.largeTitleDisplayMode = .never

        // done button/finish early
        let button = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(addTodayWorkoutToCalendar))
        self.navigationItem.rightBarButtonItem = button

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // table methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todayWorkouts[todayWorkoutsIndexTracker].getExercises().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let exercise = todayWorkouts[todayWorkoutsIndexTracker].getExercises()[indexPath.row]

        // Configure the cell...
        // cell text
        cell.textLabel?.text = String(indexPath.row + 1) + ". " + exercise.getExerciseName()

        cell.textLabel?.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.thin)

        // detail text
        cell.detailTextLabel?.text = exercise.getSetsAndReps()

        // no detail text for stretches
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

        // done cells
        if (exercise.done == true) {
            cell.accessoryType = .checkmark
        }

        if (exercise.done == false) {
            cell.accessoryType = .none
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        todayExerciseIndexTracker = indexPath.row
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let workout = todayWorkouts[todayWorkoutsIndexTracker]
        let exercise = workout.getExercises()[indexPath.row]

        // done
        let done = UIContextualAction(style: .normal, title: "Done") { (action, view, handler) in
            exercise.markExerciseDone()

            // done exercises will be marked in customexercises to indicate that it's been done
            for bodypart in customExercises {
                for subbodypart in bodypart {
                    for ex in subbodypart {
                        if(exercise.getExerciseName() == ex.getExerciseName()) {
                            ex.markExerciseDone()
                        }
                    }
                }
            }

            // defaults
            let customExercisesData = try! JSONEncoder().encode(customExercises)
            defaults.set(customExercisesData, forKey: "customExercises")

            let todayWorkoutsData = try! JSONEncoder().encode(todayWorkouts)
            defaults.set(todayWorkoutsData, forKey: "todayWorkouts")

            // when all exercises are green/done
            if (workout.areWorkoutExercisesDone() == true) {
                // abstraction
                addTodayWorkoutToCalendarHelper(workout: workout, exercise: exercise, todaysDate: todaysDate, tabBar: self.tabBarController!, viewController: self, nav: self.navigationController!)
            }

            self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.top)
            tableView.reloadData()
        }

        // undo
        let undo = UIContextualAction(style: .normal, title: "Undo") { (action, view, handler) in
            exercise.markExerciseUndone()

            // defaults
            let todayWorkoutsData = try! JSONEncoder().encode(todayWorkouts)
            defaults.set(todayWorkoutsData, forKey: "todayWorkouts")

            self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.bottom)
            tableView.reloadData()
        }

        done.backgroundColor = .green
        undo.backgroundColor = .red

        // alternating swipe options
        if exercise.done == true {
            let configuration = UISwipeActionsConfiguration(actions: [undo])
            configuration.performsFirstActionWithFullSwipe = false
            return configuration
        }

        else {
            let configuration = UISwipeActionsConfiguration(actions: [done])
            configuration.performsFirstActionWithFullSwipe = false
            return configuration
        }

    }

    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let workout = todayWorkouts[todayWorkoutsIndexTracker]
        let exercise = todayWorkouts[todayWorkoutsIndexTracker].getExercises()[indexPath.row]

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

                searchAndSetSets(workout: workout, exercise: exercise, sets: sets)

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

                searchAndSetReps(workout: workout, exercise: exercise, reps: reps)

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

                searchAndSetWeight(workout: workout, exercise: exercise, weight: weight)

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
        
        if workout.getBodyPart() == "Yoga" {
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

    @objc func addTodayWorkoutToCalendar() {
        addTodayWorkoutToCalendarHelper(workout: todayWorkouts[todayWorkoutsIndexTracker], exercise: Exercise(), todaysDate: todaysDate, tabBar: self.tabBarController!, viewController: self, nav: self.navigationController!)
    }

}
