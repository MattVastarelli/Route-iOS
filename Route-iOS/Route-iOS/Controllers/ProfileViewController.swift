//
//  ProfileViewController.swift
//  Route-iOS
//
//  Created by matthew vastarelli on 3/12/19.
//  Copyright © 2019 Vastarelli, Matthew P. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    // firebase auth handler
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func segueToSignupInVC (_ sender: Any) {
        performSegue(withIdentifier: "fromProfileToAuth", sender: self)
    }
    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
    }

}
