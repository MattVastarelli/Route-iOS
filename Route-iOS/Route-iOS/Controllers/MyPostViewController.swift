//
//  MyPostViewController.swift
//  Route-iOS
//
//  Created by matthew vastarelli on 3/12/19.
//  Copyright © 2019 Vastarelli, Matthew P. All rights reserved.
//

import UIKit
import Firebase

class MyPostViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var attributeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var terainLabel: UILabel!
    
    var myPost: String = ""
    // container to hold the route passed from the post vc
    //as the ID produced by firebase does not exist till after
    // the segue
    var container = Array<Any>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLabels()
    }
    
    func setLabels() {
        let route = container[0] as! RoutePost
        
        self.descriptionLabel.text = route.getPostBody()
        self.titleLabel.text = route.getTitle()
        self.speedLabel.text = route.getRoute().getTrafficSpeed()
        self.locationLabel.text = route.getRoute().getLocationType()
        self.typeLabel.text = route.getRoute().getActivityType()
        self.attributeLabel.text = route.getRoute().getAttributes().joined(separator: ", ")
        self.terainLabel.text = route.getRoute().getTerain()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
