//
//  ViewController.swift
//  versi
//
//  Created by Kerim Deveci on 10.04.2020.
//  Copyright © 2020 Kerim Deveci. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TrendingFeedVC: UIViewController{

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var trendingTableView: UITableView!
    let disposeBag = DisposeBag()
    var dataSource = PublishSubject<[Repo]>()
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trendingTableView.refreshControl = refreshControl
        refreshControl.tintColor = #colorLiteral(red: 0.2784313725, green: 0.462745098, blue: 0.9019607843, alpha: 1)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Hot Github Repos 🔥", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2784313725, green: 0.462745098, blue: 0.9019607843, alpha: 1), NSAttributedString.Key.font: UIFont(name: "AvenirNext-DemiBold", size: 16.0)!])
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        
        fetchData()
        dataSource.bind(to: trendingTableView.rx.items(cellIdentifier: "TrendingRepoCell")) {
            (row, repo: Repo, cell: TrendingRepoCell) in
            cell.configure(with: repo)
        }.disposed(by: disposeBag)
    }
    
    @objc func fetchData() {
        DownloadService.instance.downloadTrendingRepos { (trendingRepoArray) in
            self.dataSource.onNext(trendingRepoArray)
            self.refreshControl.endRefreshing()
        }
    }
}
