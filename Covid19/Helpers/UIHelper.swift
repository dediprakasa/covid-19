//
//  UIHelper.swift
//  Covid19
//
//  Created by Dedi Prakasa on 5/10/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

struct UIHelper {
    static func getDescriptionLabelHeight(text: String, fontSize: Int, inView view: UIView, padding: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width - 2 * padding, height: CGFloat.greatestFiniteMagnitude))

        label.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        label.text = text
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        print(label.frame.height)
        return label.frame.height
    }
}
