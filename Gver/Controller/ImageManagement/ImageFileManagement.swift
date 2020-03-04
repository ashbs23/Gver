//
//  ImageFileManagement.swift
//  Gver
//
//  Created by Md. Ashikul Hosen on 17/2/20.
//  Copyright © 2020 BS-23. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ImageFileManagement {
    
    var imageURLStrings: [String] = []
    var profileImageURLString: String?
    
    func saveImage(image: UIImage, fileName: String) -> Bool {
        let fileManager = FileManager.default
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return false
        }
        guard let directory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) as NSURL else {
            return false
        }
        do {
            let filePath = directory.appendingPathComponent(fileName)
            try data.write(to: filePath!)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    func getFileName(filePath: String) -> String {
        let fileNameSplit = filePath.split(separator: "/")
        return String(fileNameSplit.last!)
    }
    
    func getImageURLStrings() -> [String] {
        return imageURLStrings
    }
    
    func saveImageInFireStorage(fileName: String, postCheck: Bool) {
        let storageRef = K.storage.reference()
        var imageRef = storageRef.child("\(Auth.auth().currentUser!.uid)/profile/\(fileName)")
        var localFile = URL(string: "file://\(getSavedImageDirectory(named: fileName)!)")!
        if postCheck {
            imageRef = storageRef.child("\(Auth.auth().currentUser!.uid)/post/\(Date.init())\(getFileName(filePath: fileName))")
            localFile = URL(string: fileName)!
        }
        // File located on disk
        
        print(localFile.absoluteString)
        
        let uploadTask = imageRef.putFile(from: localFile, metadata: nil) { metadata, error in
            guard let metadata = metadata else {
                print("Metadata Error")
                print(error!.localizedDescription)
                return
            }
            // Metadata contains file metadata such as size, content-type.
            let size = metadata.size
            print(size)
            // You can also access to download URL after upload.
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    print("downloadURL Error")
                    print(error!.localizedDescription)
                    return
                }
                if postCheck {
                    print("From postcheck")
                    self.imageURLStrings.append(downloadURL.absoluteString)
                } else {
                    print("!From postcheck")
                    self.profileImageURLString = downloadURL.absoluteString
                    print(self.profileImageURLString!)
                }
                print("FromSaveImageInFirestore")
                print(self.imageURLStrings)
            }
        }
        uploadTask.resume()
    }
    
    func deleteImageFromFirebase(imageRef: StorageReference) {
        print("From deleteImage")
        print(imageRef)
        imageRef.delete { (error) in
            if let e = error {
                print(e.localizedDescription)
            } else {
                print("Success")
            }
        }
    }
    
    func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString)
                .appendingPathComponent(named).path)
        }
        return nil
    }

    func getSavedImageDirectory(named: String) -> String? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path
        }
        return nil
    }
}
