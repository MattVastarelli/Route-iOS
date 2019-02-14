//
//  Route.swift
//  Route-iOS
//
//  Created by Vastarelli, Matthew P on 2/11/19.
//  Copyright © 2019 Vastarelli, Matthew P. All rights reserved.
//

import Foundation

// route types
enum RouteTerain: String {
    case trail = "Trail"
    case pavedRoad = "Paved Road"
    case unpavedRoad = "Unpaved Road"
    case path = "Path"
}
// route type
enum ActivityType: String {
    case run = "Run"
    case bike = "Bike"
    case walk = "Walk"
}
// route attributes
enum RouteAttributes: String {
    case potHoles = "Pot Holes"
    case groomed = "Well Groomed Trail"
    case crosswalk = "Crosswalks Available"
    case wellLit = "Good Lighting"
    case poorlyLit = "Poor Lighting"
    case noLineOfSight = "Poor Lines of Sight"
    case goodLineOfSight = "Good Lines of Sight"
    case blindCorner = "Blind Corners"
}
// traffic speed
enum RouteTrafficSpeed: String {
    case slow = "Slow"
    case fair = "Fair"
    case fast = "Fast"
}
// location type
enum RouteLocationType: String {
    case city = "Urban"
    case rural = "Rural"
    case suburban = "Suburban"
    case park = "Park"
}

// route class
class Route {
    private var terain: String
    private var locationType: String
    private var trafficSpeed: String
    private var activityType: String
    private var attributes: [String]
    //---------------------------------------------------------------------------------
    init(terain: String, locationType: String, trafficSpeed: String, activityType: String, attributes: [String]) {
        self.terain = terain
        self.locationType = locationType
        self.trafficSpeed = trafficSpeed
        self.activityType = activityType
        self.attributes = attributes
    }
    //---------------------------------------------------------------------------------
    // route getters
    func getTerain() -> String {
        return self.terain
    }
    
    func getLocationType() -> String {
        return self.locationType
    }
    
    func getTrafficSpeed() -> String {
        return self.trafficSpeed
    }
    
    func getActivityType() -> String {
        return self.activityType
    }
    
    func getAttributes() -> [String] {
        return self.attributes
    }
    // route setters
    func setTerain(terain: String) {
        self.terain = terain
    }
    
    func setLocationType(loc: String) {
        self.locationType = loc
    }
    
    func setTrafficSpeed(speed: String) {
        self.trafficSpeed = speed
    }
    
    func setActivityType(type: String) {
        self.activityType = type
    }
    
    func setAttributes(attr: [String]) {
        self.attributes = attr
    }
}
