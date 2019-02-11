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

enum RouteTrafficSpeed: String {
    case slow = "Slow"
    case fair = "Fair"
    case fast = "Fast"
}

class Route {
}
