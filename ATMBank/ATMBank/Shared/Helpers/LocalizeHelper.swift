//
//  File.swift
//  Local
//
//  Created by mobile03 on 9/11/17.
//  Copyright © 2017 Wish. All rights reserved.
//

import Foundation

final class LocalizeHelper {

    // Can't init is singleton
    private init() { }

    // MARK: Shared Instance
    static let shared = LocalizeHelper()
    
    // MARK: Properties
    var privatePreferredBundle: Bundle?
    var preferredBundle: Bundle? {
        if self.privatePreferredBundle == nil {
            loadPreferredBundle()
        }
        return self.privatePreferredBundle
    }
    
    // MARK: Methods
    func localizedStringForKey(key: String) -> String {
        var result: String!
        if preferredBundle != nil {
            result = preferredBundle?.localizedString(forKey: key, value: nil, table: nil)
        }
        if result == nil {
            result = key
        }
        return result
    }
    
    func setPreferred(language: String) {
        self.savePreferred(language: language)
        loadPreferredBundle()
    }
    
    func loadPreferredBundle() {
        if let languageCode = getPreferredLanguage() {
            if let bundlePath = Bundle.main.path(forResource: "Localizable",
                                                 ofType: "strings",
                                                 inDirectory: nil,
                                                 forLocalization: languageCode) {
                self.privatePreferredBundle = Bundle.init(path: (bundlePath as NSString).deletingLastPathComponent)
            }
        }
        if self.privatePreferredBundle == nil {
            self.privatePreferredBundle = Bundle.main
        }
    }
    
    func getPreferredLanguage() -> String? {
        return UserDefaults.standard.string(forKey: UserDefaultKeys.PreferredLanguage)
    }
    
    func savePreferred(language: String ) {
        UserDefaults.standard.set(language, forKey: UserDefaultKeys.PreferredLanguage)
    }
}
