//
//  WeatherStatusViewController.swift
//  weather
//
//  Created by Abdelrahman Sobhy on 23/07/2021.
//

import UIKit

class WeatherStatusViewController: UIViewController {

    var status: WeatherStatusResponse?
    
    @IBOutlet weak var lblPlace: UILabel!
    @IBOutlet weak var lblCondition: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblHigh: UILabel!
    @IBOutlet weak var lblLow: UILabel!
    @IBOutlet weak var lblPressure: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    
    @IBOutlet weak var lblFeelsLike: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let weather = status {
            self.lblPlace.text = weather.name
            if weather.weather.count > 0 {
                self.lblCondition.text = weather.weather[0].main
            }
            self.lblTemp.text = toFehr(weather.main.temp)
            self.lblLow.text = toFehr(weather.main.tempMin)
            self.lblHigh.text = toFehr(weather.main.tempMax)
            self.lblHumidity.text = String(weather.main.humidity)
            self.lblPressure.text = String(weather.main.pressure)
            self.lblFeelsLike.text = toFehr(weather.main.feelsLike)
        }
    }
    
    
    func toFehr(_ kelvin: Double)-> String {
        return String(format: "%.2f", (kelvin - 273.15) * 9/5 + 32)
    }
    
   
}
