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
    
    private lazy var activityStartView: ActivityStartView = {
        var view = ActivityStartView()
        view.delegate = self
        return view
    }()
    
    private var activityPauseStopView: ActivityPauseStopView = {
        var view = ActivityPauseStopView()
        view.isHidden = true
        return view
    }()
    
    private var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        return manager
    }()
    
    public var dataSource: [ActivityStartItem] = [
        ActivityStartItem(title: "Велосипед", image: UIImage(named: "bikeImage"), type: .bike),
        ActivityStartItem(title: "Бег", image: UIImage(named: "bikeImage"), type: .run),
        ActivityStartItem(title: "Ходьба", image: UIImage(named: "bikeImage"), type: .walking)
    ]
    
    var timerAdd = Timer()
    
    var coordsArray: [CLLocationCoordinate2D] = []
    var isFirstLoad: Bool = true
    var selectedActivityStartItem: ActivityStartItem?
    
    var activity: ActivityEntity = ActivityEntity()
    var activityTimeStart: Date = Date()
    var activityType: String = ""
    var acivityDistance: Double = 0.0
    var activityTimeFinish: Date = Date()
    var timerData = 0
    
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
            locationManager.stopUpdatingLocation()
        }
        
        setupViews()
        layoutViews()
        setUp()
        timerAction()
        
        selectedActivityStartItem = dataSource[0]
        
        activityPauseStopView.pauseButton.addTarget(self, action: #selector(pauseButtonTap), for: .touchUpInside)
        
        activityPauseStopView.finishButton.addTarget(self, action: #selector(finishButtonTap), for: .touchUpInside)
        
        activityStartView.dataSource = dataSource
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func setupViews() {
        view.addSubview(mapView)
        view.addSubview(activityStartView)
        view.addSubview(activityPauseStopView)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityStartView.heightAnchor.constraint(equalToConstant: 287),
            activityStartView.leftAnchor.constraint(equalTo: view.leftAnchor),
            activityStartView.rightAnchor.constraint(equalTo: view.rightAnchor),
            activityStartView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityPauseStopView.heightAnchor.constraint(equalToConstant: 230),
            activityPauseStopView.leftAnchor.constraint(equalTo: view.leftAnchor),
            activityPauseStopView.rightAnchor.constraint(equalTo: view.rightAnchor),
            activityPauseStopView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
    
    @objc func timerAction() {
        
        let hours = timerData / 3600
        
        let minutes = timerData / 60 % 60
        
        let seconds = timerData % 60
        
        let restTime = ((hours<10) ? "0" : "") + String(hours) + ":" + ((minutes<10) ? "0" : "") + String(minutes) + ":" + ((seconds<10) ? "0" : "") + String(seconds)
        
        timerData = timerData + 1
        
        activityPauseStopView.timeLabel.text = "\(restTime)"
    }
    
    @objc func pauseButtonTap() {
        
        if (activityPauseStopView.pauseButton.isSelected) {
            activityPauseStopView.pauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            
            locationManager.startUpdatingLocation()
            
            timerAdd = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        } else {
            activityPauseStopView.pauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            
            locationManager.stopUpdatingLocation()
            
            timerAdd.invalidate()
        }
        
        activityPauseStopView.pauseButton.isSelected.toggle()
    }
    
    @objc func finishButtonTap() {
        locationManager.stopUpdatingLocation()
        timerAdd.invalidate()
        activityTimeFinish = Date()
        
        navigationController?.popViewController(animated: true)
        savetoCoreData()
    }
    
    func savetoCoreData() {
        let activity = ActivityEntity(context: FEFUCoreDataContainer.instance.context)
        activity.distance = acivityDistance
        activity.startTime = activityTimeStart
        activity.finishTime = Date()
        activity.type = activityType
        activity.timerData = timerData
        FEFUCoreDataContainer.instance.saveContext()
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
        
        let from = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        
        if let lastAddedLocation = coordsArray.last {
            
            let distance = lastAddedLocation.distance(from: from)
            
            acivityDistance += distance
        }
        
        coordsArray.append(userLocation.coordinate)
        addCoordLabel()
        drawLines()
    }
    
    func addCoordLabel() {
        let value = Double(acivityDistance * 1000).rounded() / 1000
        let roundText = String(format: "%.1f", value)
        
        activityPauseStopView.distanceLabel.text = "\(roundText) км"
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

extension CreateActivityViewController: ActivityStartViewProtocol {
    
    func didStartButtonTapped() {
        
        locationManager.startUpdatingLocation()
        
        timerAdd.invalidate()
        
        timerAdd = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
        activityPauseStopView.typeLabel.text = selectedActivityStartItem?.title
        
        activityStartView.isHidden = true
        activityPauseStopView.isHidden = false
        
        activityTimeStart = Date()
        activityType = selectedActivityStartItem?.title ?? ""
        
    }
    
    func selectItem(_ index: Int) {
        selectedActivityStartItem = dataSource[index]
    }
}

extension CLLocationCoordinate2D {
    
    func distance(from: CLLocationCoordinate2D) -> CLLocationDistance {
        let from = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let to = CLLocation(latitude: self.latitude, longitude: self.longitude)
        return from.distance(from: to)
    }
}


