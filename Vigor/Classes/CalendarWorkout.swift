//
//  CalendarWorkout.swift
//  Vigor
//
//  Created by Jason Shu on 6/22/18.
//  Copyright © 2018 Jason Shu. All rights reserved.
//

import Foundation
import UIKit

struct CalendarWorkout: Equatable, Codable {
    
    var date : String!
    var workouts : [Workout]!
    
    static func == (lhs: CalendarWorkout, rhs: CalendarWorkout) -> Bool {
        return (lhs.date == rhs.date) && (lhs.workouts == rhs.workouts)
    }
}
