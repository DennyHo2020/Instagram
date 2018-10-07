//
//  PostCell.swift
//  Instagram
//
//  Created by Denny Ho on 10/6/18.
//  Copyright © 2018 Denny Ho. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class PostCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var photoImageView: PFImageView!
    @IBOutlet weak var bottomUserLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var instagramPost: Post! {
        didSet {
            self.photoImageView.file = instagramPost.media
            self.photoImageView.loadInBackground()
            self.captionLabel.text = instagramPost.caption
            self.dateLabel.text = instagramPost.createdAt?.description
            self.usernameLabel.text = instagramPost.author.username
            self.bottomUserLabel.text = instagramPost.author.username
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
