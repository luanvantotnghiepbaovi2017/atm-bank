//
//  NearByBanksViewModel.swift
//  ATMBank
//
//  Created by Bao on 4/6/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

import Foundation
import RxSwift

protocol NearByBanksViewModelType: class {
    func setRadius(`with` newValue: Int)
    func setNewFilter(`with` type: FilterType)
}

enum FilterType {
    case bank
    case atm
}

class NearByBanksViewModel: NearByBanksViewModelType {
    // MARK: Properties
    private var _isATMFiltered: Bool = false
    private var _isBankFiltered: Bool = false
    private var _radius: Int = 500
    
    // MARK: SET Methods
    func setRadius(with newValue: Int) {
        _radius = newValue
        if _isATMFiltered {
            setNewFilter(with: .atm)
        } else {
            setNewFilter(with: .bank)
        }
    }
    
    func setNewFilter(with type: FilterType) {
        switch type {
        case .bank:
           
            break
        case .atm:
            
            break
        }
    }
    
    // MARK: GET Methods
    private func _getRadius() -> Int {
        return _radius
    }
}
