import UIKit

class RadioButton: UIButton {

    // hold the other radio button which this one is grouped with
    var alternateButton:Array<RadioButton>?
    
    // set the boarders
    override func awakeFromNib() {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2.0
        self.layer.masksToBounds = true
    }
    
    // when a user selets a button unselect the other buttons
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
    
    // toggle the button
    func toggleButton(){
        self.isSelected = !isSelected
    }
    
    // swap the style between seleced an non-selected
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
