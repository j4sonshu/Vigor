//
//  CustomSelectedExercisesTableViewController.swift
//  Vigor
//
//  Created by Jason Shu on 7/6/18.
//  Copyright © 2018 Jason Shu. All rights reserved.
//

import UIKit

var customSelectedExerciseIndexTracker = 0

class CustomSelectedExercisesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // remove extra cells
        tableView.tableFooterView = UIView()

        // title
        self.title = selectedWorkout.getWorkoutName()

        // nav bar
        navigationItem.largeTitleDisplayMode = .never

        // save button
        let button = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.plain, target: self, action: #selector(saveCustomWorkout))

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
        return selectedExercises.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.thin)

        // Configure the cell...
        let exercise = selectedExercises[indexPath.row]
        cell.textLabel?.text = String(indexPath.row + 1) + ". " + exercise.getExerciseName()

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        customSelectedExerciseIndexTracker = indexPath.row
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            selectedExercises.remove(at: selectedExercises.index(of: selectedExercises[indexPath.row])!)

            // defaults
            let bodyPartsData = try! JSONEncoder().encode(bodyParts)
            defaults.set(bodyPartsData, forKey: "bodyParts")

            self.tableView.deleteRows(at: [indexPath], with: .fade)

            if selectedExercises.count == 0 {
                self.navigationController?.popViewController(animated: true)
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }
    }

    // button helper function
    @objc func saveCustomWorkout() {
        selectedWorkout = Workout(name: selectedWorkout.getWorkoutName(), bodyPart: selectedWorkout.getBodyPart(), exercises: selectedExercises, workoutDoneBefore: false)
        saveCustomWorkoutHelper(workout: selectedWorkout, tabBar: self.tabBarController!, viewController: self, nav: self.navigationController!)
    }

}
