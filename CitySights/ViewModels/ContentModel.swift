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
    
    @Published var restaurants = [Business]()
    @Published var sights = [Business]()
    @Published var authorizationState = CLAuthorizationStatus.notDetermined
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        //        locationManager.startUpdatingLocation()
    }
    
    // MARK: - Location manager delegate methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.authorizationState = locationManager.authorizationStatus
        
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
        
        getBussiness(category: Constants.sightsKey, location: userLocation!)
        getBussiness(category: Constants.restaurantsKey, location: userLocation!)
    }
    
    func getBussiness(category:String, location:CLLocation) {
        var urlComponents = URLComponents(string: Constants.apiUrl)
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "6")
        ]
        
        if let url = urlComponents?.url {
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue(Constants.apiKey, forHTTPHeaderField: "Authorization")
            
            let session = URLSession.shared
            
            session.dataTask(with: request) { (data, response, error) in
                if error == nil {
                    do {
                        let result = try JSONDecoder().decode(BusinessSearch.self, from: data!)
                        
                        var business = result.businesses
                        
                        business.sort { (b1, b2) -> Bool in
                            return b1.distance ?? 0 < b2.distance ?? 0
                        }
                        
                        for b in business {
                            b.getImageData()
                        }
                        
                        DispatchQueue.main.async {
                            switch category {
                            case Constants.sightsKey:
                                self.sights = business
                            case Constants.restaurantsKey:
                                self.restaurants = business
                            default:
                                break
                            }
                        }
                        
                    }
                    catch {
                        print(error)
                    }
                }
            }.resume()
        }
    }
}
