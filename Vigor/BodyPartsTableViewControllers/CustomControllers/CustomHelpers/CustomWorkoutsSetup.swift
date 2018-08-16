//
//  CustomWorkoutsSetup.swift
//  Vigor
//
//  Created by Jason Shu on 6/29/18.
//  Copyright © 2018 Jason Shu. All rights reserved.
//

import Foundation
import UIKit

import Alamofire
import SwiftSoup

// not including neck, abductor, and adductor exercises

var customExercises = [[[Exercise]]]()

// arms 0, back 1, chest 2, core 3, legs 4, ply 5, shoulders 6
// foremarms [0][1]

func customExercisesSetup() {
    // arms 0-2
    var armsCustom = [[Exercise]]()
    armsCustom.append(parseHTMLFileIntoExercises(file: "forearms"))
    armsCustom.append(parseHTMLFileIntoExercises(file: "triceps"))
    armsCustom.append(parseHTMLFileIntoExercises(file: "biceps"))

    customExercises.append(armsCustom)

    // back 3-6
    var backCustom = [[Exercise]]()
    backCustom.append(parseHTMLFileIntoExercises(file: "lats"))
    backCustom.append(parseHTMLFileIntoExercises(file: "middleback"))
    backCustom.append(parseHTMLFileIntoExercises(file: "lowerback"))
    backCustom.append(parseHTMLFileIntoExercises(file: "traps"))

    customExercises.append(backCustom)

    // chest 7
    var chestCustom = [[Exercise]]()
    chestCustom.append(parseHTMLFileIntoExercises(file: "chest"))
    customExercises.append(chestCustom)

    // core 8
    var coreCustom = [[Exercise]]()
    coreCustom.append(parseHTMLFileIntoExercises(file: "core"))
    customExercises.append(coreCustom)

    // legs 9-12
    var legsCustom = [[Exercise]]()
    legsCustom.append(parseHTMLFileIntoExercises(file: "quadriceps"))
    legsCustom.append(parseHTMLFileIntoExercises(file: "hamstrings"))
    legsCustom.append(parseHTMLFileIntoExercises(file: "calves"))
    legsCustom.append(parseHTMLFileIntoExercises(file: "glutes"))
    customExercises.append(legsCustom)

    // ply 13
    var plyCustom = [[Exercise]]()
    plyCustom.append(parseHTMLFileIntoExercises(file: "plyometrics"))
    customExercises.append(plyCustom)

    // shoulders 14
    var shouldersCustom = [[Exercise]]()
    shouldersCustom.append(parseHTMLFileIntoExercises(file: "shoulders"))
    customExercises.append(shouldersCustom)

    let customExercisesData = try! JSONEncoder().encode(customExercises)
    defaults.set(customExercisesData, forKey: "customExercises")

}

func parseHTMLFileIntoExercises(file: String) -> [Exercise] {
    var exercises = [Exercise]()

    let htmlFile = Bundle.main.path(forResource: file, ofType: "html")
    if let html = try? String(contentsOfFile: htmlFile!, encoding: String.Encoding.utf8) {
        do {
            let doc = try SwiftSoup.parse(html)
            for ref in try doc.select("h3.ExResult-resultsHeading") {

                let name = try ref.select("a").text()
                if name.contains("/") {
                    let imgName = name.replacingOccurrences(of: "/", with: ":")
                    
                    exercises.append(Exercise(name: name, images: [imgName + "1", imgName + "2"]))
                }

                else {
                    exercises.append(Exercise(name: name, images: [name + "1", name + "2"]))
                }
            }

        } catch Exception.Error(let message) {
            print(message)
        } catch {
            print("major error")
        }
    }

    exercises.sort { $0.getExerciseName() < $1.getExerciseName() }

    //images.sorted(by: { $0.fileID > $1.fileID })
    return exercises
}
