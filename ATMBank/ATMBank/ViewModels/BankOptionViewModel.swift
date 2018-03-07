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
}

class BankOptionViewModel: BankOptionViewModelType {
    // MARK: Properties
    private var bankOptionList = Variable<[BankOption]>([])
    
    init() {
        initialBankOptionData()
    }
    
    private func initialBankOptionData() {
        let optionBank = BankOption(id: "1", title: "Ngân hàng")
        let optionATM = BankOption(id: "2", title: "ATM")
        let optionWebsite = BankOption(id: "3", title: "Trang chủ")
        bankOptionList.value = [optionBank, optionATM, optionWebsite]
    }
    
    func getBankOptions() -> Variable<[BankOption]> {
        return bankOptionList
    }
    
    func getBankOption(at indexPath: IndexPath) -> BankOption {
        return bankOptionList.value[indexPath.row]
    }
}


