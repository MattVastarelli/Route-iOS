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

class RouteTrackingViewController: UIViewController {
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
    lazy var locationManager: CLLocationManager = {
        var _locationManager = CLLocationManager()
        _locationManager.delegate = self
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest
        _locationManager.activityType = .fitness
        _locationManager.distanceFilter = 10.0
        return _locationManager
    }()
    
    // tracking data
    lazy var locations = [CLLocation]()
    lazy var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // map init
        mapView.delegate = self
        
    }
    
    // handle the display of the map
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.activityType = .fitness
        locationManager.distanceFilter = 10.0
        locationManager.requestAlwaysAuthorization()
        
        mapView.showsUserLocation = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: mapView.userLocation.coordinate,latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        
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
            
            timer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: #selector(self.eachSecond),
                                         userInfo: nil,
                                         repeats: true)
            startLocationUpdates()
            
            trackingStarted = true;
        } else {
            trackingStarted = false
            //stop the track
            stopTracking()
            // save the track
        }
    }
    
    // stop tracking
    @IBAction func stopTracking(_ sender: Any) {
    }
    
    
} //end of controler

//
// MARK: - CLLocationManagerDelegate
extension RouteTrackingViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        for location in locations {
            if location.horizontalAccuracy < 10 {
                //update distance
                if self.locations.count > 0 {
                    distance += location.distance(from: self.locations.last!)
                    
                    var coords = [CLLocationCoordinate2D]()
                    coords.append(self.locations.last!.coordinate)
                    coords.append(location.coordinate)
                    
                    pace = location.distance(from: self.locations.last!)/(location.timestamp.timeIntervalSince(self.locations.last!.timestamp))
                    
                    let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
                    mapView.setRegion(region, animated: true)
                    
                    mapView.addOverlay(MKPolyline(coordinates: &coords, count: coords.count))
                    
                }
                
                //save location
                self.locations.append(location)
            }
        }
    }
    
}

// MARK: - MKMapViewDelegate
extension RouteTrackingViewController: MKMapViewDelegate {
}
