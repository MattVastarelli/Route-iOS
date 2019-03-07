//
//  RouteTrack.swift
//  Route-iOS
//
//  Created by matthew vastarelli on 3/6/19.
//  Copyright © 2019 Vastarelli, Matthew P. All rights reserved.
//

import UIKit

class RouteTrack: NSObject {
    var time = NSDate()
    var duration = 0
    var distance: Float = 0.0
    
     // list of locations - the route being tracked
    var locations = [Location]()
    
    // later a method to save to firebase
}
