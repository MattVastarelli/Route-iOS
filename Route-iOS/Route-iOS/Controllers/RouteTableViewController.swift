import UIKit
import Firebase

class RouteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var routeTitle: UILabel!
    @IBOutlet weak var routeType: UILabel!
    @IBOutlet weak var routeDate: UILabel!
    @IBOutlet weak var routeDistance: UILabel!
    @IBOutlet weak var viewBtn: UIButton!
}


class RouteTableViewController: UITableViewController {
    
    // to store the routes while in memory
    var routeList = [RoutePost]()
    
    var container = Array<Any>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Recent Routes"
        //  get data
        let db = Firestore.firestore()
        
        let colRef = db.collection("RoutePost")
        _ = colRef.getDocuments()
        {
            (querySnapshot, err) in
            
            if let err = err
            {
                print("Error getting documents: \(err)");
            }
            else
            {
                //for all the documents
                for document in querySnapshot!.documents {
                   
                    //get data
                    let data = document.data() // main document data
                    // create the instance of required objs
                    
                    //route track
                    //route track collection
                    let rtCollection = data["tracked route"] as! Dictionary<String, AnyObject>
                    let rt = RouteTrack()
                    rt.distance = rtCollection["distance"] as! Float
                    rt.duration = rtCollection["duration"] as! Int
                    let firTimeStamp = rtCollection["Date"] as! Timestamp
                    rt.date = firTimeStamp.dateValue() as NSDate
                    
                    
                    let locs = rtCollection["locations"] as! [NSDictionary]
                    rt.setLocations(locations: locs)
                    
                    //route
                    let routeDetCollection = data["route description"] as! Dictionary<String, AnyObject>
                    let actType = routeDetCollection["activity type"] as! String
                    let loc = routeDetCollection["location"] as! String
                    let terain = routeDetCollection["terain"] as! String
                    let tSpeed = routeDetCollection["traffic speed"] as! String
                    let attr = routeDetCollection["attributes"] as! [String]
                    // route instance
                    let r = Route(terain: terain, locationType: loc, trafficSpeed: tSpeed, activityType: actType, attributes: attr )
                    
                    
                    //author
                    let authColection = data["author"] as! Dictionary<String, AnyObject>
                    let first = authColection["first name"] as! String
                    let last = authColection["last name"] as! String
                    //author isntance
                    let auth = User(fName: first, lName: last)
                    
                    //route post
                    // root level route post items
                    let title = data["title"] as! String
                    let body = data["body"] as! String
                    
                    let rp = RoutePost(author: auth, title: title, body: body, route: r, track: rt)
                    rp.setID(id: document.documentID)
                    
                    //append
                    self.routeList.append(rp)
                }
                // reload the data because the query takes to long
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.routeList.count //1 // this as it stands now returns o
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "routeID", for: indexPath) as! RouteTableViewCell
        // Configure the cell
        // given routePost
        let routePost: RoutePost
        
        //geven row
        routePost = routeList[indexPath.row]
        
        //fill the cell
        cell.routeTitle?.text = routePost.getTitle()
        cell.routeDate.text = routePost.getTrackedRoute().getDateAsString()
        cell.routeDistance.text = routePost.getTrackedRoute().getDistanceAsString()
        cell.routeType.text = routePost.getRoute().getActivityType()
        
        cell.viewBtn.tag = indexPath.row
        cell.viewBtn.addTarget(self, action: #selector(connected(sender:)), for: .touchUpInside)

        return cell
    }
    
    @objc func connected(sender: UIButton){
        let route = self.routeList[sender.tag]
        
        self.container.removeAll()
        self.container.append(route)
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            print("phone")
        }
        else{
            print("ipad")
        }
        
        self.segueToPostViewVC(self)
    }
    
    func segueToPostViewVC (_ sender: Any) {
        performSegue(withIdentifier: "fromTableToView", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let destinationVC = segue.destination as! ViewRouteViewController
        //destinationVC.container.removeAll()
        //print("dest size", destinationVC.container.count)
        
        destinationVC.container = self.container
    }
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }

}
