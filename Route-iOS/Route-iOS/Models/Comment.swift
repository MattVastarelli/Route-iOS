//
//  Comment.swift
//  Route-iOS
//
//  Created by Vastarelli, Matthew P on 2/11/19.
//  Copyright © 2019 Vastarelli, Matthew P. All rights reserved.
//

import Foundation

class Comment: Post {
    //the comment class models a reply to a review or another comment
    private var postReplyingTo: Post
    private var authorReplyingToPost: User
    
    //----------------------------------------------------
    init(author: User, title: String, body: String, replyPost: Post, replyAuth: User) {
        self.postReplyingTo = replyPost
        self.authorReplyingToPost = replyAuth
        
        super.init(author: author, title: title, body: body)
    }
    //-----------------------------------------------------
    //author getter and setter
    func getReplyAuthor() -> User {
        return self.authorReplyingToPost
    }
    func setReplyAuthor(u: User) {
        self.authorReplyingToPost = u
    }
    //------------------------------------------------------
    //parrent post getters and setter
    func getParentPost() -> Post {
        return self.postReplyingTo
    }
    func setParentPost(p: Post) {
        self.postReplyingTo = p
    }
    //-----------------------------------------------------
}
