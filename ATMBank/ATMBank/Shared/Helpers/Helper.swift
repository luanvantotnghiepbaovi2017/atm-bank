//
//  Helper.swift
//  ATMBank
//
//  Created by Bao on 3/1/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

import Foundation
import RSLoadingView

class Helper {
    // MARK: Properties
    static var loadingView: RSLoadingView!
    class func isEmptyData(data: String) -> Bool {
        return data.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty
    }
    class func showLoadingView(effect: RSLoadingView.Effect, containerView: UIView) {
        loadingView = RSLoadingView(effectType: effect)
        loadingView.show(on: containerView)
    }
    class func hideLoadingView() {
        loadingView.hide()
    }
}
