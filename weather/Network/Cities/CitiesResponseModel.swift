//
//  CitiesResponseModel.swift
//  weather
//
//  Created by Abdelrahman Sobhy on 25/07/2021.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let citiesResponse = try? newJSONDecoder().decode(CitiesResponse.self, from: jsonData)

import Foundation

// MARK: - CitiesResponse
struct CitiesResponse: Codable {
    let error: Bool
    let msg: String
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let country: String
    let cities: [String]
}
