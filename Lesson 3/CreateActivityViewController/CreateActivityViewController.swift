//
//  MapViewController.swift
//  fefuactivity
//
//  Created by Котик on 26.05.2022.
//

import UIKit
import MapKit
import CoreLocation


class CreateActivityViewController:  UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.showsUserLocation = true
        mapView.delegate = self
        return mapView
    }()
    
    private var activityStart: ActivityStartView = {
        var view = ActivityStartView()
        return view
    }()
    
    private var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        return manager
    }()
    
    var coordsArray: [CLLocationCoordinate2D] = []
    
    var isFirstLoad: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Новая активность"
        view.backgroundColor = .systemBackground
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Check for Location Services
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        setupViews()
        layoutViews()
        setUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    func setupViews() {
        view.addSubview(mapView)
        view.addSubview(activityStart)
        
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
                 mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                 mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
                 mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
                 mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                 
                 activityStart.heightAnchor.constraint(equalToConstant: 287),
                 activityStart.leftAnchor.constraint(equalTo: view.leftAnchor),
                 activityStart.rightAnchor.constraint(equalTo: view.rightAnchor),
                 activityStart.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setUp() {
        // location manager
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        //Map view settings
        mapView.delegate = self
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.center = view.center
        
        determineCurrentLocation()
    }
    
    func drawLines() {
        
        let testLine = MKPolyline(coordinates: coordsArray, count: coordsArray.count)
        mapView.addOverlay(testLine)
        guard let first = coordsArray.first, let last = coordsArray.last else { return }
        
        let starAnnotaion = MKPointAnnotation()
        starAnnotaion.coordinate = first
        
        
        let finishAnnotaion = MKPointAnnotation()
        finishAnnotaion.coordinate = last
        
        mapView.addAnnotation(starAnnotaion)
        mapView.addAnnotation(finishAnnotaion)
    }
    
    func determineCurrentLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation:CLLocation = locations[0] as CLLocation
        if isFirstLoad {
            let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            mapView.setRegion(region, animated: true)
            isFirstLoad = false
        }
        
        coordsArray.append(userLocation.coordinate)
        drawLines()
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if let polyline = overlay as? MKPolyline {
            let testlineRenderer = MKPolylineRenderer(polyline: polyline)
            testlineRenderer.fillColor = .blue
            testlineRenderer.strokeColor = .blue
            testlineRenderer.lineWidth = 5.0
            return testlineRenderer
        }
        
        return MKOverlayRenderer(overlay: overlay)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if let annotation = annotation as? MKUserLocation {
            let dequedView = mapView.dequeueReusableAnnotationView(withIdentifier: "")
            let view = dequedView ?? MKAnnotationView(annotation: annotation, reuseIdentifier: "")
            
            view.image = UIImage(named: "pointLocation")
            return view
        }
        
        return nil
    }
}





