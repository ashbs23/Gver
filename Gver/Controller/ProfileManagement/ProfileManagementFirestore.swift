//
//  ProfileManagementFirestore.swift
//  Gver
//
//  Created by Md. Ashikul Hosen on 14/2/20.
//  Copyright © 2020 BS-23. All rights reserved.
//

import Foundation
import Firebase

class ProfileManagementFirestore {
    
    let locationManagement = LocationManagement.reference
    let alert = TextFieldAlert()
    
    static var userInformation = UserInformation(firstTime: true,
                                                 firstName: "",
                                                 lastName: "",
                                                 email: "",
                                                 address: "",
                                                 latitude: 0.0,
                                                 longitude: 0.0,
                                                 phone: "",
                                                 profileImageURL: "" )
    
    func loadProfileFromFirebase() {
        let docRef = K.db.collection(K.FStoreFields.UserInformationFields.userInformationCollectionName)
            .document(Auth.auth().currentUser!.uid)
        print(docRef.documentID)
        docRef.getDocument(){ (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()! as [String: Any]
                ProfileManagementFirestore.self.userInformation
                    = UserInformation(firstTime: dataDescription[K.FStoreFields.UserInformationFields.firstTimeField] as! Bool,
                                      firstName: dataDescription[K.FStoreFields.UserInformationFields.firstNameField] as? String,
                                      lastName: dataDescription[K.FStoreFields.UserInformationFields.lastNameField] as? String,
                                      email: dataDescription[K.FStoreFields.UserInformationFields.emailField] as! String,
                                      address: dataDescription[K.FStoreFields.UserInformationFields.addressField] as? String,
                                      latitude: dataDescription[K.FStoreFields.UserInformationFields.latitudeField] as? Double,
                                      longitude: dataDescription[K.FStoreFields.UserInformationFields.longitudeField] as? Double,
                                      phone: dataDescription[K.FStoreFields.UserInformationFields.phoneField] as? String,
                                      profileImageURL: dataDescription[K.FStoreFields.UserInformationFields.profileImageURL] as? String
                )
                //print(ProfileManagementFirestore.self.userInformation)
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist \(error?.localizedDescription ?? "")")
                ProfileManagementFirestore.userInformation = UserInformation(firstTime: true,
                                                                             firstName: "",
                                                                             lastName: "",
                                                                             email: "",
                                                                             address: "",
                                                                             latitude: 0.0,
                                                                             longitude: 0.0,
                                                                             phone: "",
                                                                             profileImageURL: ""
                )
            }
        }
    }
    
    func storeProfileDataToFirestore(firstName: String, lastName: String, email: String,
                                     address: String, latitude: Double, longitude: Double,
                                     phone: String, profileImageURL: String) {
        let docRef = K.db.collection(K.FStoreFields.UserInformationFields.userInformationCollectionName)
            .document(Auth.auth().currentUser!.uid)
        print(docRef.documentID)
        
        let userInformation = UserInformation(firstName: firstName,
                                              lastName: lastName,
                                              email: email,
                                              address: address,
                                              latitude: latitude,
                                              longitude: longitude,
                                              phone: phone,
                                              profileImageURL: profileImageURL)
        print(userInformation)
        print("From Store data")
        docRef.setData(userInformation.dictionary) { error in
            if let e = error {
                print(e.localizedDescription)
            } else {
                print("Ok")
                self.loadProfileFromFirebase()
            }
        }
    }
    
}
