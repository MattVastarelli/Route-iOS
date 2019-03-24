import Foundation

class Review: Post {
    //The review class models a given responce/review to the main route and is a top level responce
    private var authorRepling: User
    private var starsGiven: Int
    
    //------------------------------------------------------------
    init(author: User, title: String, body: String, reply: User, stars: Int) {
        self.authorRepling = reply
        self.starsGiven = stars
        
        //Super class init
        super.init(author: author, title: title, body: body)
    }
    //------------------------------------------------------------
    //User getters and setters
    func getReplingAuth() -> User {
        return self.authorRepling
    }
    
    func setReplingAuth(reply: User) {
        self.authorRepling = reply
    }
    //------------------------------------------------------------
    //star getter and setter
    func getStarNum() -> Int {
        return self.starsGiven
    }
    
    func setStarNum(num: Int) {
        self.starsGiven = num
    }
    //------------------------------------------------------------
}
