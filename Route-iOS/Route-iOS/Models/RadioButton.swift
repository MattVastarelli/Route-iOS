//
//  RadioButton.swift
//  Route-iOS
//
//  Created by matthew vastarelli on 3/17/19.
//  Copyright © 2019 Vastarelli, Matthew P. All rights reserved.
//

import UIKit

class RadioButton: UIButton {

    var alternateButton:Array<RadioButton>?
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2.0
        self.layer.masksToBounds = true
    }
    
    func unselectAlternateButtons(){
        if alternateButton != nil {
            self.isSelected = true
            
            for aButton:RadioButton in alternateButton! {
                aButton.isSelected = false
            }
        }else{
            toggleButton()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        unselectAlternateButtons()
        super.touchesBegan(touches, with: event)
    }
    
    func toggleButton(){
        self.isSelected = !isSelected
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.layer.backgroundColor = UIColor.blue.cgColor
                self.layer.borderColor = UIColor.blue.cgColor
            } else {
                self.layer.borderColor = UIColor.gray.cgColor
                self.layer.backgroundColor = UIColor.clear.cgColor
            }
        }
    }

}
