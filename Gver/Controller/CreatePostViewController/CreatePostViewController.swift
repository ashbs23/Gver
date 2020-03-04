//
//  PendingThingsViewController.swift
//  Gver
//
//  Created by Md. Ashikul Hosen on 14/2/20.
//  Copyright © 2020 BS-23. All rights reserved.
//

import UIKit
import BSImageView
import BSImagePicker
import BSGridCollectionViewLayout
import Photos
import Firebase

class CreatePostViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var createPostLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var publishPostButton: UIButton!
    
    var firstTime = true
    var imageArray: [PHAsset] = []
    var imageCollection: [String] = []
    var imageFirestorageLinks: [String] = []
    let imageFileManagement = ImageFileManagement()
    let textFieldValidators = TextFieldValidators()
    let postManagementFirebase = PostManagementFirebase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = K.ViewTitle.createPost
        
        collectionView.delegate = self
        collectionView.dataSource = self
        descriptionTextView.delegate = self
        
        addressTextFieldDoubleTapped()
        updateUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if firstTime {
            self.tabBarController?.selectedIndex = 2
            firstTime = false
        }
        DispatchQueue.main.async {
            self.addressTextField.text = ProfileManagementFirestore.userInformation.address
        }
    }
    
    @IBAction func publishPostButtonPressed(_ sender: UIButton) {
        let check = textFieldValidators.isTextFieldEmpty(titleTextField)
        if check {
            textFieldValidators.showTextFieldInputNotValidError(for: titleTextField, string: "Enter a post title")
        } else {
            textFieldValidators.showTextFieldInputIsValid(for: titleTextField)
            DispatchQueue.main.async {
                self.addressTextField.text = ProfileManagementFirestore.userInformation.address ?? ""
            }
        }
        if !check {
            publishPostButton.isEnabled = false
            for asset in imageArray {
                asset.getURL { (url) in
                    self.imageFileManagement.saveImageInFireStorage(fileName: url!.absoluteString, postCheck: true)
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                self.imageFirestorageLinks = self.imageFileManagement.getImageURLStrings()
                print(self.imageFirestorageLinks)
                self.publishPost()
                self.publishPostButton.isEnabled = true
                self.titleTextField.text = ""
                self.descriptionTextView.text = ""
                self.imageArray.removeAll()
                self.imageCollection.removeAll()
                self.collectionView.reloadData()
                
            }
            tabBarController?.selectedIndex = 2
        }
    }
    
    func publishPost() {
        if let postTitle = titleTextField.text,
            let postDescription = descriptionTextView.text,
            let postAddress = addressTextField.text {
            postManagementFirebase.storePostToFirebase(postTitle: postTitle,
                                                       postDetails: postDescription,
                                                       postAddress: postAddress,
                                                       latitude: ProfileManagementFirestore.userInformation.latitude ?? 0.00,
                                                       longitude: ProfileManagementFirestore.userInformation.longitude ?? 0.00,
                                                       postImages: self.imageFirestorageLinks,
                                                       postTime: Date.timeIntervalBetween1970AndReferenceDate,
                                                       finished: false)
        }
    }
    
    @objc func removeImageButtonPressed(_ sender: UIButton!) {
        let hitPoint = sender.convert(CGPoint.zero, to: collectionView)
        let hitIndex: IndexPath? = collectionView.indexPathForItem(at: hitPoint)
        self.imageArray.remove(at: hitIndex!.row)
        self.imageCollection.remove(at: hitIndex!.row)
        self.collectionView.performBatchUpdates({
            self.collectionView.deleteItems(at: [hitIndex!])
        }) { (finished) in
            self.collectionView.reloadItems(at: self.collectionView.indexPathsForVisibleItems)
        }
    }
    
    @objc func doubleTapGoToMap() {
        performSegue(withIdentifier: K.SegueNames.createPostToMap, sender: self)
    }
    
    func addressTextFieldDoubleTapped() {
        let singleTapGesture = UITapGestureRecognizer(target: self, action: nil)
        singleTapGesture.numberOfTapsRequired = 1
        addressTextField.addGestureRecognizer(singleTapGesture)
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(doubleTapGoToMap))
        doubleTapGesture.numberOfTapsRequired = 2
        addressTextField.addGestureRecognizer(doubleTapGesture)
        singleTapGesture.require(toFail: doubleTapGesture)
    }
    
    func updateUI() {
        
        descriptionTextView.text = K.TextViewPlaceholderStrings.createPostDescriptionPlaceholder
        descriptionTextView.textColor = UIColor.lightGray
        
        updateView(createPostLabel)
        updateView(descriptionTextView)
        updateView(titleTextField)
        updateView(publishPostButton)
        updateView(addressTextField)
        
    }
    
    func updateView(_ sender: UIView) {
        sender.layer.borderColor = UIColor.init(named: "AppFocusedTextColor")?.cgColor
        sender.layer.borderWidth = 2.0
        sender.layer.cornerRadius = 10
        sender.clipsToBounds = true
    }
}

extension CreatePostViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = K.TextViewPlaceholderStrings.createPostDescriptionPlaceholder
            textView.textColor = UIColor.lightGray
        }
    }
}


extension CreatePostViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if imageArray.count == indexPath.row {
            singleTapMultipleImageSelection()
        }
        else {
            singleTapEnlargeImage(indexPath: indexPath)
        }
    }
    func singleTapEnlargeImage(indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell
        let imageView = cell.imageView
        let newImageView = UIImageView()
        newImageView.pin_updateWithProgress = true
        newImageView.pin_setImage(from: URL.init(string: imageCollection[indexPath.row] ), placeholderImage: imageView?.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
    func singleTapMultipleImageSelection() {
        let vc = BSImagePickerViewController()
        bs_presentImagePickerController(vc, animated: true,
                                        select: { (asset: PHAsset) -> Void in
                                            
        }, deselect: { (asset: PHAsset) -> Void in
            
        }, cancel: { (assets: [PHAsset]) -> Void in
            // User cancelled. And this where the assets currently selected.
            
        }, finish: { (assets: [PHAsset]) -> Void in
            self.imageArray += assets
            self.collectionView.reloadData()
            for asset in assets {
                asset.getURL { (url) in
                    self.imageCollection.append(url!.absoluteString)
                }
            }
            print(self.imageCollection)
        }, completion: {
            print(self.imageCollection)
        })
    }
}
