//
//  BodyPart.swift
//  Vigor
//
//  Created by Jason Shu on 6/24/18.
//  Copyright © 2018 Jason Shu. All rights reserved.
//

import Foundation
import UIKit

class BodyPart: NSObject, Codable {
    static func == (lhs: BodyPart, rhs: BodyPart) -> Bool {
        return (lhs.getBodyPartName() == rhs.getBodyPartName()) && lhs.getWorkouts() == rhs.getWorkouts()
    }
    
    var workouts: [Workout]
    var stretches: [Workout]
    
    // the only point of this is to retrieve the image
    var name: String
    
    override init() {
        workouts = []
        stretches = []
        name = ""
        
    }
    
    init(name: String, workouts: [Workout], stretches: [Workout]) {
        self.name = name
        self.workouts = workouts
        self.stretches = stretches
    }
    
    // getters
    func getBodyPartName() -> String {
        return name
    }
    
    func getWorkouts() -> [Workout] {
        return workouts
    }
    
    func getStretches() -> [Workout] {
        return stretches
    }
    
    func appendWorkoutToWorkouts(workout: Workout) {
        workouts.append(workout)
    }
    
    func removeWorkoutFromWorkouts(workout: Workout) {
        if workouts.contains(workout) {
            workouts.remove(at: workouts.index(of: workout)!)
        }
    }
}
