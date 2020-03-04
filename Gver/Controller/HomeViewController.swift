//
//  HomeViewController.swift
//  Gver
//
//  Created by Md. Ashikul Hosen on 9/2/20.
//  Copyright © 2020 BS-23. All rights reserved.
//

import UIKit
import Firebase
import PINRemoteImage
import CoreLocation

class HomeViewController: UIViewController {
    
    let profileManagementFirestore = ProfileManagementFirestore()
    let postManagementFirestore = PostManagementFirebase()
    @IBOutlet weak var tableView: UITableView!
    var posts: [PostInformation] = []
    var userInformation: UserInformation!
    private let refreshControl = UIRefreshControl()
    private let activityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.ReusableTableCells.postTableViewCellNibName, bundle: nil), forCellReuseIdentifier: K.ReusableTableCells.postTableViewCell)
        addRefreshControll()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileManagementFirestore.loadProfileFromFirebase()
        print("From home")
        postManagementFirestore.loadPostFromFirebase() { [weak self] _, post in
            self!.posts = post
            self!.tableView.reloadData()
        }
        print(posts)
        removeTabbarItemsText()
    }
    
    func removeTabbarItemsText() {
        if let items = tabBarController?.tabBar.items {
            for item in items {
                item.title = ""
                item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0);
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.SegueNames.homeToPost, sender: self)
    }
}

extension HomeViewController {
    func addRefreshControll() {
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(reloadPosts), for: .valueChanged)
        refreshControl.tintColor = UIColor(named: "AppFocusedTextColor")
    }
    
    @objc func reloadPosts() {
        self.activityIndicatorView.startAnimating()
        postManagementFirestore.loadPostFromFirebase() { [weak self] _, post in
            self!.posts = post
            self!.tableView.reloadData()
        }
        self.refreshControl.endRefreshing()
        self.activityIndicatorView.stopAnimating()
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(posts.count)
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.ReusableTableCells.postTableViewCell, for: indexPath) as! PostTableViewCell
        DispatchQueue.main.async() {
            cell.postTagLabel.text = self.posts[indexPath.row].postTitle
            cell.postDetails.text = self.posts[indexPath.row].postDetails
            cell.profileImageView.pin_setImage(from: URL.init(string: self.posts[indexPath.row].profileImageURLString ?? "Icon"), placeholderImage: UIImage(named: "Icon"))
            let locationFrom = CLLocation.init(
                latitude: ProfileManagementFirestore.userInformation.latitude!,
                longitude: ProfileManagementFirestore.userInformation.longitude!)
            let locationTo = CLLocation.init(
                latitude: self.posts[indexPath.row].latitude!,
                longitude: self.posts[indexPath.row].longitude!)
            let distance = locationFrom.distance(from: locationTo) / 1000
            if distance == 0.0 {
                cell.postDistanceLabel.text = "You are giving away this one"
            } else {
                cell.postDistanceLabel.text = String(distance.rounded(toPlaces: 2)) + " km away from here"
            }
        }
        return cell
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
