//
//  CheckBox.swift
//  Route-iOS
//
//  Created by matthew vastarelli on 3/17/19.
//  Copyright © 2019 Vastarelli, Matthew P. All rights reserved.
//

import UIKit

class CheckBox: UIButton {

    // Images
    let checkedImage = UIImage(named: "ic_check_box")! as UIImage
    let uncheckedImage = UIImage(named: "ic_check_box_outline_blank")! as UIImage
    
    // check and un check the boxes by switching the img
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: UIControl.State.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
    
    // toggle the check box
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }

}
