import Foundation

class Post: NSObject {
    //The Post class is the model for posting a given route and
    //as a super class for the comment, routePost and review subclasses
    private var author: User
    private var title: String
    private var postBody: String
    private var id: String = ""
    
    //----------------------------------------------------------------
    //Initializer
    init(author: User, title: String, body: String) {
        self.author = author
        self.title = title
        self.postBody = body
    }
    //----------------------------------------------------------------
    // Post Getters
    func getAuthor() -> User {
        return self.author
    }
    
    func getID() -> String {
        return self.id
    }
    
    func getTitle() -> String {
        return self.title
    }
    
    func getPostBody() -> String {
        return self.postBody
    }
    
    // Post Setters
    func setTitle(title: String) {
        self.title = title
    }
    
    func setID(id: String) {
        self.id = id
    }
    
    func setPostBody(body: String) {
        self.postBody = body
    }
    
    func setAuthor(author: User) {
        self.author = author
    }
    
    //-----------------------------------------------------------------------
}
