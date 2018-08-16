//
//  SaveCustomWorkoutToToday.swift
//  Vigor
//
//  Created by Jason Shu on 7/2/18.
//  Copyright © 2018 Jason Shu. All rights reserved.
//

import Foundation
import UIKit

func saveCustomWorkoutHelper(workout: Workout, tabBar: UITabBarController, viewController: UITableViewController, nav: UINavigationController) {

    let alert = UIAlertController(title: "Save \"" + workout.getWorkoutName() + "\"?", message: "This workout will be saved to Custom Workouts.", preferredStyle: UIAlertControllerStyle.alert)

    // OK option
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in

        // save custom workout
        // deep copy just in case
        bodyParts[bodyPartIndexTracker].appendWorkoutToWorkouts(workout: Workout(that: workout))

        // defaults
        let bodyPartsData = try! JSONEncoder().encode(bodyParts)
        defaults.set(bodyPartsData, forKey: "bodyParts")

        // pop back to custom workouts
        nav.popViewController(animated: false)
        nav.popViewController(animated: false)
        nav.popViewController(animated: true)
        
        // reload table
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
    }))

    // cancel option
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
        // do nothing
    }))

    // present the options
    viewController.present(alert, animated: true, completion: nil)

}
