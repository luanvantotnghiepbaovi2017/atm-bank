//
//  UIButton.swift
//  ATMBank
//
//  Created by Bao on 4/6/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

import UIKit

import UIKit

extension UIButton {
    enum FontType {
        case regular
        case medium
        
        static func getTypeBy(fontName: String) -> FontType {
            if fontName.lowercased().range(of:"medium") != nil {
                return .medium
            }
            return .regular
        }
    }
    
    func changeFont() {
        guard let fontName = titleLabel?.font.fontName, let fontSize = self.titleLabel?.font.pointSize else { return }
        let fontType = FontType.getTypeBy(fontName: fontName)
        var avenirNextFont: UIFont
        switch fontType {
        case .regular:
            avenirNextFont = Helper.setFontAvenirNextMedium(with: fontSize)
            break
        case .medium:
            avenirNextFont = Helper.setFontAvenirNextRegular(with: fontSize)
            break
        }
        self.titleLabel?.font = avenirNextFont
    }
    func resetFont() {
        guard let fontSize = self.titleLabel?.font.pointSize else { return }
        let avenirNextFont: UIFont = Helper.setFontAvenirNextRegular(with: fontSize)
        self.titleLabel?.font = avenirNextFont
    }
}
