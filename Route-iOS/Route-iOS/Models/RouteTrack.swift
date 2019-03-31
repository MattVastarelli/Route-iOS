import UIKit
import Firebase

class RouteTrack: NSObject {
    var date = NSDate()
    var duration = 0
    var distance: Float = 0.0
     // list of locations - the route being tracked
    var locations = [Location]()
    
    
    func setLocations(locations: [NSDictionary]) {
        //function to recive the location collection
        //from firebase and transform it it to a
        //list of locations
        
        for loc in locations {
            let locationObj = Location()
            let firTimeStamp = loc["time"] as! Timestamp
            locationObj.time = firTimeStamp.dateValue() as NSDate
            locationObj.latitude = loc["latitude"] as! Double
            locationObj.longitude = loc["longitude"] as! Double
            
            self.locations.append(locationObj)
        }
    }
    
    // break the location list in to a collection for firebase
    func getLocationCollection() -> [Any] {
        var loc: [Any] = []
        
        for l in self.locations {
            loc.append([
                "time": l.time,
                "latitude": l.latitude,
                "longitude": l.longitude
                ])
        }
        
        return loc
    }
    
    func getRouteCollection() -> [String: Any] {
        let routeCollection = [
            "Date": self.date,
            "duration": self.duration,
            "distance": self.distance,
            "locations": self.getLocationCollection()
            ] as [String : Any]
        
        return routeCollection
    }
    
    func getDateAsString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: self.date as Date)
        
        return dateString
    }
    
    func getDistanceAsString() -> String {
        return String(format: "%.2f", self.distance) + " mi."
    }
}
