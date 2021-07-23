//
//  WeatherStatusPresenter.swift
//  weather
//
//  Created by Abdelrahman Sobhy on 23/07/2021.
//

import Foundation

class WeatherStatusPresenter{
    var view: WeatherStatusViewProtocol?
    var status: WeatherStatusResponse?
    
    func inject(view: WeatherStatusViewProtocol, model: WeatherStatusResponse) {
        self.view = view
        self.status = model
    
        presentData()
    }
    
    func presentData() {
        if let model = status {
            let condition = model.weather.count > 0 ? model.weather[0].main : ""
            
            let weatherData = WeatherData(place: model.name, condition: condition, tmp: toFehr(model.main.temp), tmpLow: toFehr(model.main.tempMin), tmpHigh: toFehr(model.main.tempMax), hum: String(model.main.humidity), pressure: String(model.main.pressure), feelsLike: toFehr(model.main.feelsLike)
            )
            self.view?.fillData(with: weatherData)
        }
    }
    
    func toFehr(_ kelvin: Double)-> String {
        return String(format: "%.2f", (kelvin - 273.15) * 9/5 + 32)
    }
    
}
