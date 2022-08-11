//
//  MapViewController.swift
//  TMDBProject
//
//  Created by 최윤제 on 2022/08/12.
//

import UIKit

import MapKit
import SwiftUI

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager() // 선언시에 locationManagerDidChangeAuthorization 함수 실행
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        
        TheaterList.mapAnnotations.forEach { theater in
            setAnnotation(title: theater.location, latitude: theater.latitude, longitude: theater.longitude)
        }
            
        
        
        
    }
    
    func setRegion(center: CLLocationCoordinate2D, meters: Double) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: meters, longitudinalMeters: meters)
        mapView.setRegion(region, animated: true)
    }
    
    func setAnnotation(title: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let annotation = MKPointAnnotation()
              let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
              annotation.coordinate = center
              annotation.title = "이곳은 동대구역 입니다"
              
              //지도에 핀 추가
              mapView.addAnnotation(annotation)
    }
    
    

}

extension MapViewController {
    func checkUserDeviceLocationServiceAuthorization() {
        let authorizationStatus: CLAuthorizationStatus // 사용자의 권한 확인을 담을 변수 생성
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        //사용자의 기기에 위치사용 기능이 켜져있는지 확인!
        if CLLocationManager.locationServicesEnabled() {
            //위치 서비스가 활성화 되어 있으므로, 위치 권한 요청 가능해서 위치 권한을 요청함
            checkUserCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("위치 서비스가 꺼져 있어서 위치 권한 요청을 못합니다.")
            showRequestLocationServiceAlert()
        }
        
    }
    
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest //정확도 지정
            locationManager.requestWhenInUseAuthorization() // 권한 요청
        case .restricted, .denied:
            let center = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
            setRegion(center: center, meters: 1000)
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation() // didUpdateLocation 함수 실행
        default: print("DEFAULT")
        }
    }
    
    func showRequestLocationServiceAlert() {
      let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
      let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
          if let appSetting = URL(string: UIApplication.openSettingsURLString) {
              UIApplication.shared.open(appSetting)
          }
      }
      let cancel = UIAlertAction(title: "취소", style: .default)
      requestLocationServiceAlert.addAction(cancel)
      requestLocationServiceAlert.addAction(goSetting)
      
      present(requestLocationServiceAlert, animated: true, completion: nil)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            setRegion(center: coordinate, meters: 1000)
        }
        
        //위치 업데이트 멈춰!
        locationManager.startUpdatingLocation()

    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("위치를 가지고 올 수 없담")
    }
    //14이상
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserDeviceLocationServiceAuthorization()
    }
    //14미만
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkUserDeviceLocationServiceAuthorization()
    }
    
}
