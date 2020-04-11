//
// Created by Kerim Deveci on 10.04.2020.
// Copyright (c) 2020 Kerim Deveci. All rights reserved.
//

import Foundation
import UIKit

class RoundedBorderButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        layer.cornerRadius = frame.size.height / 2
        layer.borderWidth = 3
        layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
    }
}


