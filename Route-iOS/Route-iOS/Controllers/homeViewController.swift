//
//  HomeViewController.swift
//  Route-iOS
//
//  Created by matthew vastarelli on 4/5/19.
//  Copyright © 2019 Vastarelli, Matthew P. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation
import EventKit

class HomeViewController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?
    var toggle = true
    var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        
        do {
            let audioPath = Bundle.main.path(forResource: "Le Castle Vania - Freak", ofType: "mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
        } catch {
                print("An error has occurred")
         }
    }
    
    func segueToSignupInVC (_ sender: Any) {
        performSegue(withIdentifier: "toSignin", sender: self)
    }
    
    
    @IBAction func music(_ sender: Any) {
        if toggle {
            audioPlayer.play()
        }
        else{
            audioPlayer.stop()
        }
        
        toggle = !toggle
    }
    
    func segueToProfileVC (_ sender: Any) {
        performSegue(withIdentifier: "fromHomeToProfile", sender: self)
    }
 
    @IBAction func swipeGesture(_ gestureRecognizer: UISwipeGestureRecognizer) {
        if gestureRecognizer.state == .ended {
           self.segueToProfileVC(self)
        }
    }
    
    /*override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if ((user) != nil) {
                print(user?.email)
                //print(user?.)
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
    }*/
    

}
