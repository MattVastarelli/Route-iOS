import Foundation
import Firebase

class RoutePost: Post {
    // this class models a postiting of a route
    // by adding the route object
    private var routeOfPost: Route
    private var trackedRoute: RouteTrack
    
    //firestore
    let db = Firestore.firestore()
    
    //----------------------------------------------------------------
    init(author: User, title: String, body: String, route: Route, track: RouteTrack) {
        self.routeOfPost = route
        self.trackedRoute = track
        
        // super cass init
        super.init(author: author, title: title, body: body)
    }
    //-----------------------------------------------------------------
    // Route Getter
    func getRoute() -> Route {
        return self.routeOfPost
    }
    
    func getTrackedRoute() -> RouteTrack {
        return self.trackedRoute
    }
    // Route Setter
    func setRoute(route: Route) {
        self.routeOfPost = route
    }
    
    func setRouteTrack(routeTrack: RouteTrack) {
        self.trackedRoute = routeTrack
    }
    
    func save() {
        // break down of route tracking in to a collection for firebase
        let routeT = self.trackedRoute.getRouteCollection()
        // breakdown of the route description for firebase
        let routeD = self.routeOfPost.getRouteCollection()
        //
        let userC =  super.getAuthor().getUserCollection()
        
        // refrence for firebase
        var ref: DocumentReference? = nil
        
        // save the record
        ref = db.collection("RoutePost").addDocument(data: [
            "tracked route": routeT,
            "route description": routeD,
            "author": userC,
            "title": super.getTitle(),
            "body": super.getPostBody()
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                self.setID(id: ref!.documentID)
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
}
