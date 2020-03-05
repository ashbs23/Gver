//
//  PostViewController.swift
//  Gver
//
//  Created by Md. Ashikul Hosen on 4/3/20.
//  Copyright © 2020 BS-23. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postAddress: UILabel!
    @IBOutlet weak var postDescription: UILabel!
    @IBOutlet weak var bidButton: UIButton!
    @IBOutlet weak var postImageCollectionView: UICollectionView!
    
    var post: PostInformation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postImageCollectionView.dataSource = self
        postImageCollectionView.delegate = self
        updateUI()
        
    }
    
    func updateUI() {
        updateView(postTitle)
        updateView(bidButton)
        updateView(postImageView)
        updateView(postImageCollectionView)
    }
    
    func updateView(_ sender: UIView) {
        sender.layer.borderColor = UIColor.init(named: "AppFocusedTextColor")?.cgColor
        sender.layer.borderWidth = 2.0
        sender.layer.cornerRadius = 10
        sender.clipsToBounds = true
    }
    
}

extension PostViewController: UICollectionViewDelegate {
    
}

extension PostViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.imageView.image = UIImage(named: "Icon")
        updateView(cell.imageView)
        return cell
    }
    
    
}
