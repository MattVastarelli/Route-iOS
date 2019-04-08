//
//  PostViewController.swift
//  Route-iOS
//
//  Created by matthew vastarelli on 3/12/19.
//  Copyright © 2019 Vastarelli, Matthew P. All rights reserved.
//

import UIKit
import Firebase

class PostViewController: UIViewController {
    // firebase auth handler
    var handle: AuthStateDidChangeListenerHandle?
    
    // empty route tracker to recive the tracked route from the tracking view
    var route: RouteTrack = RouteTrack()
    var id = ""
    var container = Array<Any>()
    var userContainer = Array<Any>()
    
    @IBOutlet weak var routeTitle: UITextField!
    @IBOutlet weak var routeDescription: UITextView!
    
    
    @IBOutlet weak var road: RadioButton!
    @IBOutlet weak var trail: RadioButton!
    @IBOutlet weak var path: RadioButton!
    
    @IBOutlet weak var run: RadioButton!
    @IBOutlet weak var bike: RadioButton!
    @IBOutlet weak var walk: RadioButton!
    
    @IBOutlet weak var trafficSlow: RadioButton!
    @IBOutlet weak var trafficFair: RadioButton!
    @IBOutlet weak var trafficFast: RadioButton!
    
    @IBOutlet weak var urban: RadioButton!
    @IBOutlet weak var rural: RadioButton!
    @IBOutlet weak var suburban: RadioButton!
    @IBOutlet weak var park: RadioButton!
    
    @IBOutlet weak var potHoles: CheckBox!
    @IBOutlet weak var groomedTrail: CheckBox!
    @IBOutlet weak var crosswalk: CheckBox!
    @IBOutlet weak var goodLighting: CheckBox!
    @IBOutlet weak var poorLOS: CheckBox!
    @IBOutlet weak var blindCorners: CheckBox!
    @IBOutlet weak var poorLighting: CheckBox!
    @IBOutlet weak var goodLOS: CheckBox!
    
    
    override func awakeFromNib() {
        self.view.layoutIfNeeded()
        
        road.isSelected = true
        trail.isSelected = false
        path.isSelected = false
        
        run.isSelected = true
        bike.isSelected = false
        walk.isSelected = false
        
        trafficSlow.isSelected = true
        trafficFair.isSelected = false
        trafficFast.isSelected = false
        
        urban.isSelected = true
        rural.isSelected = false
        suburban.isSelected = false
        park.isSelected = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        road?.alternateButton = [trail!, path!]
        trail?.alternateButton = [road!, path!]
        path?.alternateButton = [trail!, road!]
        
        run?.alternateButton = [bike!, walk!]
        bike?.alternateButton = [run!, walk!]
        walk?.alternateButton = [run!, bike!]
        
        trafficSlow?.alternateButton = [trafficFast!, trafficFair!]
        trafficFair?.alternateButton = [trafficFast!, trafficSlow!]
        trafficFast?.alternateButton = [trafficSlow!, trafficFair!]
        
        urban?.alternateButton = [rural!, suburban!, park!]
        rural?.alternateButton = [suburban!, park!, urban!]
        suburban?.alternateButton = [park!, rural!, urban!]
        park?.alternateButton = [suburban!, rural!, urban!]
    }
    
    func getTerain() -> String {
        var terain = ""
        
        if self.road.isSelected {
            terain = RouteTerain.road.rawValue
        }
        else if self.trail.isSelected {
            terain = RouteTerain.trail.rawValue
        }
        else {
            terain = RouteTerain.path.rawValue
        }
        
        return terain
    }
    
    func getActivity() -> String {
        var activity = ""
        
        if self.run.isSelected {
            activity = ActivityType.run.rawValue
        }
        else if self.bike.isSelected {
            activity = ActivityType.bike.rawValue
        }
        else {
            activity = ActivityType.walk.rawValue
        }
        return activity
    }
    
    func getLocType() -> String {
        var loc = ""
        
        if self.urban.isSelected {
            loc = RouteLocationType.city.rawValue
        }
        else if self.rural.isSelected {
            loc = RouteLocationType.rural.rawValue
        }
        else if self.suburban.isSelected {
            loc = RouteLocationType.suburban.rawValue
        }
        else {
            loc = RouteLocationType.park.rawValue
        }
        return loc
    }
    
    func getTrafficSpeed() -> String {
        var speed = ""
        
        if self.trafficSlow.isSelected {
            speed = RouteTrafficSpeed.slow.rawValue
        }
        else if self.trafficFair.isSelected {
            speed = RouteTrafficSpeed.fair.rawValue
        }
        else {
            speed = RouteTrafficSpeed.fast.rawValue
        }
        return speed
    }
    
    func getAttributes() -> [String] {
        var attr = [String]()
        
        if self.groomedTrail.isChecked {
            attr.append(RouteAttributes.groomed.rawValue)
        }
        if self.potHoles.isChecked {
            attr.append(RouteAttributes.potHoles.rawValue)
        }
        if self.crosswalk.isChecked {
            attr.append(RouteAttributes.crosswalk.rawValue)
        }
        if self.goodLighting.isChecked {
            attr.append(RouteAttributes.wellLit.rawValue)
        }
        if self.poorLOS.isChecked {
            attr.append(RouteAttributes.noLineOfSight.rawValue)
        }
        if self.blindCorners.isChecked {
            attr.append(RouteAttributes.blindCorner.rawValue)
        }
        if self.poorLighting.isChecked {
            attr.append(RouteAttributes.poorlyLit.rawValue)
        }
        if self.goodLOS.isChecked {
            attr.append(RouteAttributes.goodLineOfSight.rawValue)
        }
        
        return attr
    }
    
    func segueToPostViewVC (_ sender: Any) {
        performSegue(withIdentifier: "fromPostToViewPost", sender: self)
    }
    
    @IBAction func postRoute(_ sender: Any) {
        
        //get the data from the form
        let ter = self.getTerain()
        let act = self.getActivity()
        let loc = self.getLocType()
        let speed = self.getTrafficSpeed()
        let attr = self.getAttributes()
        
        let title = self.routeTitle.text
        let description = self.routeDescription.text
        
        // the main route class containing the non tracking data
        let r = Route(terain: ter, locationType: loc, trafficSpeed: speed, activityType: act, attributes: attr)
        
        // get the user from the container //hard codded for now
        let u = User(fName: "matt", lName: "vastarelli")
        
        //make the route post obj
        let rPost = RoutePost(author: u, title: title ?? "my route", body: description ?? "my route", route: r, track: self.route)
        
        // save the post
        rPost.save()
        self.container.append(rPost)
        
        self.id = rPost.getID()
        
        self.segueToPostViewVC(self)
        // add the route to the user document
        //u.addRoute(id: self.id)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
       
        let destinationVC = segue.destination as! MyPostViewController
        destinationVC.container = self.container
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if ((user) != nil) {
                print(user?.email)
                //get the user data
                //let u = User(fName: , lName: )
                //put it in the container
            }
            else {
                print("not signed in")
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
}
