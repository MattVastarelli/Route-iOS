//
//  RoutePost.swift
//  Route-iOS
//
//  Created by Vastarelli, Matthew P on 2/11/19.
//  Copyright © 2019 Vastarelli, Matthew P. All rights reserved.
//

import Foundation

class RoutePost: Post {
    // this class models a postiting of a route
    // by adding the route object
    private var routeOfPost: Route
    
    //----------------------------------------------------------------
    init(author: User, title: String, body: String, route: Route) {
        self.routeOfPost = route
        
        // super cass init
        super.init(author: author, title: title, body: body)
    }
    //-----------------------------------------------------------------
    // Route Getter
    func getRoute() -> Route {
        return self.routeOfPost
    }
    
    // Route Setter
    func setRoute(route: Route) {
        self.routeOfPost = route
    }
}
