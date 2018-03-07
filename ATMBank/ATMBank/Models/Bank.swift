//
//  Bank.swift
//  ATMBank
//
//  Created by Bao on 2/25/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

class Bank: Decodable {
    // MARK: Properties
    var id: String = ""
    var fullnameVN: String = ""
    var fullnameVNForSearch: String = ""
    var fullnameEN: String = ""
    var fullNameENForSearch: String = ""
    var shortname: String = ""
    var website: String = ""
    var thumbnail: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case fullnameVN = "fullname_vn"
        case fullnameEN = "fullname_en"
        case shortname = "shortname"
        case website = "website"
        case thumbnail = "thumbnail"
    }
    
    // MARK: Methods
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        fullnameVN = "Ngân hàng \(try container.decode(String.self, forKey: .fullnameVN))"
        if fullnameVN.uppercased().contains(find: "Đ") {
            fullnameVNForSearch = fullnameVN.uppercased().replacingOccurrences(of: "Đ", with: "D") .removeDiacritic()
        } else {
            fullnameVNForSearch = fullnameVN.uppercased().removeDiacritic()
        }
        fullnameEN = try container.decode(String.self, forKey: .fullnameEN)
        fullNameENForSearch = fullnameEN.uppercased()
        shortname = try container.decode(String.self, forKey: .shortname)
        website = try container.decode(String.self, forKey: .website)
        thumbnail = try container.decode(String.self, forKey: .thumbnail)
    }
    
    // Constructor default
    init() {}
    
    // Constructor parameter
    init(id: String, fullnameVN: String, fullnameVNForSearch: String, fullnameEN: String, shortname: String, website: String, thumbnail: String) {
        self.id = id
        self.fullnameVN = fullnameVN
        self.fullnameVNForSearch = fullnameVNForSearch
        self.fullnameEN = fullnameEN
        self.shortname = shortname
        self.website = website
        self.thumbnail = thumbnail
    }
    
    // Constructor copy
    init(bank: Bank) {
        self.id = bank.id
        self.fullnameVN = bank.fullnameVN
        self.fullnameVNForSearch = bank.fullnameVNForSearch
        self.fullnameEN = bank.fullnameEN
        self.shortname = bank.shortname
        self.website = bank.website
        self.thumbnail = bank.thumbnail
    }
}
