//
//  BodyPartsTableViewController.swift
//  Vigor
//
//  Created by Jason Shu on 6/19/18.
//  Copyright © 2018 Jason Shu. All rights reserved.
//

import UIKit

// body parts contain default workouts
var bodyParts = [BodyPart]()

var bodyPartIndexTracker = 0

class BodyPartsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // title
        self.navigationItem.title = "Workouts"

        // remove extra cells
        tableView.tableFooterView = UIView()

        // first time
        if (defaults.object(forKey: "bodyParts") == nil || defaults.object(forKey: "customExercises") == nil) {
            defaultWorkoutsSetup()
            customExercisesSetup()
        }
        
        // all other times
        bodyParts = try! JSONDecoder().decode([BodyPart].self, from: defaults.data(forKey: "bodyParts")!)
        customExercises = try! JSONDecoder().decode([[[Exercise]]].self, from: defaults.data(forKey: "customExercises")!)
        
        // nav bar
        navigationItem.largeTitleDisplayMode = .always
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // table functions
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bodyParts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // workouts for each body part
        let bodyPart = bodyParts[indexPath.row]

        // Configure the cell...
        // text
        cell.textLabel?.text = bodyPart.getBodyPartName()
        cell.textLabel?.font = UIFont.systemFont(ofSize: 32, weight: UIFont.Weight.thin)

        // image
        let image: UIImage = UIImage(named: "Body Parts icons/" + bodyPart.getBodyPartName())!
        cell.imageView?.image = image

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        bodyPartIndexTracker = indexPath.row
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
