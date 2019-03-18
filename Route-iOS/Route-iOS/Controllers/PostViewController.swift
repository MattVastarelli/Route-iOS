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
    
    
    override func awakeFromNib() {
        self.view.layoutIfNeeded()
        
        road.isSelected = false
        trail.isSelected = false
        path.isSelected = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(routeID)
        
        road?.alternateButton = [trail!, path!]
        trail?.alternateButton = [road!, path!]
        path?.alternateButton = [trail!, road!]
        
    }

}
