//
//  UIViewControllerExt.swift
//  versi-teacher-build
//
//  Created by Caleb Stultz on 8/3/17.
//  Copyright © 2017 Caleb Stultz. All rights reserved.
//

import Foundation
import SafariServices

extension UIViewController {
    func presentSafariWebViewFor(url: String) {
        let repoUrl = URL(string: url + readmeSegment)
        let safariVC = SFSafariViewController(url: repoUrl!)
        present(safariVC, animated: true, completion: nil)
    }
}
