//
//  SignInViewController.swift
//  Route-iOS
//
//  Created by matthew vastarelli on 2/24/19.
//  Copyright © 2019 Vastarelli, Matthew P. All rights reserved.
//

import UIKit
import FirebaseUI
import Firebase
import FirebaseAuth

class SignInViewController: UIViewController {
    @IBOutlet weak var emailFeild: UITextField!
    @IBOutlet weak var passwordFeild: UITextField!
    
    @IBOutlet weak var failLabel: UILabel!
    @IBOutlet weak var successFail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //email mattvastarelli@gmail.com
    //pass addminpass
    
    func segueToHomeVC (_ sender: Any) {
        performSegue(withIdentifier: "signinToHome", sender: self)
    }
    
    @IBAction func signInButton(_ sender: UIButton) {
        let email = emailFeild.text
        let password = passwordFeild.text
        
        Auth.auth().signIn(withEmail: email!, password: password!, completion: {(user, error) in
            if error == nil{
                self.successFail.text = "Success"
                self.segueToHomeVC(self)
            }
            else{
                self.successFail.text = "Failure"
                self.failLabel.text = error!.localizedDescription
            }
        })
    }
    
}
