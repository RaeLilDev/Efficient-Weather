//
//  ChooseLocationVC.swift
//  Efficient-Weather
//
//  Created by Ye linn htet on 11/4/23.
//

import UIKit
import MapKit
import CoreLocation

class ChooseLocationVC: BaseVC {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var btnChoosePlace: UIButton!
    
    var viewModel: ChooseLocationViewModel!
    
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listen(for: viewModel)
        setupView()
        setupGestureRecognizers()
        bindData()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        manager.desiredAccuracy = kCLLocationAccuracyBest //battery
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        bindMapView()
    }
    
    private func setupView() {
        btnChoosePlace.layer.cornerRadius = 8.0
        enableBtnChoosePlace(false)
    }
    
    private func bindData() {
        viewModel.newPlace
            .skip(while: {$0 == nil})
            .subscribe(onNext: {[weak self] data in
                guard let _ = self else { return }
                AppCoordinator.shared.restart()
        }).disposed(by: disposeBag)
    }
    
    private func bindMapView() {
        if !viewModel.noPlaceExists() {
            let coordinate = CLLocationCoordinate2D(latitude: viewModel.getSelectedPlaceLat(), longitude: viewModel.getSelectedPlaceLon())
            setRegion(coordinate)
            setAnnotation(with: coordinate)
        }
    }

    private func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        mapView.isUserInteractionEnabled = true
        mapView.addGestureRecognizer(tapGesture)
    }

    @objc private func handleTap(gestureReconizer: UITapGestureRecognizer) {
        let location = gestureReconizer.location(in: mapView)
        let coordinate = mapView.convert(location,toCoordinateFrom: mapView)
        
        setAnnotation(with: coordinate)
    }
    
    @IBAction func onTapChoosePlace(_ sender: UIButton) {
        viewModel.fetchPlace()
    }

}

//MARK: - Location Manager Delegate
extension ChooseLocationVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            debugPrint("Location is \(location)")
            if viewModel.noPlaceExists() {
                render(location)
            }
        }
    }
    
    func render(_ location: CLLocation) {
        
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                                longitude: location.coordinate.longitude)
        setRegion(coordinate)
        
        setAnnotation(with: coordinate)
        
    }
    
    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
        let region = MKCoordinateRegion(center: coordinate,
                      span: span)
        mapView.setRegion(region, animated: true)
    }
    
    private func setAnnotation(with coordinate: CLLocationCoordinate2D) {
        // Add annotation:
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        
        viewModel.updateLocation(lat: Double(coordinate.latitude), lon: Double(coordinate.longitude))
        enableBtnChoosePlace(true)
        
        if mapView.annotations.count >= 1 {
            mapView.removeAnnotation(mapView.annotations.last!)
        }
        mapView.addAnnotation(annotation)
    }
    
    func enableBtnChoosePlace(_ state: Bool) {
        btnChoosePlace.isEnabled = state
        btnChoosePlace.alpha = state ? 1.0 : 0.5
    }
}

