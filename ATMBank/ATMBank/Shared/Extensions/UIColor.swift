//
//  UIColor.swift
//  ATMBank
//
//  Created by Bao on 3/5/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(red >= 0 && red <= 255, "Invalid green component")
        assert(red >= 0 && red <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
}
