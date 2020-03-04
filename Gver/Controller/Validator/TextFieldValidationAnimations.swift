//
//  TextFieldValidationAnimations.swift
//  Gver
//
//  Created by Md. Ashikul Hosen on 12/2/20.
//  Copyright © 2020 BS-23. All rights reserved.
//

import Foundation
import UIKit

extension TextFieldValidators {
    
    func showTextFieldInputIsValid(for textField: UITextField) {
        textField.layer.borderColor = UIColor.init(named: "AppFocusedTextColor")?.cgColor
        textField.layer.borderWidth = 1.0
    }
    
    func showTextFieldInputNotValidError(for textField: UITextField,string errorString: String) {
        DispatchQueue.main.async {
            textField.layer.borderColor = UIColor.red.cgColor
            textField.layer.borderWidth = 1.0
            self.animationShakeTextField(for: textField)
            textField.attributedPlaceholder = NSAttributedString(string: errorString, attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        }
    }
    
    func animationShakeTextField(for textField: UITextField) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: textField.center.x - 10, y: textField.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: textField.center.x + 10, y: textField.center.y))
        
        textField.layer.add(animation, forKey: "position")
    }
}
