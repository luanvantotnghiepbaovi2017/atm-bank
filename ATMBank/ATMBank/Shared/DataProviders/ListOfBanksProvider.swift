//
//  ListOfBanksProvider.swift
//  ATMBank
//
//  Created by Bao on 2/25/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

import Foundation
import RxSwift

final class ListOfBanksProvider {
    // MARK: Can't init is singleton
    private init() {}
    
    // MARK: Shared Instance
    static let shared = ListOfBanksProvider()
    
    // MARK: Methods
    func getListOfBanksFromFile(with filename: String) -> Observable<[Bank]> {
        return Observable.create({ (observer) -> Disposable in
            if let path = Bundle.main.path(forResource: filename, ofType: "json") {
                let url = URL(fileURLWithPath: path)
                do {
                    let data = try Data(contentsOf: url)
                    let listOfBanks = try JSONDecoder().decode([Bank].self, from: data)
                    observer.onNext(listOfBanks)
                } catch let error {
                    observer.onError(error)
                }
            }
            return Disposables.create {
                print("created success List Of Banks Disposables")
            }
        })
    }
}
