//
//  VideoListViewController.swift
//  YouTubeClient
//
//  Created by Kazuki Tanaka on 2018/08/22.
//  Copyright © 2018年 Kazuki Tanaka. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import GoogleAPIClientForREST

class VideoListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    fileprivate let disposeBag = DisposeBag()
    fileprivate let playlistFactory = VideoPlaylistFactory()
    fileprivate var selectedVideoEntity: GTLRYouTube_SearchResult!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.bindData()
        self.bindUI()
        self.fetchPlaylist()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R.segue.videoListViewController.pushDetailSegue.identifier,
            let vc = segue.destination as? VideoDetailViewController {

            vc.videoEntity = self.selectedVideoEntity
        }
    }
}

extension VideoListViewController {
    private func fetchPlaylist() {
        self.playlistFactory.search()
    }

    private func bindData() {
        self.playlistFactory
            .result
            .bind(to: self.tableView.rx.items) { tableView, row, element in

                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: R.reuseIdentifier.videoListTableViewCell,
                    for: IndexPath(row: row, section: 0)),
                    let entity: GTLRYouTube_SearchResultSnippet = element.snippet else {
                        return UITableViewCell()
                }

                cell.configure(entity: entity)
                return cell
            }
            .disposed(by: disposeBag)
    }

    private func bindUI() {
        self.tableView
            .rx
            .modelSelected(GTLRYouTube_SearchResult.self)
            .bind(onNext: { [weak self](element) in

                self?.selectedVideoEntity = element
                self?.performSegue(
                    withIdentifier: R.segue.videoListViewController.pushDetailSegue.identifier,
                    sender: nil
                )
            }).disposed(by: disposeBag)
    }
}
