//
//  ListOfBanksViewModel.swift
//  ATMBank
//
//  Created by Bao on 2/25/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

import Foundation
import RxSwift

protocol ListOfBanksViewModelType: class {
    func getListOfBanks() -> Variable<[Bank]>
    func getBank(at indexPath: IndexPath) -> Bank
    func searchBank(value: String)
    func resetToOriginalBankList()
}

class ListOfBanksViewModel: ListOfBanksViewModelType {
    // MARK: Properties
    private var bankList = Variable<[Bank]>([])
    private var originalBankList = [Bank]()
    private var disposeBag = DisposeBag()
    
    // MARK: Get Methods
    func getListOfBanks() -> Variable<[Bank]> {
        return bankList
    }
    
    func getBank(at indexPath: IndexPath) -> Bank {
        return bankList.value[indexPath.row]
    }
    
    func searchBank(value: String) {
        var searchBank = [Bank]()
        let searchText = value.removingWhitespaces().uppercased().removeDiacritic()
        if currentLanguage == LanguageCode.vn {
            for bank in originalBankList {
                if bank.fullnameVNForSearch.contains(find: searchText) {
                    searchBank.append(bank)
                }
                else if bank.shortnameForSearch.contains(find: searchText) {
                    searchBank.append(bank)
                }
            }
        } else {
            for bank in originalBankList {
                if bank.fullNameENForSearch.contains(find: searchText) {
                    searchBank.append(bank)
                }
                else if bank.shortnameForSearch.contains(find: searchText) {
                    searchBank.append(bank)
                }
            }
        }
        bankList.value = searchBank
    }
    
    func resetToOriginalBankList() {
        bankList.value = originalBankList
    }
    
    // MARK: Methods
    init() {
        ListOfBanksProvider
            .shared
            .getListOfBanksFromFile(with: JSONFileName.listOfBanksInVN)
            .subscribe(onNext: { [weak self] (banks) in
                guard let strongSelf = self else { return }
                strongSelf.bankList.value = banks
                strongSelf.originalBankList = banks
            }, onError: { (error) in
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
}
