//
//  TodayHelperFunctions.swift
//  Vigor
//
//  Created by Jason Shu on 6/26/18.
//  Copyright © 2018 Jason Shu. All rights reserved.
//

import Foundation
import UIKit

func searchAndSetSets(workout: Workout, exercise: Exercise, sets: String) {

    for bodypart in bodyParts {
        for worko in bodypart.getWorkouts() {
            if (worko == workout) {
                for ex in worko.getExercises() {
                    if (ex.getExerciseName() == exercise.getExerciseName()) {
                        ex.setSets(sets: sets)
                    }
                }
            }
        }
        for worko in bodypart.getStretches() {
            if (worko == workout) {
                for ex in worko.getExercises() {
                    if (ex.getExerciseName() == exercise.getExerciseName()) {
                        ex.setSets(sets: sets)
                    }
                }
            }
        }
    }

    // defaults
    let bodyPartsData = try! JSONEncoder().encode(bodyParts)
    defaults.set(bodyPartsData, forKey: "bodyParts")

    let todayWorkoutsData = try! JSONEncoder().encode(todayWorkouts)
    defaults.set(todayWorkoutsData, forKey: "todayWorkouts")

}

func searchAndSetReps(workout: Workout, exercise: Exercise, reps: String) {

    for bodypart in bodyParts {
        for worko in bodypart.getWorkouts() {
            if (worko == workout) {
                for ex in worko.getExercises() {
                    if (ex.getExerciseName() == exercise.getExerciseName()) {
                        ex.setReps(reps: reps)
                    }
                }
            }
        }
        for worko in bodypart.getStretches() {
            if (worko == workout) {
                for ex in worko.getExercises() {
                    if (ex.getExerciseName() == exercise.getExerciseName()) {
                        ex.setReps(reps: reps)
                    }
                }
            }
        }
    }

    // defaults
    let bodyPartsData = try! JSONEncoder().encode(bodyParts)
    defaults.set(bodyPartsData, forKey: "bodyParts")

    let todayWorkoutsData = try! JSONEncoder().encode(todayWorkouts)
    defaults.set(todayWorkoutsData, forKey: "todayWorkouts")
}

func searchAndSetWeight(workout: Workout, exercise: Exercise, weight: String) {

    for bodypart in bodyParts {
        for worko in bodypart.getWorkouts() {
            if (worko == workout) {
                for ex in worko.getExercises() {
                    if (ex.getExerciseName() == exercise.getExerciseName()) {
                        ex.setWeight(weight: weight)
                    }
                }
            }
        }
        for worko in bodypart.getStretches() {
            if (worko == workout) {
                for ex in worko.getExercises() {
                    if (ex.getExerciseName() == exercise.getExerciseName()) {
                        ex.setWeight(weight: weight)
                    }
                }
            }
        }
    }

    // defaults
    let bodyPartsData = try! JSONEncoder().encode(bodyParts)
    defaults.set(bodyPartsData, forKey: "bodyParts")

    let todayWorkoutsData = try! JSONEncoder().encode(todayWorkouts)
    defaults.set(todayWorkoutsData, forKey: "todayWorkouts")
}

// extensions for header view
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}

extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

        return ceil(boundingBox.width)
    }
}
