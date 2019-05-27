//
//  FirstViewController.swift
//  PokeMap
//
//  Created by Pedro Lopes on 01/05/19.
//  Copyright © 2019 Pedro Lopes. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase

class MapViewController: UIViewController {
    
    private let locationManager = CLLocationManager()
    private var currentCoords = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    private var spawnedPokemons = 0
    
    @IBOutlet var mapView: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.mapView.delegate = self

        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.startUpdatingLocation()
  
        self.mapView.isMyLocationEnabled = true
        self.mapView.settings.myLocationButton = true
        //self.setupMapView()
    }
    
    func setupMapView() {
        
        let camera = GMSCameraPosition.camera(withLatitude: currentCoords.latitude,
                                              longitude: currentCoords.longitude,
                                              zoom: 16.0)
        self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        //self.view = mapView
    }
    
    func createPokeMarks() {
        
        for _ in 1 ... UserDefaultsManager().pokemonSpawnLimit() {

            let newLat = self.currentCoords.latitude + Double.random(in: PokemonMinLatDistance ... PokemonMaxLatDistance)
            let newLong = self.currentCoords.longitude + Double.random(in: PokemonMinLonDistance ... PokemonMaxLonDistance)
            let markCoord = CLLocationCoordinate2D(latitude: newLat, longitude: newLong)

            let marker = GMSMarker(position: markCoord)
            
            let markerIcon = UIImage(named: "pokeball")
            let markerIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            markerIconView.image = markerIcon
            
            marker.iconView = markerIconView
            marker.map = self.mapView
        }
        
        self.spawnedPokemons = UserDefaultsManager().pokemonSpawnLimit()
    }
}

extension MapViewController: GMSMapViewDelegate{
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        var titleText: String = ""
        var messageText: String = ""
        let captured = Int.random(in: 0...100)
        
        let poke = Int.random(in: 1...PokemonMaxNumber)
        
        var pokeName = "Pokemon"
        if GlobalPokeList.count >= poke{
            pokeName = GlobalPokeList[poke].name
        }
        
        if captured <= UserDefaultsManager().pokemonCaptureRatio() {
            
            titleText = WinTitle
            messageText = WinText + pokeName
            marker.map = nil
            self.spawnedPokemons -= 1
            
            if self.spawnedPokemons == 0 {
                self.createPokeMarks()
            }
            
            UserDefaultsManager().addPokemon(number: poke)
            
        } else {
            
            titleText = LossTitle
            messageText = pokeName + LossText
        }
        
        let captureAlert = UIAlertController(title: titleText, message: messageText, preferredStyle: UIAlertController.Style.alert)
        
        captureAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(captureAlert, animated: true, completion: nil)
    
        return true
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
        
        if location.coordinate.latitude > self.currentCoords.latitude + RefreshSpawnDistance ||
           location.coordinate.latitude < self.currentCoords.latitude - RefreshSpawnDistance ||
           location.coordinate.longitude > self.currentCoords.longitude + RefreshSpawnDistance ||
           location.coordinate.longitude < self.currentCoords.longitude - RefreshSpawnDistance {
            
                mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            
                self.currentCoords = location.coordinate
                self.createPokeMarks()
        }
    }
}

