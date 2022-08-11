//
//  TheaterViewController.swift
//  TMDBProject
//
//  Created by 최윤제 on 2022/08/12.
//

import UIKit

import MapKit

class TheaterViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterButtonClicekd))
        
        TheaterList.mapAnnotations.forEach { theater in
            setAnnotation(title: theater.location, latitude: theater.latitude, longitude: theater.longitude)
        }
        
        let center = CLLocationCoordinate2D(latitude: 37.504098, longitude: 126.963829)
        setRegion(center: center, meters: 15000)
        
    }
    
    func setRegion(center: CLLocationCoordinate2D, meters: Double) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: meters, longitudinalMeters: meters)
        mapView.setRegion(region, animated: true)
    }
    
    func setAnnotation(title: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let annotation = MKPointAnnotation()
              let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
              annotation.coordinate = center
              annotation.title = title
              
              //지도에 핀 추가
              mapView.addAnnotation(annotation)
    }
    
    @objc
    func filterButtonClicekd() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let lotte = UIAlertAction(title: "롯데시네마", style: .default) { _ in
            let center = CLLocationCoordinate2D(latitude: TheaterList.mapAnnotations[0].latitude, longitude: TheaterList.mapAnnotations[0].longitude)
            self.setRegion(center: center, meters: 1000)
        }
        let mega = UIAlertAction(title: "메가박스", style: .default) { _ in
            let center = CLLocationCoordinate2D(latitude: TheaterList.mapAnnotations[3].latitude, longitude: TheaterList.mapAnnotations[3].longitude)
            self.setRegion(center: center, meters: 1000)
        }
        let cgv = UIAlertAction(title: "CGV", style: .default) { _ in
            let center = CLLocationCoordinate2D(latitude: TheaterList.mapAnnotations[4].latitude, longitude: TheaterList.mapAnnotations[4].longitude)
            self.setRegion(center: center, meters: 1000)
        }
        let all = UIAlertAction(title: "전체보기", style: .default) { _ in
            let center = CLLocationCoordinate2D(latitude: 37.504098, longitude: 126.963829)
            self.setRegion(center: center, meters: 15000)
        }
        alert.addAction(cancel)
        alert.addAction(lotte)
        alert.addAction(mega)
        alert.addAction(cgv)
        alert.addAction(all)
        present(alert, animated: true, completion: nil)
    }



}
