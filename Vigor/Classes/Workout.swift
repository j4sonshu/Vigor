//
//  Workout.swift
//  Vigor
//
//  Created by Jason Shu on 6/19/18.
//  Copyright © 2018 Jason Shu. All rights reserved.
//

import Foundation
import UIKit

class Workout: NSObject, Codable {
    
    static func == (lhs: Workout, rhs: Workout) -> Bool {
        return (lhs.name == rhs.name) && (lhs.bodyPart == rhs.bodyPart)
    }

    var name: String
    var bodyPart: String
    
    var workoutDoneBefore: Bool

    // workouts are a list of exercises
    var exercises = [Exercise]()

    // constructor
    override init () {
        name = ""
        exercises = []
        bodyPart = ""
        workoutDoneBefore = false
    }

    init (name: String, bodyPart: String, exercises: [Exercise], workoutDoneBefore: Bool) {
        self.name = name
        self.bodyPart = bodyPart
        self.exercises = exercises
        self.workoutDoneBefore = false
    }    
    
    init (that: Workout) {
        self.name = that.name
        self.bodyPart = that.bodyPart
        self.workoutDoneBefore = that.workoutDoneBefore
        
        // deep copy exercises
        for ex in that.exercises {
            self.exercises.append(ex.copy() as! Exercise)
        }
    }

    // getters
    func getFullWorkoutName() -> String {
        return bodyPart + " - " + name
    }

    func getWorkoutName() -> String {
        return name
    }

    func getExercises() -> [Exercise] {
        return exercises
    }

    func getBodyPart() -> String {
        return bodyPart
    }
    
    func getWorkoutDoneBefore() -> Bool {
        return workoutDoneBefore
    }
    
    // setters
    func markWorkoutDone() {
        workoutDoneBefore = true
    }
    
    func markWorkoutUndone() {
        workoutDoneBefore = false
    }

    // clear
    func clearDoneExercises() {
        for ex in exercises {
            ex.done = false
        }
    }
    
    // checks
    func areWorkoutExercisesDone() -> Bool {
        for ex in exercises {
            if (ex.done == false) {
                return false
            }
        }
        return true
    }

}
