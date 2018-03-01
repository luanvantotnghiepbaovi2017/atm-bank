//
//  Location.swift
//  ATMBank
//
//  Created by Bao on 2/25/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

class Location: Decodable {
    var lat: Double = 0.0
    var long: Double = 0.0
    
    enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case long = "long"
    }
    
    // MARK: Methods
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        lat = try container.decode(Double.self, forKey: .lat)
        long = try container.decode(Double.self, forKey: .long)
    }
    
    // Constructor default
    init() {}
    
    // Constructor parameter
    init(lat: Double, long: Double) {
        self.lat = lat
        self.long = long
    }
    
    // Constructor copy
    init(location: Location) {
        self.lat = location.lat
        self.long = location.long
    }
}
