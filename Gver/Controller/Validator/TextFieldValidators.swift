//
//  TFValidators.swift
//  Gver
//
//  Created by Md. Ashikul Hosen on 14/2/20.
//  Copyright © 2020 BS-23. All rights reserved.
//

import Foundation
import UIKit

class TextFieldValidators {

    func isTextFieldEmpty(_ textField: UITextField) -> Bool {
        let empty = textField.text?.isEmpty
        return empty!
    }
    
    func isValidEmail(emailString email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: email)
        return result
    }
    
    func isValidPhone(phoneString: String) -> Bool {
        let phoneRegEx = "(01){1}[3-9]{1}[0-9]{8}$"
        let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        let result = phoneTest.evaluate(with: phoneString)
        return result
    }
}
