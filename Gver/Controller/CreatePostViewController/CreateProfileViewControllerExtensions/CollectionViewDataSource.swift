//
//  CollectionViewDataSource.swift
//  Gver
//
//  Created by Md. Ashikul Hosen on 25/2/20.
//  Copyright © 2020 BS-23. All rights reserved.
//

import Foundation
import UIKit
import Photos

extension CreatePostViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        if !imageArray.isEmpty && (indexPath.row != imageArray.count) {
            var retimage = UIImage()
            let manager = PHImageManager.default()
            manager.requestImage(for: imageArray[indexPath.row], targetSize: PHImageManagerMaximumSize, contentMode: .default, options: nil) { (resultImage, info) in
                retimage = resultImage!
            }
            cell.imageView.image = retimage
            cell.removeImageButton.isHidden = false
            cell.removeImageButton.addTarget(self, action: #selector(removeImageButtonPressed), for: .touchUpInside)
            
        }
        if indexPath.row == imageArray.count {
            cell.imageView.image = UIImage(named: "AddImageIcon")
//            let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(singleTapMultipleImageSelection))
//            singleTapGesture.numberOfTapsRequired = 1
//            cell.imageView.addGestureRecognizer(singleTapGesture)
            cell.removeImageButton.isHidden = true
        }
        updateView(cell.imageView)
        return cell
    }
}
