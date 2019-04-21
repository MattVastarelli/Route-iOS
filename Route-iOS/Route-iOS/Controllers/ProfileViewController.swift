//
//  ProfileViewController.swift
//  Route-iOS
//
//  Created by matthew vastarelli on 3/12/19.
//  Copyright © 2019 Vastarelli, Matthew P. All rights reserved.
//

import UIKit
import Firebase
import Foundation
import Social

class ProfileViewController: UIViewController {

    // firebase auth handler
    var handle: AuthStateDidChangeListenerHandle?
    var userEmail = ""
    var user = User(fName: "", lName: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func signOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        self.segueToHomeVC(self)
    }
    @IBAction func viewMyRoutes(_ sender: Any) {
            self.segueToMyVC(self)
    }
    
    @IBAction func mySavedRoutes(_ sender: Any) {
        self.segueToSavedVC(self)
    }
    
    //facebook interaction
    @IBAction func post(_ sender: Any) {
        let facebookController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        facebookController?.setInitialText("I Am Loving RouteiOS")
        present(facebookController!, animated: true, completion: nil)
 
    }

    func segueToSignupInVC (_ sender: Any) {
        performSegue(withIdentifier: "fromProfileToAuth", sender: self)
    }
    
    func segueToHomeVC (_ sender: Any) {
        performSegue(withIdentifier: "fromProfileToHome", sender: self)
    }
    
    func segueToMyVC (_ sender: Any) {
        performSegue(withIdentifier: "profileToMy", sender: self)
    }
    
    func segueToSavedVC (_ sender: Any) {
        performSegue(withIdentifier: "profileToSaved", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if type(of: segue.destination) == SavedRoutesTableViewController.self {
            let destinationVC = segue.destination as! SavedRoutesTableViewController
            destinationVC.isMyRoutes = false
            destinationVC.savedRoutes = user.getMySavedRoutes()
        }
        else if type(of: segue.destination) == MyRoutesTableViewController.self {
            let destinationVC = segue.destination as! MyRoutesTableViewController
            destinationVC.isMyRoutes = false
            destinationVC.myRoutes = user.getMyRoutes()
            destinationVC.user = self.user
        }
    }
    
    func getUser() {
        //  get data
        let db = Firestore.firestore()
        
        let colRef = db.collection("Users")
        _ = colRef.getDocuments()
            {
                (querySnapshot, err) in
                
                if let err = err
                {
                    print("Error getting documents: \(err)");
                }
                else
                {
                    //for all the documents
                    for document in querySnapshot!.documents {
                        
                        //get data
                        let data = document.data() // main document data
                        let email = data["email"] as! String
                        let fName = data["first name"] as! String
                        let lName = data["last name"] as! String
                        
                        let myRoutes = data["my routes"] as! Array<String>
                        let savedRoutes = data["saved routes"] as! Array<String>
                        
                        
                        if email == self.userEmail
                        {
                            self.user.setFirstName(name: fName)
                            self.user.setLastName(name: lName)
                            self.user.setMyRoutes(routes: myRoutes)
                            self.user.setEmail(email: email)
                            self.user.setMySavedRoutes(savedRoutes: savedRoutes)
                            self.user.setID(id: document.documentID)
                        }
                    }
                }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if ((user) != nil) {
                self.userEmail = user?.email ?? ""
                self.getUser()
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
