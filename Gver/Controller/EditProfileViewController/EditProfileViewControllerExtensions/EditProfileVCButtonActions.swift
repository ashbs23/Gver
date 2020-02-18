//
//  TextFieldButtonActions.swift
//  Gver
//
//  Created by Md. Ashikul Hosen on 12/2/20.
//  Copyright © 2020 BS-23. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import CoreLocation

extension EditProfileViewController {
    
    @IBAction func profileImageEditButtonPressed(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    @IBAction func profileImagePressed(_ sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
    @IBAction func changEmailOrResetPasswordButtonPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Notice!", message:
            "What do you want to change?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Change Email", style: .default) { action in
            print("Not yet implemented")
        })
        alertController.addAction(UIAlertAction(title: "Change Password", style: .default) { action in
            print("Not yet implemented")
        })
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func saveChangesButtonPressed(_ sender: UIButton) {
        let check = areTextFieldInputsValid()
        let success = imageFileManagement.saveImage(image: profileImageView.image!, fileName: K.UserImageDirs.userProfileImage)
        print(success)
        let profileManagementFirestore = ProfileManagementFirestore()
        if check {
            print("OK")
            if let firstName = firstNameTextField.text,
                let lastName = lastNameTextField.text,
                let address = addressTextField.text,
                let email = emailTextField.text,
                let phone = phoneTextField.text {
                profileManagementFirestore
                    .storeProfileDataToFirestore(firstName: firstName,
                                                 lastName: lastName,
                                                 email: email, address: address,
                                                 phone: phone,
                                                 profileImageURL: (imageFileManagement.getSavedImageDirectory(named: K.UserImageDirs.userProfileImage)) ?? ""
                )
                
            }
        } else {
            textFieldDidEndEditing(firstNameTextField)
            textFieldDidEndEditing(lastNameTextField)
            textFieldDidEndEditing(addressTextField)
            textFieldDidEndEditing(emailTextField)
            textFieldDidEndEditing(phoneTextField)
            print("Not Ok")
        }
    }
    
    
    
}
