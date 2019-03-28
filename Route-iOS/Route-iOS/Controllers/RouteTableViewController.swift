import UIKit
import Firebase

class RouteTableViewController: UITableViewController {
    // firebase refrence
    var refRoutes: DatabaseReference! //DocumentReference?
    
    // to store the routes while in memory
    var routeList = [Any]() // switched to any for test
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        refRoutes = Database.database().reference().child("RoutePost")// .child("RoutePost") Listener at /RoutePost failed: permission_denied
        
        // can get data
        let db = Firestore.firestore()
        
        let docRef = db.collection("RoutePost").document("DD1gJ37TxppjCNpmjcLY")
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                //print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
        
        let colRef = db.collection("RoutePost")
        let doc = colRef.getDocuments()
        {
            (querySnapshot, err) in
            
            if let err = err
            {
                print("Error getting documents: \(err)");
            }
            else
            {
                var count = 0
                for document in querySnapshot!.documents {
                    count += 1
                    print("\(document.documentID) => \(document.data())");
                }
                
                print("Count = \(count)");
            }
        }
        
        
        //get the data and put it in an list
        //observing the data changes
        refRoutes.observe(DataEventType.value, with: { (snapshot) in
            
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                
                //clearing the list
                self.routeList.removeAll()
                
                //iterating through all the values
                for route in snapshot.children.allObjects as! [DataSnapshot] {
                    //get data
                    // the data instance / row in firebase
                    let routeDataInstance = route.value as? [String: AnyObject]
                    let name  = routeDataInstance?["author"] as! [NSObject:AnyObject]
                    //let artistId  = artistObject?["id"]
                    //let artistGenre = artistObject?["artistGenre"]
                    
                    // create the instance of required obj
                    
                    
                    //route track
                    //let rt = RouteTrack()
                    //rt.distance = ""
                    //rt.duration = ""
                    //rt.time = ""
                    
                    //rt.locations = "" need a method to take the collection to list of location types
                    
                    //route
                    //let r = Route(terain: String, locationType: String, trafficSpeed: String, activityType: String, attributes: [String])
                    //author
                    //let auth = User(fName: String, lName: String)
                    //route post
                    //let rp = RoutePost(author: auth, title: String, body: String, route: r, track: rt)
                    
                    //append
                    //self.routeList.append(rp)
                    self.routeList.append(name)
                }
                
                //reloading the tableview
                //self.tableViewArtists.reloadData()
                self.tableView.reloadData()
            }
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return routeList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "routeID", for: indexPath) as! RouteTableViewCell

        // Configure the cell
        // given routePost
        let routePost: RoutePost
        
        //geven row
        //routePost = routeList[indexPath.row]
        
        //fill the cell
        //cell.routeTitleLbl?.text = routePost.getTitle()
        cell.routeTitleLbl?.text = "data" //routeList[indexPath.row] as! String

        return cell
    }
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
