//
//  TodayExerciseTableViewController.swift
//  Vigor
//
//  Created by Jason Shu on 6/21/18.
//  Copyright © 2018 Jason Shu. All rights reserved.
//

import UIKit

var todayExerciseDetailImageIndexTracker = 0

class TodayExerciseTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // remove extra cells
        tableView.tableFooterView = UIView()

        // title
        self.title = todayWorkouts[todayWorkoutsIndexTracker].getExercises()[todayExerciseIndexTracker].getExerciseName()

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
        // return 2
        return todayWorkouts[todayWorkoutsIndexTracker].getExercises()[todayExerciseIndexTracker].getImages().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let exercise = todayWorkouts[todayWorkoutsIndexTracker].getExercises()[todayExerciseIndexTracker]

        // Configure the cell...

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

        let image = UIImage(named: "Exercises/" + todayWorkouts[todayWorkoutsIndexTracker].getExercises()[todayExerciseIndexTracker].getImages()[indexPath.row])
        let imageCrop = image?.getCropRatio()
        return tableView.frame.width / imageCrop!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        todayExerciseDetailImageIndexTracker = indexPath.row
    }

    @objc func imageTapped(_ recognizer: UITapGestureRecognizer) {

        // access view through storyboard id
        todayExerciseDetailImageIndexTracker = recognizer.view!.tag

        currentImageDetail = UIImage(named: "Exercises/" + todayWorkouts[todayWorkoutsIndexTracker].getExercises()[todayExerciseIndexTracker].getImages()[todayExerciseDetailImageIndexTracker])!
        let imageView = storyboard?.instantiateViewController(withIdentifier: "ExerciseDetailImage")
        self.navigationController?.pushViewController(imageView!, animated: true)
    }

}
