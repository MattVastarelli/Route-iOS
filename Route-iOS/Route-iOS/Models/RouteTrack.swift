import UIKit
import Firebase

class RouteTrack: NSObject {
    var time = NSDate()
    var duration = 0
    var distance: Float = 0.0
     // list of locations - the route being tracked
    var locations = [Location]()
    
    // fire store
    //FirebaseApp.configure()

    let db = Firestore.firestore()
    
    //a method to save to firebase
    func saveRoute() -> String {
        var ref: DocumentReference? = nil
        
        var loc: [Any] = []
        
        for l in self.locations {
            loc.append([
                "time": l.time,
                "latitude": l.latitude,
                "longitude": l.longitude
            ])
        }
        
        ref = db.collection("TrackedRoutes").addDocument(data: [
            "Date": self.time,
            "duration": self.duration,
            "distance": self.distance,
            "locations": loc
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    
        return (ref?.documentID)!
    }
}
