//
//  Exercise.swift
//  Vigor
//
//  Created by Jason Shu on 6/19/18.
//  Copyright © 2018 Jason Shu. All rights reserved.
//

import Foundation
import UIKit

class Exercise: NSObject, Codable, NSCopying {

    var name: String
    var sets: String
    var reps: String // hyphen in between
    var images: [String]

    // determined by user
    var weight = ""

    // done/green cells
    var done: Bool
    
    override init() {
        name = ""
        sets = ""
        reps = "" // hyphen in between
        images = [""]
        done = false
    }
    
    // constructor
    init (name: String, sets: String, reps: String, images: [String], done: Bool) {
        self.name = name
        self.sets = sets
        self.reps = reps
        self.images = images
        self.done = false
    }
    
    // custom constructor
    init (name: String, images: [String]) {
        self.name = name
        self.sets = ""
        self.reps = ""
        self.images = images
        self.done = false
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Exercise(name: name, sets: sets, reps: reps, images: images, done: done)
        return copy
    }

    // getters
    func getExerciseName() -> String {
        return name
    }

    func getSetsAndReps() -> String {
        return String(sets) + " x " + reps + " reps"
    }

    func getImages() -> [String] {
        return images
    }

    func getWeight() -> String {
        return weight
    }
    
    func getSets() -> String{
        return sets
    }
    
    func getReps() -> String{
        return reps
    }

    // setters
    func setSets(sets: String) {
        self.sets = sets
    }

    func setReps(reps: String) {
        self.reps = reps
    }

    func setWeight(weight: String) {
        self.weight = weight
    }

    func markExerciseDone() {
        done = true
    }

    func markExerciseUndone() {
        done = false
    }

}

