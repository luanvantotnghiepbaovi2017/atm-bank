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
    /// RxSwift
    private let _disposeBag = DisposeBag()
    /// GoogleMaps
    private struct GoogleMapsSetting {
        static let zoomLevel: Float = 13.0
    }
    private var _locationManager = CLLocationManager()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        _setUpMapView()
        _setButtonFilterTitle()
        _setUpUnderlineAppearance()
        _setUpContainerFilterViewAppearance(duration: 0.0)
        _setUpReactButton()
    }
    
    private func _setUpUnderlineAppearance() {
        underlineBankFilterView.alpha = 0.0
        underlineATMFilterView.alpha = 0.0
    }
    
    private func _setUpContainerFilterViewAppearance(duration: Double) {
        UIView.animate(withDuration: duration) {
            if self.containerFilterView.alpha == 0.0 {
                self.containerFilterView.alpha = 1.0
            } else {
                self.containerFilterView.alpha = 0.0
            }
        }
    }
    
    private func _updateUnderLineView(type: FilterType, duration: Double) {
        buttonBankFilter.resetFont()
        buttonATMFilter.resetFont()
        UIView.animate(withDuration: duration) {
            switch type {
            case .bank:
                self.underlineBankFilterView.alpha = 1.0
                self.underlineATMFilterView.alpha = 0.0
                self.buttonBankFilter.changeFont()
                break
            case .atm:
                self.underlineBankFilterView.alpha = 0.0
                self.underlineATMFilterView.alpha = 1.0
                self.buttonATMFilter.changeFont()
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
                strongSelf._updateUnderLineView(type: .bank, duration: 0.25)
            }
            .disposed(by: disposeBag)
        
        buttonATMFilter
            .rx
            .tap
            .subscribe { [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf._updateUnderLineView(type: .atm, duration: 0.25)
            }
            .disposed(by: disposeBag)
        
        buttonFilter
            .rx
            .tap
            .subscribe { [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf._setUpContainerFilterViewAppearance(duration: 0.25)
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
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest
        _locationManager.startUpdatingLocation()
        _enableLocationServices()
    }
    
    private func _enableLocationServices() {
        _locationManager.delegate = self
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            _locationManager.requestWhenInUseAuthorization()
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
        _locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied:
            break
        case .authorizedAlways:
            _locationManager.startUpdatingLocation()
            break
        case .authorizedWhenInUse:
            _locationManager.startUpdatingLocation()
            break
        case .notDetermined:
            break
        case .restricted: break
        }
    }
}
