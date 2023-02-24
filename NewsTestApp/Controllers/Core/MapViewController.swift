//
//  MapViewController.swift
//  NewsTestApp
//
//  Created by Dmitry Gorbunow on 2/19/23.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        return mapView
    }()
    
    let manager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        mapView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "NABackground")
        view.addSubview(mapView)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            
            render(location)
        }
    }
    
    func render(_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: 56.826375, longitude: 60.58656)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)

        let pin1 = MKPointAnnotation()
        let pin2 = MKPointAnnotation()
        let pin3 = MKPointAnnotation()
        let pin4 = MKPointAnnotation()
        let pin5 = MKPointAnnotation()

        pin1.coordinate = CLLocationCoordinate2D(latitude: 56.826375, longitude: 60.58656)
        pin2.coordinate = CLLocationCoordinate2D(latitude: 56.82566916978184, longitude: 60.585251082000674)
        pin3.coordinate = CLLocationCoordinate2D(latitude: 56.8279037129551, longitude: 60.58726810317987)
        pin4.coordinate = CLLocationCoordinate2D(latitude: 56.828174292603386, longitude: 60.586087931213356)
        pin5.coordinate = CLLocationCoordinate2D(latitude: 56.82718607916505, longitude: 60.58445714813226)
        
        mapView.addAnnotation(pin1)
        mapView.addAnnotation(pin2)
        mapView.addAnnotation(pin3)
        mapView.addAnnotation(pin4)
        mapView.addAnnotation(pin5)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
        } else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = UIImage(named: "Vector")
        
        return annotationView
    }
}
