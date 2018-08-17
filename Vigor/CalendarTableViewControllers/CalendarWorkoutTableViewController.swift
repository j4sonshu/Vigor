//
//  CalendarWorkoutTableViewController.swift
//  Vigor
//
//  Created by Jason Shu on 6/22/18.
//  Copyright © 2018 Jason Shu. All rights reserved.
//

import UIKit

class CalendarWorkoutTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // remove extra cells
        tableView.tableFooterView = UIView()

        // title
        self.title = calendarArray[calendarSectionTracker].workouts[calendarIndexTracker].getFullWorkoutName()

        // nav bar
        navigationItem.largeTitleDisplayMode = .never
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // table methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calendarArray[calendarSectionTracker].workouts[calendarIndexTracker].getExercises().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let exercise = calendarArray[calendarSectionTracker].workouts[calendarIndexTracker].getExercises()[indexPath.row]

        // Configure the cell...

        // untappable cells
        cell.selectionStyle = UITableViewCellSelectionStyle.none

        // cell text
        cell.textLabel?.text = String(indexPath.row + 1) + ". " + exercise.getExerciseName()
        cell.textLabel?.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.thin)

        // detail text
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

        // unfinished cells
        if (exercise.done == false) {
            cell.contentView.alpha = 0.3
        }

        return cell
    }
}
