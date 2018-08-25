//
//  VideoDetailViewController.swift
//  YouTubeClient
//
//  Created by Kazuki Tanaka on 2018/08/22.
//  Copyright © 2018年 Kazuki Tanaka. All rights reserved.
//

import UIKit
import GoogleAPIClientForREST
import youtube_ios_player_helper

class VideoDetailViewController: UIViewController {
    @IBOutlet weak var playerView: YTPlayerView!

    var videoEntity: GTLRYouTube_SearchResult!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.playerView.delegate = self

        if let entity = self.videoEntity,
            let videoId = entity.identifier?.videoId {

            self.loadVideo(videoId: videoId)
        }
    }
}

extension VideoDetailViewController {
    private func loadVideo(videoId: String = "") {

        let playerVars = [
            "playsinline": 1
        ]
        self.playerView.load(withVideoId: videoId,
                             playerVars: playerVars)
    }
}

extension VideoDetailViewController: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        self.playerView.playVideo()
    }
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {}
    func playerView(_ playerView: YTPlayerView, didChangeTo quality: YTPlaybackQuality) {}
    func playerView(_ playerView: YTPlayerView, receivedError error: YTPlayerError) {}
    func playerView(_ playerView: YTPlayerView, didPlayTime playTime: Float) {}
    func playerViewPreferredWebViewBackgroundColor(_ playerView: YTPlayerView) -> UIColor { return .black }
    func playerViewPreferredInitialLoading(_ playerView: YTPlayerView) -> UIView? { return nil }
}
