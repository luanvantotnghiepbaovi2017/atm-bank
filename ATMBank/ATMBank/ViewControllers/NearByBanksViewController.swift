//
//  NearByBanksViewController.swift
//  ATMBank
//
//  Created by Tran Quoc Bao on 4/5/18.
//  Copyright © 2018 TranQuocBao. All rights reserved.
//

import UIKit
import GoogleMaps

class NearByBanksViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var containerFilterView: UIView!
    
    // MARK: IBActions
    @IBAction func buttonBankFilter(_ sender: Any) {
    }
    
    @IBAction func buttonRadiusFilter(_ sender: Any) {
    }
    
    // MARK: Properties
    /// GoogleMaps
    private var locationManager = CLLocationManager()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        _setUpMapView()
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
        //guard let userLocation = locations.last else { return }
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
