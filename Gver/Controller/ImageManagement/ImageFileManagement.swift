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
