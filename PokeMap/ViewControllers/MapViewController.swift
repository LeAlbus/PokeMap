//
//  FirstViewController.swift
//  PokeMap
//
//  Created by Pedro Lopes on 01/05/19.
//  Copyright © 2019 Pedro Lopes. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    private let locationManager = CLLocationManager()
    var currentCoords = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    private var mapView = GMSMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.startUpdatingLocation()
  
        self.setupMapView()
    }
    
    func setupMapView() {
        
        let camera = GMSCameraPosition.camera(withLatitude: currentCoords.latitude,
                                              longitude: currentCoords.longitude,
                                              zoom: 16.0)
        self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.view = mapView
        
    }
    
    func createPokeMarks(_ marks: Int) {
        
        for _ in 1 ... marks {

            let newLat = self.currentCoords.latitude + Double.random(in: -0.004 ... 0.004)
            let newLong = self.currentCoords.longitude + Double.random(in: -0.003 ... 0.003)
            let markCoord = CLLocationCoordinate2D(latitude: newLat, longitude: newLong)

            let marker = GMSMarker(position: markCoord)
            
            let markerIcon = UIImage(named: "pokeball")
            let markerIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            markerIconView.image = markerIcon
            
            marker.iconView = markerIconView
            marker.map = self.mapView
        }

    }
}

extension MapViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      
        let location = locations[0]
        
        self.currentCoords = location.coordinate
        self.setupMapView()
        self.createPokeMarks(5)
    }
}

