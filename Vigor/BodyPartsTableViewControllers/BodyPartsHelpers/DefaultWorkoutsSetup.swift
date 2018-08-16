//
//  defaultWorkoutsSetup.swift
//  Vigor
//
//  Created by Jason Shu on 6/24/18.
//  Copyright © 2018 Jason Shu. All rights reserved.
//

import Foundation
import UIKit
import SwiftSoup

// user defaults
let defaults = UserDefaults.standard

func defaultWorkoutsSetup () {

    // alphabetical
    defaultArmsSetup()
    defaultBackSetup()
    defaultChestSetup()
    defaultCoreSetup()
    defaultLegsSetup()
    defaultPlySetup()
    defaultShouldersSetup()
    defaultYogaSetup()

    // custom
    bodyParts.append(BodyPart(name: "Custom", workouts: [Workout](), stretches: []))

    let bodyPartsData = try! JSONEncoder().encode(bodyParts)
    defaults.set(bodyPartsData, forKey: "bodyParts")
}

func defaultArmsSetup() {

    let armsDefaultWorkouts = parseHTMLFileIntoWorkout(file: "armsDefaults", bodyPart: "Arms")

    var stretches = [Workout]()
    let forearmsStretches = Workout(name: "Forearms Stretches", bodyPart: "Arms", exercises: parseHTMLFileIntoStretchExercises(file: "stretches", stretch: "Forearms"), workoutDoneBefore: false)
    let tricepsStretches = Workout(name: "Triceps Stretches", bodyPart: "Arms", exercises: parseHTMLFileIntoStretchExercises(file: "stretches", stretch: "Triceps"), workoutDoneBefore: false)
    let bicepsStretches = Workout(name: "Biceps Stretches", bodyPart: "Arms", exercises: parseHTMLFileIntoStretchExercises(file: "stretches", stretch: "Biceps"), workoutDoneBefore: false)
    stretches.append(forearmsStretches)
    stretches.append(tricepsStretches)
    stretches.append(bicepsStretches)

    bodyParts.append(BodyPart(name: "Arms", workouts: armsDefaultWorkouts, stretches: stretches))
}

func defaultBackSetup() {

    let backDefaultWorkouts = parseHTMLFileIntoWorkout(file: "backDefaults", bodyPart: "Back")

    var stretches = [Workout]()
    let latsStretches = Workout(name: "Lats Stretches", bodyPart: "Back", exercises: parseHTMLFileIntoStretchExercises(file: "stretches", stretch: "Lats"), workoutDoneBefore: false)
    let middlebackStretches = Workout(name: "Middle Back Stretches", bodyPart: "Back", exercises: parseHTMLFileIntoStretchExercises(file: "stretches", stretch: "Middle Back"), workoutDoneBefore: false)
    let lowerbackStretches = Workout(name: "Lower Back Stretches", bodyPart: "Back", exercises: parseHTMLFileIntoStretchExercises(file: "stretches", stretch: "Lower Back"), workoutDoneBefore: false)

    stretches.append(latsStretches)
    stretches.append(middlebackStretches)
    stretches.append(lowerbackStretches)

    bodyParts.append(BodyPart(name: "Back", workouts: backDefaultWorkouts, stretches: stretches))

}

func defaultChestSetup() {

    let chestDefaultWorkouts = parseHTMLFileIntoWorkout(file: "chestDefaults", bodyPart: "Chest")

    var stretches = [Workout]()
    let chestStretches = Workout(name: "Chest Stretches", bodyPart: "Chest", exercises: parseHTMLFileIntoStretchExercises(file: "stretches", stretch: "Chest"), workoutDoneBefore: false)

    stretches.append(chestStretches)

    bodyParts.append(BodyPart(name: "Chest", workouts: chestDefaultWorkouts, stretches: stretches))
}

