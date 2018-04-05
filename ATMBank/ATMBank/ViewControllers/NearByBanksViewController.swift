//
//  NearByBanksViewController.swift
//  ATMBank
//
//  Created by Tran Quoc Bao on 4/5/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

import UIKit
import GoogleMaps
import RxCocoa
import RxSwift

class NearByBanksViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var containerFilterView: UIView!
    @IBOutlet weak var underlineBankFilterView: UIView!
    @IBOutlet weak var underlineATMFilterView: UIView!
    @IBOutlet weak var buttonBankFilter: UIButton!
    @IBOutlet weak var buttonATMFilter: UIButton!
    @IBOutlet weak var buttonRadiusFilter: UIButton!
    @IBOutlet weak var buttonFilter: UIButton!
    
    // MARK: Properties
    struct GoogleMapsSetting {
        static let zoomLevel: Float = 13.0
    }
    
    enum UnderlineType {
        case bank
        case atm
    }
    
    let disposeBag = DisposeBag()
    
    /// GoogleMaps
    private var locationManager = CLLocationManager()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        _setUpMapView()
        _setButtonFilterTitle()
        _setUpUnderlineAppearance()
        _setUpReactButton()
    }
    
    private func _setUpUnderlineAppearance() {
        underlineBankFilterView.alpha = 0.0
        underlineATMFilterView.alpha = 0.0
    }
    
    private func _updateUnderLineView(type: UnderlineType) {
        UIView.animate(withDuration: 0.25) {
            switch type {
            case .bank:
                self.underlineBankFilterView.alpha = 1.0
                self.underlineATMFilterView.alpha = 0.0
                break
            case .atm:
                self.underlineBankFilterView.alpha = 0.0
                self.underlineATMFilterView.alpha = 1.0
                break
            }
        }
    }
    
    private func _setUpReactButton() {
        buttonBankFilter
            .rx
            .tap
            .subscribe { [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf._updateUnderLineView(type: .bank)
            }
            .disposed(by: disposeBag)
        
        buttonATMFilter
            .rx
            .tap
            .subscribe { [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf._updateUnderLineView(type: .atm)
            }
            .disposed(by: disposeBag)
    }
    
    private func _setButtonFilterTitle() {
        buttonBankFilter.setTitle("near_by_banks_button_bank_filter_title".localized, for: .normal)
        buttonATMFilter.setTitle("near_by_banks_button_atm_filter_title".localized, for: .normal)
        buttonRadiusFilter.setTitle("near_by_banks_button_radius_filter_title".localized, for: .normal)
    }
    
    private func _setUpMapView() {
        mapView.isMyLocationEnabled = true
        //mapView.delegate = self
        mapView.settings.myLocationButton = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        _enableLocationServices()
    }
    
    private func _enableLocationServices() {
        locationManager.delegate = self
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            locationManager.requestWhenInUseAuthorization()
            break
            
        case .denied:
            break
            
        case .authorizedWhenInUse, .authorizedAlways:
            // Enable basic location features
            break
            
        case .restricted:
            // Nothing we can do, app can not use location service
            break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("didReceiveMemoryWarning")
    }
    
    deinit {
        print("NearByBanksViewController is deinit")
    }
}

// MARK: CLLocationManagerDelegate
extension NearByBanksViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else { return }
        let currentLocation = Location(lat: userLocation.coordinate.latitude, long: userLocation.coordinate.longitude)
        Helper.moveMapViewCameraTo(position: currentLocation, zoomLevel: GoogleMapsSetting.zoomLevel, mapView: mapView)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied:
            break
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            break
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            break
        case .notDetermined:
            break
        case .restricted: break
        }
    }
}
