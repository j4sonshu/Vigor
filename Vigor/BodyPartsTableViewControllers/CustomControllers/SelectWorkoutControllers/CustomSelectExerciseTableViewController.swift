//
//  CustomSelectExerciseTableViewController.swift
//  Vigor
//
//  Created by Jason Shu on 7/5/18.
//  Copyright © 2018 Jason Shu. All rights reserved.
//

import UIKit

var customSelectExerciseDetailImageIndexTracker = 0

class CustomSelectExerciseTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // remove extra cells
        tableView.tableFooterView = UIView()

        // title
        switch selectedWorkout.getBodyPart() {
        case "Arms":
            self.title = customExercises[0][customSelectExerciseSectionTracker][customSelectExerciseIndexTracker].getExerciseName()
        case "Back":
            self.title = customExercises[1][customSelectExerciseSectionTracker][customSelectExerciseIndexTracker].getExerciseName()
        case "Chest":
            self.title = customExercises[2][customSelectExerciseSectionTracker][customSelectExerciseIndexTracker].getExerciseName()
        case "Core":
            self.title = customExercises[3][customSelectExerciseSectionTracker][customSelectExerciseIndexTracker].getExerciseName()
        case "Legs":
            self.title = customExercises[4][customSelectExerciseSectionTracker][customSelectExerciseIndexTracker].getExerciseName()
        case "Plyometrics":
            self.title = customExercises[5][customSelectExerciseSectionTracker][customSelectExerciseIndexTracker].getExerciseName()
        case "Shoulders":
            self.title = customExercises[6][customSelectExerciseSectionTracker][customSelectExerciseIndexTracker].getExerciseName()
        default:
            self.title = ""
        }

        // remove border lines
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none

        // nav bar
        navigationItem.largeTitleDisplayMode = .never

        // image cell
        self.tableView.register(ImageViewCell.self, forCellReuseIdentifier: "ImageViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // table methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // reference to individual exercise in list of [Exercise]
        var exercise = Exercise()

        // Configure the cell...
        switch selectedWorkout.getBodyPart() {
        case "Arms":
            exercise = customExercises[0][customSelectExerciseSectionTracker][customSelectExerciseIndexTracker]
        case "Back":
            exercise = customExercises[1][customSelectExerciseSectionTracker][customSelectExerciseIndexTracker]
        case "Chest":
            exercise = customExercises[2][customSelectExerciseSectionTracker][customSelectExerciseIndexTracker]
        case "Core":
            exercise = customExercises[3][customSelectExerciseSectionTracker][customSelectExerciseIndexTracker]
        case "Legs":
            exercise = customExercises[4][customSelectExerciseSectionTracker][customSelectExerciseIndexTracker]
        case "Plyometrics":
            exercise = customExercises[5][customSelectExerciseSectionTracker][customSelectExerciseIndexTracker]
        case "Shoulders":
            exercise = customExercises[6][customSelectExerciseSectionTracker][customSelectExerciseIndexTracker]
        default:
            exercise = Exercise()
        }

        // image cell
        let imageCell = tableView.dequeueReusableCell(withIdentifier: "ImageViewCell") as! ImageViewCell
        // untappable cells
        imageCell.selectionStyle = UITableViewCellSelectionStyle.default

        // images
        let image = UIImage(named: "Exercises/" + exercise.getImages()[indexPath.row])
        imageCell.mainImageView.image = image

        // tap recognizer
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(_:)))
        tap.numberOfTapsRequired = 1
        imageCell.addGestureRecognizer(tap)
        imageCell.tag = indexPath.row

        return imageCell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        // image
        var image = UIImage()

        switch selectedWorkout.getBodyPart() {
        case "Arms":
            image = UIImage(named: "Exercises/" + customExercises[0][customSelectExerciseSectionTracker][customSelectExerciseIndexTracker].getImages()[indexPath.row])!
        case "Back":
            image = UIImage(named: "Exercises/" + customExercises[1][customSelectExerciseSectionTracker][customSelectExerciseIndexTracker].getImages()[indexPath.row])!
        case "Chest":
            image = UIImage(named: "Exercises/" + customExercises[2][customSelectExerciseSectionTracker][customSelectExerciseIndexTracker].getImages()[indexPath.row])!
        case "Core":
            image = UIImage(named: "Exercises/" + customExercises[3][customSelectExerciseSectionTracker][customSelectExerciseIndexTracker].getImages()[indexPath.row])!
        case "Legs":
            image = UIImage(named: "Exercises/" + customExercises[4][customSelectExerciseSectionTracker][customSelectExerciseIndexTracker].getImages()[indexPath.row])!
        case "Plyometrics":
            image = UIImage(named: "Exercises/" + customExercises[5][customSelectExerciseSectionTracker][customSelectExerciseIndexTracker].getImages()[indexPath.row])!
        case "Shoulders":
            image = UIImage(named: "Exercises/" + customExercises[6][customSelectExerciseSectionTracker][customSelectExerciseIndexTracker].getImages()[indexPath.row])!
        default:
            image = UIImage()
        }

        let imageCrop = image.getCropRatio()
        return tableView.frame.width / imageCrop
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        customSelectExerciseDetailImageIndexTracker = indexPath.row
    }

    @objc func imageTapped(_ recognizer: UITapGestureRecognizer) {

        // access view through storyboard id
        customSelectExerciseDetailImageIndexTracker = recognizer.view!.tag

        switch selectedWorkout.getBodyPart() {
        case "Arms":
            currentImageDetail = UIImage(named: "Exercises/" + customExercises[0][customSelectExerciseSectionTracker][customSelectExerciseIndexTracker].getImages()[customSelectExerciseDetailImageIndexTracker])!
        case "Back":
            currentImageDetail = UIImage(named: "Exercises/" + customExercises[1][customSelectExerciseSectionTracker][customSelectExerciseIndexTracker].getImages()[customSelectExerciseDetailImageIndexTracker])!
        case "Chest":
            currentImageDetail = UIImage(named: "Exercises/" + customExercises[2][customSelectExerciseSectionTracker][customSelectExerciseIndexTracker].getImages()[customSelectExerciseDetailImageIndexTracker])!
        case "Core":
            currentImageDetail = UIImage(named: "Exercises/" + customExercises[3][customSelectExerciseSectionTracker][customSelectExerciseIndexTracker].getImages()[customSelectExerciseDetailImageIndexTracker])!
        case "Legs":
            currentImageDetail = UIImage(named: "Exercises/" + customExercises[4][customSelectExerciseSectionTracker][customSelectExerciseIndexTracker].getImages()[customSelectExerciseDetailImageIndexTracker])!
        case "Plyometrics":
            currentImageDetail = UIImage(named: "Exercises/" + customExercises[5][customSelectExerciseSectionTracker][customSelectExerciseIndexTracker].getImages()[customSelectExerciseDetailImageIndexTracker])!
        case "Shoulders":
            currentImageDetail = UIImage(named: "Exercises/" + customExercises[6][customSelectExerciseSectionTracker][customSelectExerciseIndexTracker].getImages()[customSelectExerciseDetailImageIndexTracker])!
        default:
            currentImageDetail = UIImage()
        }

        let imageView = storyboard?.instantiateViewController(withIdentifier: "ExerciseDetailImage")
        self.navigationController?.pushViewController(imageView!, animated: true)
    }

}
