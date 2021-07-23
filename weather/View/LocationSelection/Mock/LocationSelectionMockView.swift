//
//  LocationSelectionMockView.swift
//  weather
//
//  Created by Abdelrahman Sobhy on 23/07/2021.
//

import Foundation
import MapKit

class LocationSelectionMockView: LocationSelectionViewProtocol {
    var suggestions = [NSAttributedString]()
    var presenter = LocationSelectionPresenter()
    
    init() {
        self.presenter.inject(view: self)
    }
    
    func updateMap(with region: MKCoordinateRegion) {
    }
    
    func enableShowButton(_ enable: Bool) {
        
    }
    
    func updateSuggestions(locations: [NSAttributedString]) {
        self.suggestions = locations
    }
    
    func confirmLocation(location: NSAttributedString) {
        
    }
    
    func showWeather(status: WeatherStatusResponse) {
        
    }
    
    
}
