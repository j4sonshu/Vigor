//
//  AddTodayWorkoutToCalendar.swift
//  Vigor
//
//  Created by Jason Shu on 7/6/18.
//  Copyright © 2018 Jason Shu. All rights reserved.
//

import Foundation
import UIKit

func addTodayWorkoutToCalendarHelper(workout: Workout, exercise: Exercise, todaysDate: String, tabBar: UITabBarController, viewController: UITableViewController, nav: UINavigationController) {

    // exercise parameter is solely for when user presses cancel, meaning that "finished" the workout by accident, nothing to do with button
    var alert = UIAlertController()

    // all workouts done
    if (workout.areWorkoutExercisesDone() == true) {
        // alert to add to calendar
        alert = UIAlertController(title: "Finished \"" + workout.getFullWorkoutName() + "\"?", message: "", preferredStyle: UIAlertControllerStyle.alert)
    }

    else {
        // unfinished workout
        alert = UIAlertController(title: "Finish \"" + workout.getFullWorkoutName() + "\"?", message: "Are you sure?\nThis workout is still not finished.", preferredStyle: UIAlertControllerStyle.alert)
    }

    // OK option
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in

        // this means unfinished workouts are also going to be marked done...should be fine
        
        // find the workout in bodyparts and mark the workout as done
        for bodypart in bodyParts {
            for worko in bodypart.getWorkouts() {
                if (worko == workout) {
                    worko.markWorkoutDone()
                }
            }
            for worko in bodypart.getStretches() {
                if (worko == workout) {
                    worko.markWorkoutDone()
                }
            }
        }

        let bodyPartsData = try! JSONEncoder().encode(bodyParts)
        defaults.set(bodyPartsData, forKey: "bodyParts")

        // add workout to progress calendar array
        let toAdd = CalendarWorkout(date: todaysDate, workouts: [workout])

        var dates = [String]()
        for obj in calendarArray {
            dates.append(obj.date)
        }

        // if no such date exists yet, append it
        if dates.contains(todaysDate) == false {
            calendarArray.insert(toAdd, at: 0)
        }

        if dates.contains(todaysDate) == true {
            for obj in calendarArray {
                if obj.date == toAdd.date {
                    let index = calendarArray.index(of: obj)
                    calendarArray[index!].workouts.append(workout)
                }
            }
        }

        // defaults for progress calendar
        let calendarArrayData = try! JSONEncoder().encode(calendarArray)
        defaults.set(calendarArrayData, forKey: "calendarArray")

        // remove the workout from todayand set defaults for todayWorkouts
        todayWorkouts.remove(at: todayWorkouts.index(of: workout)!)

        let todayWorkoutsData = try! JSONEncoder().encode(todayWorkouts)
        defaults.set(todayWorkoutsData, forKey: "todayWorkouts")

        if todayWorkouts.count == 0 {
            // animate transition
            animateTabBarChange(tabBarController: tabBar, to: tabBar.viewControllers![2])
            viewController.tabBarController?.selectedIndex = 2
            nav.popViewController(animated: false)
        }

        else {
            nav.popViewController(animated: true)
        }
        
        // reload table
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)

    }))

    // cancel option
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
        // undo last green if accidentally finished all
        if (workout.areWorkoutExercisesDone() == true) {
            exercise.markExerciseUndone()
        }

        let todayWorkoutsData = try! JSONEncoder().encode(todayWorkouts)
        defaults.set(todayWorkoutsData, forKey: "todayWorkouts")

        viewController.tableView.reloadData()
    }))
    viewController.present(alert, animated: true, completion: nil)
}
