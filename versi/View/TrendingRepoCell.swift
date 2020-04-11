//
// Created by Kerim Deveci on 10.04.2020.
// Copyright (c) 2020 Kerim Deveci. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class TrendingRepoCell: UITableViewCell {
    
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoDescription: UILabel!
    @IBOutlet weak var repoImage: UIImageView!
    @IBOutlet weak var downloadCount: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var contributionCount: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var viewReadmeButton: UIButton!
    var repoUrl: String?
    let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backView.layer.cornerRadius = 15
        backView.layer.shadowColor = UIColor(red:0.188, green:0.188, blue:0.188, alpha: 1.000).cgColor
        backView.layer.shadowOpacity = 0.5
        backView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backView.layer.shadowRadius = 6
    }
    
    func configure(with repo: Repo){
        
        viewReadmeButton.rx.tap.subscribe(onNext: {
            [weak self] in
            guard let self = self else { return }
            self.window?.rootViewController?.presentSafariWebViewFor(url: self.repoUrl!)
            }).disposed(by: disposeBag)
        
        
        repoImage.image = repo.image
        repoDescription.text = repo.description
        repoName.text = repo.name
        downloadCount.text = String(repo.numberOfForks)
        contributionCount.text = String(repo.numberOfContributors)
        languageLabel.text = repo.language
        repoUrl = repo.repoUrl
    }
}
