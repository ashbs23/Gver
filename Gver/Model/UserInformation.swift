//
//  UserInformation.swift
//  Gver
//
//  Created by Md. Ashikul Hosen on 11/2/20.
//  Copyright © 2020 BS-23. All rights reserved.
//

import Foundation
import Firebase

struct UserInformation: Codable {
    var firstTime: Bool = true
    let firstName: String?
    let lastName: String?
    let email: String
    let address: String?
    let phone: String?
    let profileImageURL: String?
    
    var dictionary: [String: Any] {
        return [K.FStoreFields.UserInformationFields.firstTimeField: firstTime,
                K.FStoreFields.UserInformationFields.firstNameField: firstName ?? "",
                K.FStoreFields.UserInformationFields.lastNameField: lastName ?? "",
                K.FStoreFields.UserInformationFields.emailField: email,
                K.FStoreFields.UserInformationFields.addressField: address ?? "",
                K.FStoreFields.UserInformationFields.phoneField: phone ?? "",
                K.FStoreFields.UserInformationFields.profileImageURL: profileImageURL ?? "",
                K.FStoreFields.UserInformationFields.lastUpdatedField: FieldValue.serverTimestamp(),
        ]
    }
}
