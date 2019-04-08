//
//  RouteTrackingViewController.swift
//  Route-iOS
//
//  Created by matthew vastarelli on 3/6/19.
//  Copyright © 2019 Vastarelli, Matthew P. All rights reserved.
//

import UIKit
import CoreLocation
import HealthKit
import MapKit
import Firebase

class RouteTrackingViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    // labels to display route information
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var splitLabel: UILabel!
    
    //map view
    @IBOutlet weak var mapView: MKMapView!
    
    // firebase auth handler
    var handle: AuthStateDidChangeListenerHandle?
    
    // class to hold all the route tracking data
    let routeTracker = RouteTrack()
    
    // init the nesscary data members
    var seconds = 0.0
    var distance = 0.0
    var pace = 0.0
    var split = 0.0
    var min = 0.00
    var lastMile = 0.0
    
    // bools to control stop pause start
    var trackingStarted = false
    var end = false
    
    // map - location manager
    //var locationManager: CLLocationManager!
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    // tracking data
    lazy var locations = [CLLocation]()
    lazy var timer = Timer()
    
    
    var id: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //locationManager = CLLocationManager()
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.allowsBackgroundLocationUpdates = true
            locationManager.activityType = .fitness
            locationManager.distanceFilter = 10.0
            locationManager.startUpdatingLocation()
        }
        
        // map init
        mapView.delegate = self
        mapView.mapType = MKMapType.standard
        mapView.showsUserLocation = true
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
    }
    func segueToSignupInVC (_ sender: Any) {
        performSegue(withIdentifier: "fromGPStoAuth", sender: self)
    }
    
    // handle the display of the map
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if ((user) != nil) {
                print(user?.email)
            }
            else {
                print("not signed in")
                self.segueToSignupInVC(self)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
        self.stopTracking()
    }
    
    func startLocationUpdates() {
        locationManager.startUpdatingLocation()
    }
    
    func stopTracking() {
        timer.invalidate()
        locationManager.stopUpdatingLocation()
    }
    
    // update the various timers
    @objc func eachSecond(timer: Timer) {
        seconds += 1.00
        
        //find out the convereted times and distance
        var dblDistance = distance * 0.0006213712
        var dblPace = (seconds / 60) / (distance * 0.0006213712)
        // truncate them to two decmal places
        let strDistance = String(format: "%.2f", dblDistance)
        let strPace = String(format: "%.2f", dblPace)
        // cast them back to doubles
        dblDistance = Double(strDistance) as! Double
        dblPace = Double(strPace) as! Double
        
        let secondsQuantity = HKQuantity(unit: HKUnit.second(), doubleValue: seconds)
        timeLabel.text = secondsQuantity.description
        
        let distanceQuantity = HKQuantity(unit: HKUnit.mile(), doubleValue: dblDistance)
        distanceLabel.text = distanceQuantity.description
        
        let paceUnit = HKUnit.minute().unitDivided(by: HKUnit.mile())
        let paceQuantity = HKQuantity(unit: paceUnit, doubleValue: dblPace)
        paceLabel.text = paceQuantity.description
        
        //check to see if a mile has past to update the split label
        if (dblDistance - lastMile) > 1 {
            lastMile = dblDistance
            self.splitLabel.text = secondsQuantity.description
        }
    }
    
    // start tracking
    @IBAction func startTracking(_ sender: Any) {
        if trackingStarted == false {
            trackingStarted = true
            seconds = 0.0
            distance = 0.0
            locations.removeAll(keepingCapacity: false)
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.eachSecond), userInfo: nil, repeats: true)
            startLocationUpdates()
        }
    }
    
    func segueToHomeVC (_ sender: Any) {
        performSegue(withIdentifier: "fromGPSToHome", sender: self)
    }
    
    @IBAction func stopTracking(_ sender: Any) {
        // stop the tracking
        stopTracking()
        // save the route
        saveRoute()
        self.end = true
        self.segueToHomeVC(self)
    }
    
    func saveRoute() {
        // fill all the data  in to the objects
        routeTracker.distance = Float((distance * 0.0006213712))
        routeTracker.duration = Int(seconds)
        routeTracker.date = NSDate()
        
        for location in locations {
            let _location = Location()
            _location.time = location.timestamp as NSDate
            _location.latitude = location.coordinate.latitude
            _location.longitude = location.coordinate.longitude
            routeTracker.locations.append(_location)
        }
        
        // save the object to firebase
        //self.id  = routeTracker.saveRoute()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is PostViewController
        {
            let pvc = segue.destination as? PostViewController
            pvc?.route = self.routeTracker
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            if location.horizontalAccuracy < 20 {
                if self.locations.count > 0 {
                    distance += location.distance(from: self.locations.last!)
                    
                    var coords = [CLLocationCoordinate2D]()
                    coords.append(self.locations.last!.coordinate)
                    coords.append(location.coordinate)

                    
                    let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
                    mapView.setRegion(region, animated: true)
                    
                    mapView.addOverlay(MKPolyline(coordinates: &coords, count: coords.count))
                }
                self.locations.append(location)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if (overlay is MKPolyline) && trackingStarted {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.green
            polylineRenderer.lineWidth = 3
            return polylineRenderer
        }
        return MKOverlayRenderer()
    }
    
}

