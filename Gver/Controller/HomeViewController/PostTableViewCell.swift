//
//  PostTableViewCell.swift
//  Gver
//
//  Created by Md. Ashikul Hosen on 3/3/20.
//  Copyright © 2020 BS-23. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var postTagLabel: UILabel!
    @IBOutlet weak var postDetails: UILabel!
    @IBOutlet weak var postDistanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }
    
    func updateUI() {
        cellView.layer.cornerRadius = cellView.frame.size.height / 5
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
        updateView(cellView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateView(_ sender: UIView) {
        sender.layer.borderColor = UIColor.init(named: "AppFocusedTextColor")?.cgColor
        sender.layer.borderWidth = 1.0
        sender.layer.cornerRadius = 15
        sender.clipsToBounds = true
    }
}
