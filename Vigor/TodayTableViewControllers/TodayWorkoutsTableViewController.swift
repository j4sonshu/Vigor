//
//  todayWorkoutsTableViewController.swift
//  Vigor
//
//  Created by Jason Shu on 7/6/18.
//  Copyright © 2018 Jason Shu. All rights reserved.
//

import UIKit

var todayWorkouts = [Workout]()

var todayWorkoutsIndexTracker = 0

// date information
var todaysDate: String = ""
let currentDate = Date()
let dateFormatter = DateFormatter()

class TodayWorkoutsTableViewController: UITableViewController {

    override func viewDidLoad() {

        // first time
        if (defaults.object(forKey: "todayWorkouts") == nil) {
            let todayWorkoutsData = try! JSONEncoder().encode([Workout]())
            defaults.set(todayWorkoutsData, forKey: "todayWorkouts")
        }

        // all other times
        todayWorkouts = try! JSONDecoder().decode([Workout].self, from: defaults.data(forKey: "todayWorkouts")!)

        // remove extra cells
        tableView.tableFooterView = UIView()

        // title
        //dateFormatter.dateFormat = "EEE. MMMM d, yyyy" // worry about the year later
        dateFormatter.dateFormat = "EEEE, MMMM d"
        todaysDate = dateFormatter.string(from: currentDate)

        // nav title
        self.navigationItem.title = todaysDate

        // nav bar
        navigationItem.largeTitleDisplayMode = .always

        // reload table
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // table methods
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Today"
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.thin)
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64.0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todayWorkouts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let workout = todayWorkouts[indexPath.row]

        cell.textLabel?.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.thin)

        // Configure the cell...
        cell.textLabel?.text = workout.getWorkoutName()

        // image
        let image: UIImage = UIImage(named: "Body Parts icons/" + workout.getBodyPart())!
        cell.imageView?.image = image

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        todayWorkoutsIndexTracker = indexPath.row
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    // delete swipe
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            todayWorkouts.remove(at: indexPath.row)

            // defaults
            let todayWorkoutsData = try! JSONEncoder().encode(todayWorkouts)
            defaults.set(todayWorkoutsData, forKey: "todayWorkouts")

            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    @objc func loadList() {
        loadListHelper(vc: self)
    }
}
