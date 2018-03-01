//
//  Language.swift
//  TCA
//
//  Created by Tran Quoc Bao on 1/4/18.
//  Copyright © 2018 Tran Quoc Bao. All rights reserved.
//

import UIKit

// constants
let APPLE_LANGUAGE_KEY = "AppleLanguages"
/// L102Language
class Language {
    /// get current Apple language
    class func currentAppleLanguage() -> String{
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        let startIndex = current.startIndex
        let index = current.index(startIndex, offsetBy: 2)
        let currentLang = current[..<index]
        return String(currentLang)
    }
    
    class func currentAppleLanguageFull() -> String{
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        return current
    }
    
    /// set @lang to be the first in Applelanguages list
    class func setAppleLanguageTo(lang: String) {
        let userdef = UserDefaults.standard
        userdef.set([lang], forKey: APPLE_LANGUAGE_KEY)
        userdef.synchronize()
    }
}