func defaultCoreSetup() {

    let coreDefaultWorkouts = parseHTMLFileIntoWorkout(file: "coreDefaults", bodyPart: "Core")

    var stretches = [Workout]()
    let coreStretches = Workout(name: "Core Stretches", bodyPart: "Core", exercises: parseHTMLFileIntoStretchExercises(file: "stretches", stretch: "Abdominals"), workoutDoneBefore: false)

    stretches.append(coreStretches)

    bodyParts.append(BodyPart(name: "Core", workouts: coreDefaultWorkouts, stretches: stretches))
}

func defaultLegsSetup() {

    let legsDefaultWorkouts = parseHTMLFileIntoWorkout(file: "legsDefaults", bodyPart: "Legs")

    var stretches = [Workout]()
    let quadsStretches = Workout(name: "Quadriceps Stretches", bodyPart: "Legs", exercises: parseHTMLFileIntoStretchExercises(file: "stretches", stretch: "Quadriceps"), workoutDoneBefore: false)
    let hamStretches = Workout(name: "Hamstrings Stretches", bodyPart: "Legs", exercises: parseHTMLFileIntoStretchExercises(file: "stretches", stretch: "Hamstrings"), workoutDoneBefore: false)
    let calvesStretches = Workout(name: "Calves Stretches", bodyPart: "Legs", exercises: parseHTMLFileIntoStretchExercises(file: "stretches", stretch: "Calves"), workoutDoneBefore: false)
    let glutesStretches = Workout(name: "Glutes Stretches", bodyPart: "Legs", exercises: parseHTMLFileIntoStretchExercises(file: "stretches", stretch: "Glutes"), workoutDoneBefore: false)

    stretches.append(quadsStretches)
    stretches.append(hamStretches)
    stretches.append(calvesStretches)
    stretches.append(glutesStretches)

    bodyParts.append(BodyPart(name: "Legs", workouts: legsDefaultWorkouts, stretches: stretches))

}

func defaultPlySetup() {

    let plyDefaultWorkouts = parseHTMLFileIntoWorkout(file: "plyDefaults", bodyPart: "Plyometrics")

    bodyParts.append(BodyPart(name: "Plyometrics", workouts: plyDefaultWorkouts, stretches: []))
}

func defaultShouldersSetup() {

    let shouldersDefaultWorkouts = parseHTMLFileIntoWorkout(file: "shouldersDefaults", bodyPart: "Shoulders")

    var stretches = [Workout]()
    let shouldersStretches = Workout(name: "Shoulders Stretches", bodyPart: "Shoulders", exercises: parseHTMLFileIntoStretchExercises(file: "stretches", stretch: "Shoulders"), workoutDoneBefore: false)
    let neckStretches = Workout(name: "Neck Stretches", bodyPart: "Shoulders", exercises: parseHTMLFileIntoStretchExercises(file: "stretches", stretch: "Neck"), workoutDoneBefore: false)

    stretches.append(shouldersStretches)
    stretches.append(neckStretches)

    bodyParts.append(BodyPart(name: "Shoulders", workouts: shouldersDefaultWorkouts, stretches: stretches))
}

func defaultYogaSetup() {

    var yogaDefaultWorkouts = [Workout]()

    let coreYoga = Workout(name: "Core Poses", bodyPart: "Yoga", exercises: parseHTMLFileIntoYogaExercises(file: "coreYoga"), workoutDoneBefore: false)
    let seatedYoga = Workout(name: "Seated Poses", bodyPart: "Yoga", exercises: parseHTMLFileIntoYogaExercises(file: "seatedYoga"), workoutDoneBefore: false)
    let standingYoga = Workout(name: "Standing Poses", bodyPart: "Yoga", exercises: parseHTMLFileIntoYogaExercises(file: "standingYoga"), workoutDoneBefore: false)
    let twistYoga = Workout(name: "Twist Poses", bodyPart: "Yoga", exercises: parseHTMLFileIntoYogaExercises(file: "twistYoga"), workoutDoneBefore: false)

    yogaDefaultWorkouts.append(coreYoga)
    yogaDefaultWorkouts.append(seatedYoga)
    yogaDefaultWorkouts.append(standingYoga)
    yogaDefaultWorkouts.append(twistYoga)

    bodyParts.append(BodyPart(name: "Yoga", workouts: yogaDefaultWorkouts, stretches: []))
}

