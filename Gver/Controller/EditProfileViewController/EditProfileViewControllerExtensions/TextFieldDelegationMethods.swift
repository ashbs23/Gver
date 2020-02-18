//
//  TextFieldDelegationMethods.swift
//  Gver
//
//  Created by Md. Ashikul Hosen on 12/2/20.
//  Copyright © 2020 BS-23. All rights reserved.
//

import Foundation
import UIKit

extension EditProfileViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var valid: Bool = true
        if textField == phoneTextField {
            let newlenth = textField.text!.count + string.count - range.length
            valid =  newlenth <= 11
        }
        return valid
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let tfValidators = TextFieldValidators()
        let empty = tfValidators.isTextFieldEmpty(textField)
        
        tfValidators.showTextFieldInputIsValid(for: textField)
        
        if (textField == firstNameTextField || textField == lastNameTextField) && empty {
            tfValidators.showTextFieldInputNotValidError(for: textField, string: K.TextFieldErrorStrings.nameErrorString)
        }
        if textField == addressTextField && empty {
            tfValidators.showTextFieldInputNotValidError(for: textField, string: K.TextFieldErrorStrings.addressErrorString)
        }
        if textField == phoneTextField && empty {
            tfValidators.showTextFieldInputNotValidError(for: textField, string: K.TextFieldErrorStrings.phoneErrorString)
        }
        if textField == phoneTextField && !empty &&
            !tfValidators.isValidPhone(phoneString: phoneTextField.text!) {
            tfValidators.showTextFieldInputNotValidError(for: textField, string: K.TextFieldErrorStrings.phoneValidityErrorString)
        }
    }
}

