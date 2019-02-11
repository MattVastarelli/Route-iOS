//
//  Post.swift
//  Route-iOS
//
//  Created by Vastarelli, Matthew P on 2/11/19.
//  Copyright © 2019 Vastarelli, Matthew P. All rights reserved.
//

import Foundation

class Post {
    private var author: User
    private var title: String
    private var postBody: String
    private var routeOfPost: Route
    
    //Initializer
    init(author: User, title: String, body: String, route: Route) {
        self.author = author
        self.title = title
        self.postBody = body
        self.routeOfPost = route
    }
    //----------------------------------------------------------------
    // Post Getters
    func getAuthor() -> User {
        return self.author
    }
    
    func getTitle() -> String {
        return self.title
    }
    
    func getPostBody() -> String {
        return self.postBody
    }
    
    func getRouteOfPost() -> Route {
        return self.routeOfPost
    }
    
    // Post Setters
    func setTitle(title: String) {
        self.title = title
    }
    
    func setPostBody(body: String) {
        self.postBody = body
    }
    
    func setAuthor(author: User) {
        self.author = author
    }
    
    func setRouteOfPost(route: Route) {
        self.routeOfPost = route
    }
    //-----------------------------------------------------------------------
}
