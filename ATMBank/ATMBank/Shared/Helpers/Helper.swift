//
//  Helper.swift
//  ATMBank
//
//  Created by Bao on 3/1/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

import Foundation
import RSLoadingView
import GoogleMaps

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
    class func moveMapViewCameraTo(position: Location, zoomLevel: Float, mapView: GMSMapView) {
        let position = CLLocationCoordinate2DMake(position.lat, position.long)
        let camera = GMSCameraPosition.camera(withTarget: position, zoom: zoomLevel)
        mapView.animate(to: camera)
    }
}
