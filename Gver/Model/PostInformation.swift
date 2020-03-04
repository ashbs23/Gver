//
//  PostInformation.swift
//  Gver
//
//  Created by Md. Ashikul Hosen on 20/2/20.
//  Copyright © 2020 BS-23. All rights reserved.
//

import Foundation

struct PostInformation: Codable {
    let userId: String
    let profileImageURLString: String?
    let postId: String
    let postTitle: String
    let postDetails: String?
    let postAddress: String?
    let latitude: Double?
    let longitude: Double?
    let postImages: [String]?
    let postTime: Double
    let finished: Bool
    
    var dictionary: [String: Any] {
        return
            [K.FStoreFields.PostInformationFields.userIdField: userId,
             K.FStoreFields.PostInformationFields.profileImageURLStringField: profileImageURLString ?? "",
             K.FStoreFields.PostInformationFields.postIdField: postId,
             K.FStoreFields.PostInformationFields.postTitleField: postTitle,
             K.FStoreFields.PostInformationFields.postDetailsField: postDetails ?? "",
             K.FStoreFields.PostInformationFields.postAddressField: postAddress ?? "",
             K.FStoreFields.PostInformationFields.latitudeField: latitude ?? 0.0,
             K.FStoreFields.PostInformationFields.longitudeField: longitude ?? 0.0,
             K.FStoreFields.PostInformationFields.postImagesField: postImages ?? [],
             K.FStoreFields.PostInformationFields.postTimeField: postTime,
             K.FStoreFields.PostInformationFields.statusFinishedField: finished
        ]
    }
}
