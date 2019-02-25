//
//  SignUpInViewController.swift
//  Route-iOS
//
//  Created by matthew vastarelli on 2/24/19.
//  Copyright © 2019 Vastarelli, Matthew P. All rights reserved.
//

import UIKit
import FirebaseUI
import Firebase
import FirebaseAuth

class SignUpInViewController: UIViewController {
    
    // sign up text feilds
    @IBOutlet weak var emailFeild: UITextField!
    @IBOutlet weak var passwordFeild: UITextField!
    
    //output label
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var failbox: UITextView!
    
    // grab the email and password from the feilds
    @IBAction func signUpButton(_ sender: UIButton) {
        let email = emailFeild.text
        let password = passwordFeild.text
        
        Auth.auth().createUser(withEmail: email!, password: password!, completion: {(user, error) in
            if error == nil {
                self.outputLabel.text = "Success"
            }else{
                self.outputLabel.text = "Failure"
                self.failbox.text = error!.localizedDescription
            }
            
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
