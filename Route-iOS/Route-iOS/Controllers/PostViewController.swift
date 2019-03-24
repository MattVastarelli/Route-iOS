//
//  PostViewController.swift
//  Route-iOS
//
//  Created by matthew vastarelli on 3/12/19.
//  Copyright © 2019 Vastarelli, Matthew P. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    
    var routeID: String = ""
    
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
        
        print(routeID)
        
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

}
