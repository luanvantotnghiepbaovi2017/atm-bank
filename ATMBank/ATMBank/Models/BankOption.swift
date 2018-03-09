//
//  BankOption.swift
//  ATMBank
//
//  Created by Bao on 3/5/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

enum BankOptionType {
    case branch
    case atm
    case website
    case phone
    case direction
    case defaultType
}

class BankOption {
    // MARK: Properties
    var id: String = ""
    var title: String = ""
    var type: BankOptionType = .defaultType
    
    init(id: String, title: String, type: BankOptionType) {
        self.id = id
        self.title = title
        self.type = type
    }
}
