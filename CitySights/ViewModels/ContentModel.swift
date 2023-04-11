//
//  ContentModel.swift
//  CitySights
//
//  Created by Leonardo Caracho on 24/03/23.
//

import Foundation
import CoreLocation

class ContentModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        //        locationManager.startUpdatingLocation()
    }
    
    // MARK: - Location manager delegate methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if locationManager.authorizationStatus == .authorizedAlways ||
            locationManager.authorizationStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
        else if locationManager.authorizationStatus == .denied {
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.first
        
        if userLocation != nil {
            locationManager.stopUpdatingHeading()
        }
        
        getBussiness(category: "arts", location: userLocation!)
    }
    
    func getBussiness(category:String, location:CLLocation) {
        let urlString = "https://api.yelp.com/v3/businesses/search?latitute=\(location.coordinate.latitude)&\(location.coordinate.longitude)&categories=\(category)&limit=6"
        
        var urlComponents = URLComponents(string: "https://api.yelp.com/v3/businesses/search")
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longiture", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "6")
        ]
        
        if let url = urlComponents?.url {
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue("Bearer i8d60b1WL0C9nTN0PTJRBXTVvaVDzcQw4xL9xZoXHMK9z32YXYF7UmBXbYEupzknQOgHBCvZ320JaK8X2mtHFCQRnPmiAD9YkOtw7kUDwOcRlSIW8jsnif191xUuZHYx", forHTTPHeaderField: "Authorization")
            
            let session = URLSession.shared
            
            session.dataTask(with: request) { (data, response, error) in
                if error == nil {
                    print(response)
                }
            }.resume()
        }
    }
}
