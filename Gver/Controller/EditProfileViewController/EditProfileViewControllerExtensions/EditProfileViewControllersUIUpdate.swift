//
//  EditProfileViewControllersUIUpdate.swift
//  Gver
//
//  Created by Md. Ashikul Hosen on 12/2/20.
//  Copyright © 2020 BS-23. All rights reserved.
//

import Foundation
import Firebase

extension EditProfileViewController {
    
    func updateUI() {
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
        profileImageView.clipsToBounds = true
        
        profileImageEditButton.layer.cornerRadius = 10
        profileImageEditButton.clipsToBounds = true
        
        saveChangesButton.layer.cornerRadius = 20
        saveChangesButton.clipsToBounds = true
        
        emailTextField.text = Auth.auth().currentUser?.email
        emailTextField.isEnabled = false
        
        firstNameTextField.text = ProfileManagementFirestore.userInformation.firstName
        lastNameTextField.text = ProfileManagementFirestore.userInformation.lastName
        addressTextField.text = ProfileManagementFirestore.userInformation.address
        phoneTextField.text = ProfileManagementFirestore.userInformation.phone
        self.imagePicker = ImagePicker(presentationController: self, delegate: self,
                                       fileName: K.UserImageDirs.userProfileImage)
        let locationInformation = locationManagement.getLocationInformation()
        DispatchQueue.main.async {
            self.addressTextField.text = locationInformation["address"] as? String
        }
        
        profileImageView.pin_updateWithProgress = true
        profileImageView.pin_setImage(from: URL.init(string: ProfileManagementFirestore.userInformation.profileImageURL!), placeholderImage: UIImage(named: "Icon"))
    
    }
}
