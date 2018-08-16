
//
//  AddWorkoutToTodayHelper.swift
//  Vigor
//
//  Created by Jason Shu on 6/22/18.
//  Copyright © 2018 Jason Shu. All rights reserved.
//

import Foundation
import UIKit

func addWorkoutToTodayHelper(workout: Workout, tabBar: UITabBarController, viewController: UITableViewController, nav: UINavigationController) {

    let alert = UIAlertController(title: "Do \"" + workout.getWorkoutName() + "\"?", message: "This workout will be added to Today's workout.", preferredStyle: UIAlertControllerStyle.alert)

    // OK option
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
        
        // deep copy
        todayWorkouts.append(Workout(that: workout))

        let todayWorkoutsData = try! JSONEncoder().encode(todayWorkouts)
        defaults.set(todayWorkoutsData, forKey: "todayWorkouts")
        
        // animate to Today tab
        //animateTabBarChange(tabBarController: tabBar, to: tabBar.viewControllers![1])
        //tabBar.selectedIndex = 1
        
        // reload table
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        
        nav.popViewController(animated: true)
    }))

    // cancel option
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
        // do nothing
    }))

    // present the options
    viewController.present(alert, animated: true, completion: nil)
}
