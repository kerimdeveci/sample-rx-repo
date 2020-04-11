//
// Created by Kerim Deveci on 10.04.2020.
// Copyright (c) 2020 Kerim Deveci. All rights reserved.
//

import Foundation
import UIKit

class Repo {
    public private(set) var image: UIImage
    public private(set)var name: String
    public private(set)var description: String
    public private(set)var numberOfForks: Int
    public private(set)var language: String
    public private(set)var numberOfContributors: Int
    public private(set)var repoUrl: String
    
    init(image: UIImage,
         name: String,
         description: String,
         numberOfForks: Int,
         language: String,
         numberOfContributors: Int,
         repoUrl: String){
        self.name = name
        self.image = image
        self.description = description
        self.numberOfForks = numberOfForks
        self.language = language
        self.numberOfContributors = numberOfContributors
        self.repoUrl = repoUrl
    }
}
