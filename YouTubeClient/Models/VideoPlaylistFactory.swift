//
//  VideoPlaylistFactory.swift
//  YouTubeClient
//
//  Created by Kazuki Tanaka on 2018/08/22.
//  Copyright © 2018年 Kazuki Tanaka. All rights reserved.
//

import RxSwift
import GoogleAPIClientForREST

class VideoPlaylistFactory {
    let result = BehaviorSubject<[GTLRYouTube_SearchResult]>(value: [])

    func search(keyward: String = "音楽",
                maxResult: UInt = 50) {

        let query = GTLRYouTubeQuery_SearchList.query(withPart: "snippet")
        query.q = keyward
        query.type = "video"
        query.maxResults = maxResult

        let service = GTLRYouTubeService()
        service.apiKey = "YOUR_API_KEY"

        service.executeQuery(query) { (_, object, error) in
            if error != nil {
                self.result.onNext([])
                return
            }
            guard let response = object as? GTLRYouTube_SearchListResponse,
                let playlist = response.items else {
                    self.result.onNext([])
                    return
            }

            self.result.onNext(playlist)
        }
    }
}
