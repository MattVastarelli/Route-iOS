//
//  SavedRoutesTableViewController.swift
//  Route-iOS
//
//  Created by matthew vastarelli on 4/14/19.
//  Copyright © 2019 Vastarelli, Matthew P. All rights reserved.
//

import UIKit
import Firebase

class SavedViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var viewRoute: UIButton!
}


class SavedRoutesTableViewController: UITableViewController {

    var savedRoutes = Array<String>()
    var routes = Array<RoutePost>()
    var isMyRoutes = false
    let db = Firestore.firestore()
    var container = Array<Any>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        for route in self.savedRoutes {
            self.getRoute(routeID: route)
        }
        self.tableView.reloadData()
        //print(self.routes)
    }

    // MARK: - Table view data source

    func getRoute(routeID: String) {
        let routeRef = db.collection("RoutePost").document(routeID)
        
        routeRef.getDocument { (document, error) in
            if let document = document, document.exists {
                //get data
                let data = document.data() // main document data
                // create the instance of required objs
                
                //route track
                //route track collection
                let rtCollection = data?["tracked route"] as! Dictionary<String, AnyObject>
                let rt = RouteTrack()
                rt.distance = rtCollection["distance"] as! Float
                rt.duration = rtCollection["duration"] as! Int
                let firTimeStamp = rtCollection["Date"] as! Timestamp
                rt.date = firTimeStamp.dateValue() as NSDate
                
                
                let locs = rtCollection["locations"] as! [NSDictionary]
                rt.setLocations(locations: locs)
                
                //route
                let routeDetCollection = data?["route description"] as! Dictionary<String, AnyObject>
                let actType = routeDetCollection["activity type"] as! String
                let loc = routeDetCollection["location"] as! String
                let terain = routeDetCollection["terain"] as! String
                let tSpeed = routeDetCollection["traffic speed"] as! String
                let attr = routeDetCollection["attributes"] as! [String]
                // route instance
                let r = Route(terain: terain, locationType: loc, trafficSpeed: tSpeed, activityType: actType, attributes: attr )
                
                
                //author
                let authColection = data?["author"] as! Dictionary<String, AnyObject>
                let first = authColection["first name"] as! String
                let last = authColection["last name"] as! String
                //author isntance
                let auth = User(fName: first, lName: last)
                
                //route post
                // root level route post items
                let title = data?["title"] as! String
                let body = data?["body"] as! String
                
                let rp = RoutePost(author: auth, title: title, body: body, route: r, track: rt)
                rp.setID(id: document.documentID)
                
                // add it to the list
                self.routes.append(rp)
                print(self.routes)
            } else {
                print("Document does not exist")
            }
            self.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.routes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "routeID", for: indexPath) as! SavedViewCell

        // Configure the cell...
        // given routePost
        let routePost: RoutePost
        
        //geven row
        routePost = self.routes[indexPath.row]
        
        //fill the cell
        cell.title.text = routePost.getTitle()
        cell.date.text = routePost.getTrackedRoute().getDateAsString()
        cell.distance.text = routePost.getTrackedRoute().getDistanceAsString()
        cell.typeLbl.text = routePost.getRoute().getActivityType()
        
        cell.viewRoute.tag = indexPath.row
        cell.viewRoute.addTarget(self, action: #selector(connected(sender:)), for: .touchUpInside)
 
        
        return cell
    }
    
    @objc func connected(sender: UIButton){
        let route = self.routes[sender.tag]
        self.container.append(route)
        
        self.segueToPostViewVC(self)
    }
    
    func segueToPostViewVC (_ sender: Any) {
        performSegue(withIdentifier: "fromSavedToView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let destinationVC = segue.destination as! ViewRouteViewController
        destinationVC.container = self.container
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
