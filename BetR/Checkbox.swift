//
//  Checkbox.swift
//  BetTrak
//
//  Created by Christopher Tufaro on 10/9/16.
//  Copyright © 2016 tmc. All rights reserved.
//

import UIKit

class Checkbox: UIButton {

    let checkedImage = UIImage(named: "checkbox-sel")! as UIImage
    let uncheckedImage = UIImage(named: "checkbox")! as UIImage
    
    // Bool property
    
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: UIControlState())
            } else {
                self.setImage(uncheckedImage, for: UIControlState())
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(Checkbox.buttonClicked(_:)), for: UIControlEvents.touchUpInside)
        self.isChecked = false
    }
    
    func buttonClicked(_ sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }

}
