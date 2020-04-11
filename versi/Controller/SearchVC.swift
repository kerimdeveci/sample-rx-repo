//
//  SearchVC.swift
//  versi
//
//  Created by Kerim Deveci on 10.04.2020.
//  Copyright © 2020 Kerim Deveci. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SearchVC: UIViewController, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchField: RoundedBorderTextField!

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindElements()
        searchTableView.rx.setDelegate(self).disposed(by: disposeBag)
        // Do any additional setup after loading the view.
    }
    
    func bindElements (){
        let searchResultsObservable = searchField.rx.text
            .orEmpty.debounce(RxTimeInterval.milliseconds(700), scheduler: MainScheduler.instance)
            .map{
                $0.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""}
            .flatMap { (query) -> Observable<[Repo]> in
            if query == "" {
                return Observable<[Repo]>.just([])
            }
            guard let url = URL(string: searchUrl + query + starsDescSegment) else{return Observable<[Repo]>.just([])}
            var searchRepos = [Repo]()
            return URLSession.shared.rx.json(url: url).map{
                let results = $0 as AnyObject
                let items = results.object(forKey: "items") as? [[String : Any]] ?? []
                for item in items{
                    guard let name = item["name"] as? String,
                            let description = item["description"] as? String,
                            let numberOfForks = item["forks_count"] as? Int,
                            let language = item["language"] as? String,
                            let repoUrl = item["html_url"] as? String else { break }
                    let repo = Repo(image: UIImage(named: "searchIconLarge")!, name: name, description: description, numberOfForks: numberOfForks, language: language, numberOfContributors: 0, repoUrl: repoUrl)
                    
                    searchRepos.append(repo)
                }
                return searchRepos
            } }
            .observeOn(MainScheduler.instance)
        
        searchResultsObservable.bind(to: searchTableView.rx.items(cellIdentifier: "SearchCell")){
            (row, repo: Repo, cell: SearchCell) in
            cell.configureCell(repo: repo)
        }.disposed(by: disposeBag)
    }
}

extension SearchVC {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        guard let cell = tableView.cellForRow(at: indexPath) as? SearchCell else { return }
        print(cell.repoUrl as Any)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true) // hide keyboard vs
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
