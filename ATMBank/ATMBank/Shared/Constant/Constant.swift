//
//  Constant.swift
//  ATMBank
//
//  Created by Bao on 2/25/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

import UIKit

let currentLanguage = Language.currentAppleLanguage()

struct JSONFileName {
    static let listOfBanksInVN = "ListOfBanksInVN"
}

struct UserDefaultKeys {
    static let PreferredLanguage = "PreferredLanguage"
}

struct Color {
    struct TableView {
        static let bankOptionBackgroundNormal = UIColor.white
        static let bankOptionBackgroundSelected = UIColor(red: 83, green: 119, blue: 145)
        static let bankOptionTextNormal = UIColor(red: 94, green: 94, blue: 94)
        static let bankOptionTextSelected = UIColor.white
    }
}

struct Font {
    struct Dialog {
        static let mainTitle = UIFont(name: "AvenirNext-Medium", size: 16.0) ?? UIFont.systemFont(ofSize: 16.0)
        static let optionTitle = UIFont(name: "AvenirNext-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
    }
}


struct LanguageCode {
    // English
    static let en = "en"
    // VietNam
    static let vn = "vi"
}
