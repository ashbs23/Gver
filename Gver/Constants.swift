//
//  Constants.swift
//  Gver
//
//  Created by Md. Ashikul Hosen on 10/2/20.
//  Copyright © 2020 BS-23. All rights reserved.
//

import Foundation
import Firebase

struct K {
    static let settingsTableStrings = [
        "Notification Settings",
        "About us",
        "Rate this app",
        "Contact us",
        "Share with friends",
        "Signout"
    ]
    
    static let db = Firestore.firestore()
    
    struct SegueNames {
        static let goToSignUp = "goToSignUp"
        static let signInToHome = "signInToHome"
        static let alreadySignedIn = "alreadySignedIn"
        static let signUpToHome = "signUpToHome"
        static let settingsToEditProfile = "SettingsToEditProfile"
        static let editProfileToMap = "EditProfileToMap"
    }
    
    struct StoryboardID {
        static let signInViewController = "SignInViewController"
        static let locationSearchTable = "LocationSearchTable"
    }
    
    struct TableCustomCellID {
        static let searchTableCell = "searchTableCell"
    }
    
    struct ReusableTableCells {
        static let settingsTableCell = "settingsTableCell"
    }
    
    struct FStoreFields {
        struct UserInformationFields {
            static let userInformationCollectionName = "userInformation"
            static let firstTimeField: String = "firstTime"
            static let firstNameField: String = "firstName"
            static let lastNameField: String = "lastName"
            static let emailField: String = "email"
            static let addressField: String = "address"
            static let phoneField: String = "phone"
            static let lastUpdatedField: String = "lastUpdated"
            static let profileImageURL: String = "profileImageURL"
        }
    }
    
    struct UserImageDirs {
        static var userProfileImage = "Profile\(Auth.auth().currentUser!.uid).png"
    }
    
    struct ViewTitle {
        static let editProfile = "Edit Profile"
    }
    
    struct TextFieldErrorStrings {
        static let nameErrorString = "Please enter your name"
        static let addressErrorString = "Please enter your address"
        static let phoneErrorString = "Please enter your phone number"
        static let phoneValidityErrorString = "Please enter a valid phone number"
    }
    
    struct AlertStrings {
        static let confirmPasswordError = "Please enter the same password in both field"
        static let registrationSuccessfulMsg = "User registered successfully"
        static let signingOut = "Signing out..."
    }
}
