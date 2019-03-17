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

class RouteTrackingViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    // labels to display route information
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var splitLabel: UILabel!
    
    //map view
    @IBOutlet weak var mapView: MKMapView!
    
    
    // class to hold all the route tracking data
    let routeTracker = RouteTrack()
    
    // init the nesscary data members
    var seconds = 0.0
    var distance = 0.0
    var pace = 0.0
    var split = 0.0
    
    // bools to control stop pause start
    var trackingStarted = false
    
    // map - location manager
    //var locationManager: CLLocationManager!
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    // tracking data
    lazy var locations = [CLLocation]()
    lazy var timer = Timer()
    
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
    
    // handle the display of the map
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
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
        seconds += 1
        
        let secondsQuantity = HKQuantity(unit: HKUnit.second(), doubleValue: seconds)
        timeLabel.text = secondsQuantity.description
        
        let distanceQuantity = HKQuantity(unit: HKUnit.meter(), doubleValue: distance)
        distanceLabel.text = distanceQuantity.description
        
        let paceUnit = HKUnit.second().unitDivided(by: HKUnit.meter())
        let paceQuantity = HKQuantity(unit: paceUnit, doubleValue: seconds / distance)
        paceLabel.text = paceQuantity.description
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
            
            trackingStarted = true;
        }
    }
    
    
    @IBAction func stopTracking(_ sender: Any) {
        // save the route
        saveRoute()
        // stop the tracking
        stopTracking()
        
        // send user to the post screen
    }
    
    func saveRoute() {
       
        // fill all the data  in to the objects
        routeTracker.distance = Float(distance)
        routeTracker.duration = Int(seconds)
        routeTracker.time = NSDate()
        
        for location in locations {
            let _location = Location()
            _location.time = location.timestamp as NSDate
            _location.latitude = location.coordinate.latitude
            _location.longitude = location.coordinate.longitude
            routeTracker.locations.append(_location)
        }
        
        // save the object to firebase
        routeTracker.saveRoute()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            if location.horizontalAccuracy < 10 {
                if self.locations.count > 0 {
                    distance += location.distance(from: self.locations.last!)
                    
                    var coords = [CLLocationCoordinate2D]()
                    coords.append(self.locations.last!.coordinate)
                    coords.append(location.coordinate)
                    
                    paceLabel.text = String(location.distance(from: self.locations.last!)/(location.timestamp.timeIntervalSince(self.locations.last!.timestamp)))
                    
                    let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 250, longitudinalMeters: 250)
                    mapView.setRegion(region, animated: true)
                    
                    mapView.addOverlay(MKPolyline(coordinates: &coords, count: coords.count))
                }
                self.locations.append(location)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.green
            polylineRenderer.lineWidth = 3
            return polylineRenderer
        }
        return MKOverlayRenderer()
    }
    
}

