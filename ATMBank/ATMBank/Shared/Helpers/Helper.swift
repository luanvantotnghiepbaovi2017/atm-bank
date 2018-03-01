//
//  Helper.swift
//  ATMBank
//
//  Created by Bao on 3/1/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

import Foundation

class Helper {
    class func isEmptyData(data: String) -> Bool {
        return data.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty
    }
}
