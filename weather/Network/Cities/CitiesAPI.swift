//
//  CitiesAPI.swift
//  weather
//
//  Created by Abdelrahman Sobhy on 25/07/2021.
//

import Foundation
import Alamofire
class CitiesAPI {
    
    static let apiURL = "https://countriesnow.space/api/v0.1/countries"
    
    static func getCities(completion: @escaping (CitiesResponse)->Void) {
        let req = AF.request(apiURL)
    
        req.validate()
        .responseDecodable(of: CitiesResponse.self) { (response) in
            guard let citiesData = response.value else {return}
            completion(citiesData)
        }
        
    }
    
    
}
