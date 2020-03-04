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
        storeTextFieldData()
    }
    
    func storeTextFieldData() {
        let check = areTextFieldInputsValid()
        let success = imageFileManagement.saveImage(image: profileImageView.image!, fileName: K.UserImageDirs.userProfileImage)
        let locationInfo = locationManagement.getLocationInformation()
        self.imageFileManagement.saveImageInFireStorage(fileName: K.UserImageDirs.userProfileImage, postCheck: false)
        print(locationInfo)
        print(success)
        let profileManagementFirestore = ProfileManagementFirestore()
        if check {
            print("OK")
            if let firstName = firstNameTextField.text,
                let lastName = lastNameTextField.text,
                let email = emailTextField.text,
                let address = addressTextField.text,
                let phone = phoneTextField.text {
                DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
                    profileManagementFirestore
                        .storeProfileDataToFirestore(firstName: firstName,
                                                     lastName: lastName,
                                                     email: email,
                                                     address: address,
                                                     latitude: locationInfo["lat"] as! Double,
                                                     longitude: locationInfo["lng"] as! Double,
                                                     phone: phone,
                                                     profileImageURL: self.imageFileManagement.profileImageURLString ?? ""
                    )
                }
                
                
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
