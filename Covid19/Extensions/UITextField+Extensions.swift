//
//  UITextField+Extensions.swift
//  Covid19
//
//  Created by Dedi Prakasa on 5/8/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

extension UITextField {
    func setUnderLine() {
        let border = CALayer()
        let width = CGFloat(1)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width-10, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
