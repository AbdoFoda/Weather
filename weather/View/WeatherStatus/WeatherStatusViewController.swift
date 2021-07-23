//
//  WeatherStatusViewController.swift
//  weather
//
//  Created by Abdelrahman Sobhy on 23/07/2021.
//

import UIKit

struct WeatherData {
    var place, condition, tmp, tmpLow, tmpHigh, hum, pressure, feelsLike: String
}

protocol WeatherStatusViewProtocol {
    func fillData(with: WeatherData)
}

class WeatherStatusViewController: UIViewController {

    
    var presenter = WeatherStatusPresenter()
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
            presenter.inject(view: self, model: weather)
        }
    }
}


extension WeatherStatusViewController: WeatherStatusViewProtocol {
    
    func fillData(with weather: WeatherData) {
        self.lblPlace.text = weather.place
        self.lblCondition.text = weather.condition
        self.lblTemp.text = weather.tmp
        self.lblLow.text = weather.tmpLow
        self.lblHigh.text = weather.tmpHigh
        self.lblHumidity.text = weather.hum
        self.lblPressure.text = weather.pressure
        self.lblFeelsLike.text = weather.feelsLike
    }
    
}
