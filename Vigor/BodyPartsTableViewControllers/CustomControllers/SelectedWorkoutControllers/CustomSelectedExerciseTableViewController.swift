//
//  CustomSelectedExerciseTableViewController.swift
//  Vigor
//
//  Created by Jason Shu on 7/5/18.
//  Copyright © 2018 Jason Shu. All rights reserved.
//

import UIKit

var customSelectedExerciseDetailImageIndexTracker = 0

class CustomSelectedExerciseTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // remove extra cells
        tableView.tableFooterView = UIView()

        // title
        self.title = selectedExercises[customSelectedExerciseIndexTracker].getExerciseName()

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
        let exercise = selectedExercises[customSelectedExerciseIndexTracker]

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
        let image = UIImage(named: "Exercises/" + selectedExercises[customSelectedExerciseIndexTracker].getImages()[indexPath.row])!

        let imageCrop = image.getCropRatio()
        return tableView.frame.width / imageCrop
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        customSelectedExerciseDetailImageIndexTracker = indexPath.row
    }

    @objc func imageTapped(_ recognizer: UITapGestureRecognizer) {

        // access view through storyboard id
        customSelectExerciseDetailImageIndexTracker = recognizer.view!.tag
        
        currentImageDetail = UIImage(named: "Exercises/" + selectedExercises[customSelectedExerciseIndexTracker].getImages()[customSelectExerciseDetailImageIndexTracker])!

        let imageView = storyboard?.instantiateViewController(withIdentifier: "ExerciseDetailImage")
        self.navigationController?.pushViewController(imageView!, animated: true)
    }

}
