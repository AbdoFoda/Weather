//
//  WeatherAPI.swift
//  weather
//
//  Created by Abdelrahman Sobhy on 23/07/2021.
//

import Foundation
import CoreLocation
import Alamofire

class WeatherAPI {
    
    static let apiURL = "https://api.openweathermap.org/data/2.5/weather"
    static let appId = "0b06849b08b0df0c233b3baad94dfc79"
    
    static func getWeather(for location: CLLocation, completion: @escaping (WeatherStatusResponse)->Void) {
        let parameters = [
            "lat" : location.coordinate.latitude,
            "lon": location.coordinate.longitude,
            "appId": appId
        ] as [String: Any]
        
        let req = AF.request(apiURL,
                   method: .get,
                   parameters: parameters,
                   headers: nil)
            
            
        req.validate()
        .responseDecodable(of: WeatherStatusResponse.self) { (response) in
            guard let status = response.value else {return}
            completion(status)
        }
    }
    
    static func getWeather(for address: String, completion: @escaping (WeatherStatusResponse)->Void) {
        let parameters = [
            "q" : address,
            "appId": appId
        ]
        
        let req = AF.request(apiURL,
                   method: .get,
                   parameters: parameters,
                   headers: nil)
            
            
        req.validate()
        .responseDecodable(of: WeatherStatusResponse.self) { (response) in
            guard let status = response.value else {return}
            completion(status)
        }
    }
    
}
