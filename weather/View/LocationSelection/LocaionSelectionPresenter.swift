//
//  LocaionSelectionPresenter.swift
//  weather
//
//  Created by Abdelrahman Sobhy on 23/07/2021.
//

import Foundation
import CoreLocation
import MapKit

class LocationSelectionPresenter: NSObject {
    
    var view: LocationSelectionViewProtocol?
    var locationManager: CLLocationManager?
    let currentLocation = NSAttributedString(string: "Current Location", attributes: [.foregroundColor: UIColor.blue])
    var lastRecordedLocation: CLLocation?
    
    func inject(view: LocationSelectionViewProtocol) {
        self.view = view
        self.view?.updateSuggestions(locations: [currentLocation])
        self.view?.enableShowButton(false)
    }
    
    override init() {
        super.init()
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func getCurrentLocation() {
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager?.requestAlwaysAuthorization()
            locationManager?.startUpdatingLocation()
        }
    }
    
    func selectSuggestion(with index: Int) {
        if index == 0 {
            self.view?.confirmLocation(location: currentLocation)
            self.getCurrentLocation()
        }
        self.view?.enableShowButton(true)
    }
    
    
    func showResult(for location: NSAttributedString) {
        if location.string == currentLocation.string {
            if let locationQuery = lastRecordedLocation {
                WeatherAPI.getWeather(for: locationQuery) { weatherStatus in
                    self.view?.showWeather(status: weatherStatus)
                }
            }
        }else {
            WeatherAPI.getWeather(for: location.string) { weatherStatus in 
                self.view?.showWeather(status: weatherStatus)
            }
        }
    }
    
    
}


extension LocationSelectionPresenter: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
        {
        if let location = locations.last {
            
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
            self.view?.updateMap(with: region)
            self.lastRecordedLocation = location
        }
    }
}
