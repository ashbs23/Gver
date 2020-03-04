//
//  PostManagementFirebase.swift
//  Gver
//
//  Created by Md. Ashikul Hosen on 26/2/20.
//  Copyright © 2020 BS-23. All rights reserved.
//

import Foundation
import Firebase

class PostManagementFirebase {
    
    var postInformation = PostInformation(userId: "",
                                          profileImageURLString: "",
                                          postId: "",
                                          postTitle: "",
                                          postDetails: "",
                                          postAddress: "",
                                          latitude: 0.0,
                                          longitude: 0.0,
                                          postImages: [],
                                          postTime: Date.timeIntervalBetween1970AndReferenceDate,
                                          finished: false)
    
    func storePostToFirebase(postTitle: String,
                             postDetails: String,
                             postAddress: String,
                             latitude: Double,
                             longitude: Double,
                             postImages: [String],
                             postTime: Double,
                             finished: Bool) {
        let docRef = K.db.collection(K.FStoreFields.PostInformationFields.postInformationCollectionName)
            .document("\(Auth.auth().currentUser!.uid)\(Date.init())")
        print(docRef.documentID)
        let postInformation = PostInformation(
            userId: Auth.auth().currentUser!.uid,
            profileImageURLString: ProfileManagementFirestore.userInformation.profileImageURL,
            postId: "\(Auth.auth().currentUser!.uid)\(Date.init())",
            postTitle: postTitle,
            postDetails: postDetails,
            postAddress: postAddress,
            latitude: latitude,
            longitude: longitude,
            postImages: postImages,
            postTime: postTime,
            finished: finished)
        print(postInformation)
        print("From store post")
        docRef.setData(postInformation.dictionary) { error in
            if let e = error {
                print(e.localizedDescription)
            } else {
                print("Ok")
            }
            
        }
    }
    
    func loadPostFromFirebase(completion: @escaping (Bool, [PostInformation]) -> Void) {
        var posts: [PostInformation] = []
        let collectionRef = K.db.collection(K.FStoreFields.PostInformationFields.postInformationCollectionName)
        print(collectionRef)
        collectionRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let flag = true
                for document in querySnapshot!.documents {
                    let dataDescription = document.data() as [String: Any]
                    let post = PostInformation(
                        userId: dataDescription[K.FStoreFields.PostInformationFields.userIdField] as! String,
                        profileImageURLString: dataDescription[K.FStoreFields.PostInformationFields.profileImageURLStringField] as? String,
                        postId: dataDescription[K.FStoreFields.PostInformationFields.postIdField] as! String,
                        postTitle: dataDescription[K.FStoreFields.PostInformationFields.postTitleField] as! String,
                        postDetails: dataDescription[K.FStoreFields.PostInformationFields.postDetailsField] as? String,
                        postAddress: dataDescription[K.FStoreFields.PostInformationFields.postAddressField] as? String,
                        latitude: dataDescription[K.FStoreFields.PostInformationFields.latitudeField] as? Double,
                        longitude: dataDescription[K.FStoreFields.PostInformationFields.longitudeField] as? Double,
                        postImages: dataDescription[K.FStoreFields.PostInformationFields.postImagesField] as? [String],
                        postTime: dataDescription[K.FStoreFields.PostInformationFields.postTimeField] as! Double,
                        finished: dataDescription[K.FStoreFields.PostInformationFields.statusFinishedField] as! Bool)
                    posts.append(post)
                }
                completion(flag, posts)
            }
        }
    }
    
}