func parseHTMLFileIntoYogaExercises(file: String) -> [Exercise] {

    var exercises = [Exercise]()

    let htmlFile = Bundle.main.path(forResource: file, ofType: "html")
    if let html = try? String(contentsOfFile: htmlFile!, encoding: String.Encoding.utf8) {
        do {
            let doc = try SwiftSoup.parse(html)

            for ref in try doc.select("h2.m-card--header-text") {
                let name = try ref.text()
                let exercise = Exercise(name: name, images: [name])
                exercises.append(exercise)
            }

        } catch Exception.Error(let message) {
            print(message)
        } catch {
            print("major error")
        }
    }
    return exercises
}

func parseHTMLFileIntoStretchExercises(file: String, stretch: String) -> [Exercise] {
    var exercises = [Exercise]()

    let htmlFile = Bundle.main.path(forResource: file, ofType: "html")
    if let html = try? String(contentsOfFile: htmlFile!, encoding: String.Encoding.utf8) {
        do {
            let doc = try SwiftSoup.parse(html)

            for cell in try doc.select("div.ExResult-cell--nameEtc") {
                if try cell.select("div.ExResult-muscleTargeted").select("a").text() == stretch {

                    let name = try cell.select("h3.ExResult-resultsHeading").select("a").text()
                    
                    if name.contains("/") {
                        let imgName = name.replacingOccurrences(of: "/", with: ":")
                        exercises.append(Exercise(name: name, images: [imgName + "1", imgName + "2"]))
                    }
                        
                    else {
                        exercises.append(Exercise(name: name, images: [name + "1", name + "2"]))
                    }
                }
            }

        } catch Exception.Error(let message) {
            print(message)
        } catch {
            print("major error")
        }
    }
    return exercises
}

func parseHTMLFileIntoWorkout(file: String, bodyPart: String) -> [Workout] {

    var defaultWorkouts = [Workout]()

    let htmlFile = Bundle.main.path(forResource: file, ofType: "html")
    if let html = try? String(contentsOfFile: htmlFile!, encoding: String.Encoding.utf8) {
        do {
            let doc = try SwiftSoup.parse(html)

            for def in try doc.select("div.cms-article-list__segment") {

                var exercises = [Exercise]()

                let workoutName = try def.select("div.cms-article-list__title").text()

                for ex in try def.select("div.cms-article-list__content") {

                    let exerciseName = try ex.select("div.cms-article-workout__exercise--info").select("a").text()

                    let setsReps = try ex.select("div.cms-article-workout__sets--definition").select("span").text()

                    let sets = setsReps.substring(from: 0, toSubstring: " s") // sets
                    let reps = setsReps.substring(from: 8, toSubstring: " r") // reps
                    
                    let exercise = Exercise(name: exerciseName, sets: String(sets!), reps: String(reps!), images: [exerciseName + "1", exerciseName + "2"], done: false)
                    exercises.append(exercise)
                }

                defaultWorkouts.append(Workout(name: workoutName, bodyPart: bodyPart, exercises: exercises, workoutDoneBefore: false))
            }

        } catch Exception.Error(let message) {
            print(message)
        } catch {
            print("major error")
        }
    }

    return defaultWorkouts
}

extension String {
    func substring(from: Int, toSubstring s2: String) -> Substring? {
        guard let r = self.range(of: s2) else { return nil }
        var s = self.prefix(upTo: r.lowerBound)
        s = s.dropFirst(from)
        return s
    }
}
