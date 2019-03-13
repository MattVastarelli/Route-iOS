//
//  CameraViewController.swift
//  Route-iOS
//
//  Created by matthew vastarelli on 3/5/19.
//  Copyright © 2019 Vastarelli, Matthew P. All rights reserved.
//

import UIKit
import Foundation
import SDWebImage

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imagePicker: UIImagePickerController!
    @IBOutlet weak var profilePicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // this is a comment
        // how to display a pic
        //profilePicture.image = UIImage(named: ("icon-user-default"))
    }
    
    // function to handle the slection of a picture
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profilePicture.image = info[.originalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    // handle the canceling of picking an image/taking a picture
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // function respoable for taking the picture
    @IBAction func openCamera(_ sender: Any) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.cameraCaptureMode = .photo
        
        present(imagePicker, animated: true, completion: nil)
    }
    

}
