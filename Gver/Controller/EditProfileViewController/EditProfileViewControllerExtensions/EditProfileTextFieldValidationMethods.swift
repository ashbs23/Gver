//
//  TextFieldValidator.swift
//  Gver
//
//  Created by Md. Ashikul Hosen on 12/2/20.
//  Copyright © 2020 BS-23. All rights reserved.
//

import Foundation
import UIKit

extension EditProfileViewController {
    
    func areTextFieldInputsValid() -> Bool {
        var valid = true
        let tfValidators = TextFieldValidators()
        valid = !tfValidators.isTextFieldEmpty(firstNameTextField)
        valid = !tfValidators.isTextFieldEmpty(lastNameTextField)
        valid = !tfValidators.isTextFieldEmpty(addressTextField)
        valid = !tfValidators.isTextFieldEmpty(emailTextField)
        valid = !tfValidators.isTextFieldEmpty(phoneTextField)
        valid = tfValidators.isValidPhone(phoneString: phoneTextField.text!)
        
        return valid
    }
    
    
}
