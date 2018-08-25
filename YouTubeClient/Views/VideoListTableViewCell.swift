//
//  VideoListTableViewCell.swift
//  YouTubeClient
//
//  Created by Kazuki Tanaka on 2018/08/22.
//  Copyright © 2018年 Kazuki Tanaka. All rights reserved.
//

import UIKit
import GoogleAPIClientForREST
import Nuke

class VideoListTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    func configure(entity: GTLRYouTube_SearchResultSnippet) {

        if let urlString = entity.thumbnails?.medium?.url,
            let url = URL(string: urlString) {

            Nuke.loadImage(with: url,
                           into: self.thumbnailImageView)
        }
        if let title = entity.title {
            self.titleLabel.text = title
        }
    }
}
