//
//  SettingsTableViewController.swift
//  Vigor
//
//  Created by Jason Shu on 6/27/18.
//  Copyright © 2018 Jason Shu. All rights reserved.
//

import UIKit

let numberOfRowsAtSection = [[0, 5], [1, 1], [2, 1]]

class SettingsTableViewController: UITableViewController {

    // clear all
    @IBAction func clearAll(_ sender: UIButton) {
        let clearAlert = UIAlertController(title: "Reset ALL Workouts?", message: "All Default Workout sets, reps, and weights will return to their default values.\nAll custom Workouts will be lost.", preferredStyle: UIAlertControllerStyle.alert)

        clearAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in

            bodyParts.removeAll()
            defaultWorkoutsSetup()

            let bodyPartsData = try! JSONEncoder().encode(bodyParts)
            defaults.set(bodyPartsData, forKey: "bodyParts")

        }))

        clearAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            // do nothing
        }))
        present(clearAlert, animated: true, completion: nil)
    }

    // clear calendar
    @IBAction func clearCalendar(_ sender: UIButton) {
        let clearAlert = UIAlertController(title: "Clear ALL Calendar Workout Progress?", message: "All calendar progress will be lost.\nWorkout completion will also be reset.", preferredStyle: UIAlertControllerStyle.alert)

        clearAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in

            for obj in calendarArray {
                for objWorkout in obj.workouts {

                    // reset done workouts too
                    for bodyPart in bodyParts {
                        for bodyPartWorkout in bodyPart.getWorkouts() {
                            // full workoutname because calendar name uses fullworkoutname
                            if (objWorkout.getFullWorkoutName() == bodyPartWorkout.getFullWorkoutName()) {
                                bodyPartWorkout.markWorkoutUndone()
                            }
                        }
                    }

                }
            }

            let bodyPartsData = try! JSONEncoder().encode(bodyParts)
            defaults.set(bodyPartsData, forKey: "bodyParts")

            calendarArray.removeAll()

            // reset to just today's date
            dateFormatter.dateFormat = "EEEE, MMMM d"
            todaysDate = dateFormatter.string(from: currentDate)

            calendarArray.append(CalendarWorkout(date: todaysDate, workouts: []))

            let calendarArrayData = try! JSONEncoder().encode(calendarArray)
            defaults.set(calendarArrayData, forKey: "calendarArray")

        }))

        clearAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            // do nothing
        }))
        present(clearAlert, animated: true, completion: nil)
    }

    // review
    @IBAction func leaveReview(_ sender: UIButton) {
        let reviewAlert = UIAlertController(title: "Write a Review!", message: "Tapping \"Ok\" will open the App Store.", preferredStyle: UIAlertControllerStyle.alert)

        reviewAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            if let url = URL(string: "itms-apps:itunes.apple.com/us/app/apple-store/id\(1405046880)?mt=8&action=write-review") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))

        reviewAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            // do nothing
        }))
        present(reviewAlert, animated: true, completion: nil)
    }

    // email
    @IBAction func contactMe(_ sender: UIButton) {

        let email = "shumatt190@gmail.com"

        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // title
        self.navigationItem.title = "Settings"

        // remove extra cells
        tableView.tableFooterView = UIView()

        // nav bar
        navigationItem.largeTitleDisplayMode = .never
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // table methods
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 3) {
            return 80.0
        }

        return 64.0

    }
}
