//
//  UITextField.swift
//  ATMBank
//
//  Created by Bao on 2/27/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

import UIKit

extension UITextField {
    func paddingLeft(value: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: value, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
