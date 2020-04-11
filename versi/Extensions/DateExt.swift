//
//  DateExt.swift
//  versi-teacher-build
//
//  Created by Caleb Stultz on 8/2/17.
//  Copyright © 2017 Caleb Stultz. All rights reserved.
//

import Foundation

extension Date {
    func today() -> String {
        let date = Calendar.current.date(byAdding: .day, value: 0, to: self)!
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = formatter.string(from: date)
        return formattedDate
    }
}
