import UIKit
import Firebase

class RouteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var routeTitle: UILabel!
}


class RouteTableViewController: UITableViewController {
    
    // to store the routes while in memory
    var routeList = [Any]() // switched to any for test
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // can get data
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
                    
                    let title = data["title"]
    
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
                    self.routeList.append(title ?? "default value")
                }
                //print(self.routeList.count)
                //print(self.routeList[0])
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
        print("func that gets the count")
        print(self.routeList.count)
        return self.routeList.count //1 // this as it stands now returns o
        //return footballTeams.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "routeID", for: indexPath) as! RouteTableViewCell

        print("Func that adds to cell")
        print(indexPath.row)
        print((self.routeList[indexPath.row] as! String))
        
        let t = self.routeList[indexPath.row]
        // Configure the cell
        // given routePost
        //let routePost: RoutePost
        
        //geven row
        //routePost = routeList[indexPath.row]
        
        //fill the cell
        //cell.routeTitleLbl?.text = routePost.getTitle()
        cell.routeTitle?.text = t as! String
        //cell.routeTitle?.text = footballTeams[indexPath.row]

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
