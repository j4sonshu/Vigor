//
//  BodyPartExerciseDetailTableViewController.swift
//  Vigor
//
//  Created by Jason Shu on 6/20/18.
//  Copyright © 2018 Jason Shu. All rights reserved.
//

import UIKit

var bodyPartExerciseDetailImageIndexTracker = 0

class BodyPartExerciseDetailTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // remove extra cells
        tableView.tableFooterView = UIView()

        // title
        if bodyPartWorkoutSectionTracker == 0 {
            self.title = bodyParts[bodyPartIndexTracker].getWorkouts()[bodyPartWorkoutIndexTracker].getExercises()[bodyPartExerciseIndexTracker].getExerciseName()
        }
        if bodyPartWorkoutSectionTracker == 1 {
            self.title = bodyParts[bodyPartIndexTracker].getStretches()[bodyPartWorkoutIndexTracker].getExercises()[bodyPartExerciseIndexTracker].getExerciseName()
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
        if bodyPartWorkoutSectionTracker == 0 {
            return bodyParts[bodyPartIndexTracker].getWorkouts()[bodyPartWorkoutIndexTracker].getExercises()[bodyPartExerciseIndexTracker].getImages().count
        }
        // stretches
        return bodyParts[bodyPartIndexTracker].getStretches()[bodyPartWorkoutIndexTracker].getExercises()[bodyPartExerciseIndexTracker].getImages().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // reference to individual exercise in list of [Exercise]
        // temp var
        var exercise = Exercise()

        if bodyPartWorkoutSectionTracker == 0 {
            exercise = bodyParts[bodyPartIndexTracker].getWorkouts()[bodyPartWorkoutIndexTracker].getExercises()[bodyPartExerciseIndexTracker]
        }
        else {
            exercise = bodyParts[bodyPartIndexTracker].getStretches()[bodyPartWorkoutIndexTracker].getExercises()[bodyPartExerciseIndexTracker]
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

        if bodyPartWorkoutSectionTracker == 0 {
            image = UIImage(named: "Exercises/" + bodyParts[bodyPartIndexTracker].getWorkouts()[bodyPartWorkoutIndexTracker].getExercises()[bodyPartExerciseIndexTracker].getImages()[indexPath.row])!
        }
        else {
            image = UIImage(named: "Exercises/" + bodyParts[bodyPartIndexTracker].getStretches()[bodyPartWorkoutIndexTracker].getExercises()[bodyPartExerciseIndexTracker].getImages()[indexPath.row])!
        }

        let imageCrop = image.getCropRatio()
        return tableView.frame.width / imageCrop

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        bodyPartExerciseDetailImageIndexTracker = indexPath.row
    }


    @objc func imageTapped(_ recognizer: UITapGestureRecognizer) {

        // access view through storyboard id
        bodyPartExerciseDetailImageIndexTracker = recognizer.view!.tag

        if bodyPartWorkoutSectionTracker == 0 {
            currentImageDetail = UIImage(named: "Exercises/" + bodyParts[bodyPartIndexTracker].getWorkouts()[bodyPartWorkoutIndexTracker].getExercises()[bodyPartExerciseIndexTracker].getImages()[bodyPartExerciseDetailImageIndexTracker])!
        }

        else {
            currentImageDetail = UIImage(named: "Exercises/" + bodyParts[bodyPartIndexTracker].getStretches()[bodyPartWorkoutIndexTracker].getExercises()[bodyPartExerciseIndexTracker].getImages()[bodyPartExerciseDetailImageIndexTracker])!
        }

        let imageView = storyboard?.instantiateViewController(withIdentifier: "ExerciseDetailImage")
        self.navigationController?.pushViewController(imageView!, animated: true)
    }

}
