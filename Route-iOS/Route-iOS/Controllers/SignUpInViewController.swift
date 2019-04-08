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
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    
    //output label
    @IBOutlet weak var failLabel: UILabel!
    @IBOutlet weak var outputLabel: UILabel!

    
    func segueToHomeVC (_ sender: Any) {
        performSegue(withIdentifier: "signupToHome", sender: self)
    }
    
    // grab the email and password from the feilds
    @IBAction func signUpButton(_ sender: UIButton) {
        let email = emailFeild.text
        let password = passwordFeild.text
        
        Auth.auth().createUser(withEmail: email!, password: password!, completion: {(user, error) in
            if error == nil {
                self.outputLabel.text = "Success"
                // create the user
                var user = User(fName: self.firstName.text ?? "Anon", lName: self.lastName.text ?? "")
                //save the user to firebase
                user.save()
                
                // send the user back to the home screen
                self.segueToHomeVC(self)
            }else{
                self.outputLabel.text = "Failure"
                self.failLabel.text = error!.localizedDescription
            }
            
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
