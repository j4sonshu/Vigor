//
//  CalendarTableViewController.swift
//  Vigor
//
//  Created by Jason Shu on 6/22/18.
//  Copyright © 2018 Jason Shu. All rights reserved.
//

// dictionary converted to arry to use in table cells
var calendarArray = [CalendarWorkout]()
var calendarIndexTracker = 0
var calendarSectionTracker = 0

import UIKit

class CalendarTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // remove extra cells
        tableView.tableFooterView = UIView()

        // title
        self.navigationItem.title = "Calendar"

        // first time
        if (defaults.object(forKey: "calendarArray") == nil) {

            // temp calendar for very first time
            // has a date, but no workouts
            dateFormatter.dateFormat = "EEEE, MMMM d"
            todaysDate = dateFormatter.string(from: currentDate)

            calendarArray.append(CalendarWorkout(date: todaysDate, workouts: []))

            let calendarArrayData = try! JSONEncoder().encode(calendarArray)
            defaults.set(calendarArrayData, forKey: "calendarArray")
        }

        // all other times
        calendarArray = try! JSONDecoder().decode([CalendarWorkout].self, from: defaults.data(forKey: "calendarArray")!)

        // settings button, right nav bar
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Settings icon/Settings"), for: UIControlState.normal)
        button.isUserInteractionEnabled = true
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(self.settingsButton), for: .touchUpInside)
        let item = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = item

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
        return calendarArray[section].date
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.thin)
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64.0
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return calendarArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calendarArray[section].workouts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let workout = calendarArray[indexPath.section].workouts[indexPath.row]

        // cell text
        cell.textLabel?.text = workout.getWorkoutName()
        cell.textLabel?.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.thin)

        // image
        let image: UIImage = UIImage(named: "Body Parts icons/" + workout.getBodyPart())!
        cell.imageView?.image = image

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        calendarIndexTracker = indexPath.row
        calendarSectionTracker = indexPath.section
    }

    // delete swipe
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            // delete alert
            let alert = UIAlertController(title: "Are you sure you want to delete \"" + calendarArray[indexPath.section].workouts[indexPath.row].getWorkoutName() + "\"?", message: "This cannot be undone.", preferredStyle: UIAlertControllerStyle.alert)

            // OK option
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in

                let workout = calendarArray[indexPath.section].workouts[indexPath.row]

                // find the workout in bodyparts and unmark it
                for bodypart in bodyParts {
                    for worko in bodypart.getWorkouts() {
                        if (worko == workout) {
                            worko.markWorkoutUndone()
                        }
                    }
                }
                let bodyPartsData = try! JSONEncoder().encode(bodyParts)
                defaults.set(bodyPartsData, forKey: "bodyParts")

                // remove from calendar
                calendarArray[indexPath.section].workouts.remove(at: indexPath.row)

                // defaults
                let calendarArrayData = try! JSONEncoder().encode(calendarArray)
                defaults.set(calendarArrayData, forKey: "calendarArray")

                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }))

            // cancel option
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                // do nothing
            }))

            self.present(alert, animated: true, completion: nil)
        }
    }

    @objc func settingsButton() {

        // access view through storyboard id
        let settings = storyboard?.instantiateViewController(withIdentifier: "Settings")
        self.navigationController?.pushViewController(settings!, animated: true)
    }

    @objc func loadList() {
        loadListHelper(vc: self)
    }
}
