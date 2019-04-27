//
//  MainAuthViewController.swift
//  Route-iOS
//
//  Created by Vastarelli, Matthew P on 4/27/19.
//  Copyright © 2019 Vastarelli, Matthew P. All rights reserved.
//

import UIKit

class MainAuthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true)
        // Do any additional setup after loading the view.
    }
    
    func segueToHomeVC (_ sender: Any) {
        performSegue(withIdentifier: "fromAuthToHome", sender: self)
    }
    
    @IBAction func SwipeToHome(_ gestureRecognizer: UISwipeGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            self.segueToHomeVC(self)
        }
    }
    

}
