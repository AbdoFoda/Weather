//
//  LocationSelectionViewController.swift
//  weather
//
//  Created by Abdelrahman Sobhy on 21/07/2021.
//
import CoreLocation
import UIKit
import MapKit


protocol LocationSelectionViewProtocol {
    func updateMap(with region: MKCoordinateRegion)
    func enableShowButton(_ enable: Bool)
    func updateSuggestions(locations: [NSAttributedString])
    func confirmLocation(location: NSAttributedString)
    func showWeather(status: WeatherStatusResponse)
}

class LocationSelectionViewController: UIViewController {

    var locationSuggestions = [NSAttributedString]()
    var presenter = LocationSelectionPresenter()
    var selectedWeather: WeatherStatusResponse?
    
    //MARK:- Outlets
    @IBOutlet weak var tableViewSuggestions: UITableView!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var txtFieldLocation: UITextField!
    @IBOutlet weak var btnShow: UIButton!
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSuggestions.tableFooterView = UIView()
        self.presenter.inject(view: self)
    }
    
    
    @IBAction func locationTextFieldChanged(_ sender: UITextField) {
        if sender == txtFieldLocation {
            if sender.text!.count > 0 {
                self.enableShowButton(true)
                self.presenter.searchTextChanged(to: sender.text!)
            }else{
                self.enableShowButton(false)
            }
        }
    }
    @IBAction func btnShowTapped(_ sender: UIButton) {
        if let locationText = txtFieldLocation.attributedText, locationText.string.count > 0 {
            self.presenter.showResult(for: locationText)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? WeatherStatusViewController {
            vc.status = self.selectedWeather
        }
    }
}

//MARK:- View Protocol Extension
extension LocationSelectionViewController: LocationSelectionViewProtocol {
    func updateMap(with region: MKCoordinateRegion) {
        self.map.setRegion(region, animated: true)
    }
    
    func enableShowButton(_ enable: Bool) {
        btnShow.isEnabled = enable
        btnShow.setTitleColor(enable ? .blue : .gray, for: .normal)
    }
    
    func updateSuggestions(locations: [NSAttributedString]) {
        self.locationSuggestions = locations
        self.tableViewSuggestions.reloadData()
    }
    
    func confirmLocation(location: NSAttributedString) {
        txtFieldLocation.attributedText = location
    }

    func showWeather(status: WeatherStatusResponse) {
        self.selectedWeather = status
        self.performSegue(withIdentifier: "showWeatherStatus", sender: self)
    }
}


//MARK:- TableView extension
extension LocationSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationSuggestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell", for: indexPath) as? LocationTableViewCell {
            cell.lblLocation.attributedText = locationSuggestions[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.selectSuggestion(with: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

