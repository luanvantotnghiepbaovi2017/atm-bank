//
//  Constant.swift
//  ATMBank
//
//  Created by Bao on 2/25/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

import Foundation

let currentLanguage = Language.currentAppleLanguage()

struct JSONFileName {
    static let listOfBanksInVN = "ListOfBanksInVN"
}

struct UserDefaultKeys {
    static let PreferredLanguage = "PreferredLanguage"
}

struct LanguageCode {
    // English
    static let en = "en"
    // VietNam
    static let vn = "vi"
}
