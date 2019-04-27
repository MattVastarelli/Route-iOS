import UIKit

class CheckBox: UIButton {
    // most of the code was taken from stackoverflow and converted to work in swift 4
    // Images
    let checkedImage = UIImage(named: "check-box")! as UIImage
    let uncheckedImage = UIImage(named: "check-box-empty")! as UIImage
    
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
