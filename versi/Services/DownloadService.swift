//
// Created by Kerim Deveci on 10.04.2020.
// Copyright (c) 2020 Kerim Deveci. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class DownloadService {
    static let instance = DownloadService()
    
    func downloadTrendingReposDictArray(completion: @escaping (_ reposDictArray: [Dictionary<String, Any>]) -> ()) {
        
        var trendingReposArray = [Dictionary<String, Any>]()
        AF.request(trendingRepoUrl).responseJSON { (response) in
            switch response.result {
            case .success(let trendingRepos):
                guard let json = trendingRepos as? Dictionary<String, Any> else { return }
                guard let repoDictionaryArray = json["items"] as? [Dictionary<String, Any>] else { return }
                for repoDict in repoDictionaryArray {
                    if trendingReposArray.count <= 9 {
                        var repoDictionary = Dictionary<String, Any> ()
                        if let name = repoDict["name"] as? String {
                            repoDictionary["name"] = name
                        }
                        if let description = repoDict["description"] as? String{
                            repoDictionary["description"] = description
                        }
                        if let numberOfForks = repoDict["forks_count"] as? Int{
                            repoDictionary["forks_count"] = numberOfForks
                        }
                        if let language = repoDict["language"] as? String{
                            repoDictionary["language"] = language
                        }else {repoDictionary["language"] = "No Language" }
                        if let repoUrl = repoDict["html_url"] as? String{
                            repoDictionary["html_url"] = repoUrl
                        }
                        if let contributorsUrl = repoDict["contributors_url"] as? String{
                             repoDictionary["contributors_url"] = contributorsUrl
                        }
                        if let ownerDict = repoDict["owner"] as? Dictionary<String, Any>{
                            if let avatarUrl = ownerDict["avatar_url"] as? String {
                                repoDictionary["avatar_url"] = avatarUrl
                            }
                        }
                        
                        trendingReposArray.append(repoDictionary)
                    } else {
                        break
                    }
                }
                completion(trendingReposArray)
            case .failure(_):
                print("error happened in fetch")
            }
        }
    }
    
    func downloadTrendingRepos(completion: @escaping (_ reposArray: [Repo]) -> ()) {
        var reposArray = [Repo]()
        downloadTrendingReposDictArray { (trendingReposDictArray) in
            for dict in trendingReposDictArray {
                self.downloadTrendingRepo(fromDictionary: dict, completion: { (returnedRepo) in
                    if reposArray.count < 9 {
                        reposArray.append(returnedRepo)
                    } else {
                        let sortedArray = reposArray.sorted(by: { (repoA, repoB) -> Bool in
                            if repoA.numberOfForks > repoB.numberOfForks {
                                return true
                            } else {
                                return false
                            }
                        })
                        completion(sortedArray)
                    }
                })
            }
        }
    }
    
    func downloadTrendingRepo(fromDictionary dict: Dictionary<String, Any>, completion: @escaping (_ repo: Repo) -> ()) {
        let avatarUrl = dict["avatar_url"] as! String
        let contributorsUrl = dict["contributors_url"] as! String
        let name = dict["name"] as! String
        let description = dict["description"] as! String
        let numberOfForks = dict["forks_count"] as! Int
        let language = dict["language"] as! String
        let repoUrl = dict["html_url"] as! String
        
        downloadImageFor(avatarUrl: avatarUrl) { (returnedImage) in
            self.downloadContributorsDataFor(contributorsUrl: contributorsUrl, completion: { (returnedContributions) in
                let repo = Repo(image: returnedImage, name: name, description: description, numberOfForks: numberOfForks, language: language, numberOfContributors: returnedContributions, repoUrl: repoUrl)
                completion(repo)
            })
        }
    }
    
    func downloadImageFor(avatarUrl: String, completion: @escaping (_ image: UIImage) -> ()) {
        AF.request(avatarUrl).responseImage { (imageReponse) in
            if case .success(let image) = imageReponse.result {
                completion(image)
            }
        }
    }
    
    func downloadContributorsDataFor(contributorsUrl: String, completion: @escaping (_ contributors: Int) -> ()) {
        AF.request(contributorsUrl).responseJSON { (response) in
            if case .success(let json) = response.result {
                guard let jsonDic = json as? [Dictionary<String, Any>] else {
                    completion(0)
                    return
                }
                if !jsonDic.isEmpty {
                    let contributions = jsonDic.count
                    completion(contributions)
                }
            }
        }
    }
}
