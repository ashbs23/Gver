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
        
        if let img = imageFileManagement.getSavedImage(
            named: K.UserImageDirs.userProfileImage) {
              profileImageView.image = img
        }
    
    }
}
