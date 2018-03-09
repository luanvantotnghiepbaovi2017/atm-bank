//
//  BankOptionViewModel.swift
//  ATMBank
//
//  Created by Bao on 3/5/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

import Foundation
import RxSwift

protocol BankOptionViewModelType: class {
    func getBankOptions() -> Variable<[BankOption]>
    func getBankOption(at indexPath: IndexPath) -> BankOption
    func getOptionCount() -> Int
}

class BankOptionViewModel: BankOptionViewModelType {
    // MARK: Properties
    private var bankOptionList = Variable<[BankOption]>([])
    
    init(options: [BankOption]) {
        bankOptionList.value = options
    }
    
    func getOptionCount() -> Int {
        return bankOptionList.value.count
    }
    
    func getBankOptions() -> Variable<[BankOption]> {
        return bankOptionList
    }
    
    func getBankOption(at indexPath: IndexPath) -> BankOption {
        return bankOptionList.value[indexPath.row]
    }
}


