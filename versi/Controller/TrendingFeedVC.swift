//
//  ViewController.swift
//  versi
//
//  Created by Kerim Deveci on 10.04.2020.
//  Copyright © 2020 Kerim Deveci. All rights reserved.
//

import UIKit

class TrendingFeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var trendingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.trendingTableView.delegate = self
        self.trendingTableView.dataSource = self
        DownloadService.instance.downloadTrendingReposDictArray { dictionary in
            print("finished downloading")
        }
    }

}

extension TrendingFeedVC{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier:"TrendingRepoCell")
                as? TrendingRepoCell {
            cell.configure(with: Repo(image: UIImage(named: "searchIconLarge")!, name: "SWIFT", description: "programming language", numberOfForks: 562, language: "Shifty", numberOfContributors: 12, repoUrl: "www.github.com"))
            return cell
        }
        return UITableViewCell()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
}
