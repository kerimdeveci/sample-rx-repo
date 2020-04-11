//
// Created by Kerim Deveci on 10.04.2020.
// Copyright (c) 2020 Kerim Deveci. All rights reserved.
//

import UIKit

class RoundedBorderTextField : UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        arrangeView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        arrangeView()
    }
    
    func arrangeView() {
        let placeholder = NSMutableAttributedString(string: self.placeholder!,
                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor(red:0.314, green:0.255, blue:0.941, alpha: 1.000)])
        attributedPlaceholder = placeholder
    
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        layer.cornerRadius = frame.size.height / 2
        layer.borderWidth = 3 //
        layer.borderColor = UIColor(red:0.345, green:0.553, blue:0.922, alpha: 1.000).cgColor
    }
}
