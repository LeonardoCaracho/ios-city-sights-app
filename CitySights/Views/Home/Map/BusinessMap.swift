//
//  BusinessMap.swift
//  CitySights
//
//  Created by Leonardo Caracho on 19/04/23.
//

import SwiftUI
import MapKit

struct BusinessMap: UIViewRepresentable {
    @EnvironmentObject var model: ContentModel
    
    var locations:[MKPointAnnotation] {
        var annotations = [MKPointAnnotation]()
        
        for business in model.restaurants + model.sights {
            if let lat = business.coordinates?.latitude, let lng = business.coordinates?.longitude {
                let a = MKPointAnnotation()
                a.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                a.title = business.name ?? ""
                annotations.append(a)
            }
        }
        
        return annotations
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations)
        uiView.showAnnotations(self.locations, animated: true)
    }
    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        uiView.removeAnnotations(uiView.annotations)
    }
}
