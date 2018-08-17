//
//  BodyPartWorkoutsTableViewController.swift
//  Vigor
//
//  Created by Jason Shu on 6/19/18.
//  Copyright © 2018 Jason Shu. All rights reserved.
//

import UIKit

var bodyPartWorkoutIndexTracker = 0
var bodyPartWorkoutSectionTracker = 0

class BodyPartWorkoutsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // retrieve body part name
        self.title = bodyParts[bodyPartIndexTracker].getBodyPartName()

        // nav bar
        navigationItem.largeTitleDisplayMode = .never

        if bodyPartIndexTracker == bodyParts.count - 1 {
            let button = UIBarButtonItem(title: "Create", style: UIBarButtonItemStyle.plain, target: self, action: #selector(createButtonTapped))
            self.navigationItem.rightBarButtonItem = button
        }

        // reload table
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // table methods
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Stretches"
        }

        else {
            // yoga
            if bodyPartIndexTracker == 7 {
                return "Poses"
            }
            // custom
            if bodyPartIndexTracker == bodyParts.count - 1 {
                return "Custom Workouts"
            }
            return "Default Workouts"
        }
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.thin)
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64.0
    }

    override func numberOfSections(in tableView: UITableView) -> Int {

        // ply, yoga, custom have no 2nd section for stretches
        if (bodyPartIndexTracker == 5 || bodyPartIndexTracker == 7 || bodyPartIndexTracker == bodyParts.count - 1) {
            return 1
        }
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return bodyParts[bodyPartIndexTracker].getWorkouts().count
        }
        return bodyParts[bodyPartIndexTracker].getStretches().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.thin)

        var workout = Workout()

        if (indexPath.section == 0) {

            workout = bodyParts[bodyPartIndexTracker].getWorkouts()[indexPath.row]
            cell.textLabel?.text = workout.getWorkoutName()

            if bodyPartIndexTracker == bodyParts.count - 1 {
                let image: UIImage = UIImage(named: "Body Parts icons/" + workout.getBodyPart())!
                cell.imageView?.image = image
            }
        }

        else {
            // stretch
            workout = bodyParts[bodyPartIndexTracker].getStretches()[indexPath.row]
            cell.textLabel?.text = workout.getWorkoutName()
        }

        // doneBefore workouts indicator
        if (workout.getWorkoutDoneBefore() == true) {
            cell.accessoryType = .checkmark
        }

        // doneBefore workouts indicator
        if (workout.getWorkoutDoneBefore() == false) {
            cell.accessoryType = .none
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        bodyPartWorkoutIndexTracker = indexPath.row
        bodyPartWorkoutSectionTracker = indexPath.section
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {

        // delete swipe for custom workouts, not for defaults
        if bodyPartIndexTracker == bodyParts.count - 1 {
            return true
        }
        return false
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            let workouts = bodyParts[bodyPartIndexTracker]
            let workout = workouts.getWorkouts()[indexPath.row]

            // delete alert
            let alert = UIAlertController(title: "Are you sure you want to delete \"" + workout.getWorkoutName() + "\"?", message: "This cannot be undone.", preferredStyle: UIAlertControllerStyle.alert)

            // OK option
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in

                workouts.removeWorkoutFromWorkouts(workout: workout)

                // defaults
                let bodyPartsData = try! JSONEncoder().encode(bodyParts)
                defaults.set(bodyPartsData, forKey: "bodyParts")

                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }))

            // cancel option
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                // do nothing
            }))

            self.present(alert, animated: true, completion: nil)
        }
    }

    @objc func createButtonTapped(sender: UIButton) {
        // animate to customize table
        let imageView = storyboard?.instantiateViewController(withIdentifier: "CustomWorkoutSelector")
        self.navigationController?.pushViewController(imageView!, animated: true)
    }

    @objc func loadList() {
        loadListHelper(vc: self)
    }

}
