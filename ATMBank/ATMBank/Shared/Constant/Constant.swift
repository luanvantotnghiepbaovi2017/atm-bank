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

struct LanguageCode {
    // English
    static let en = "en"
    // VietNam
    static let vn = "vi"
}
