//
//  BikeRentalZoneDetailVC.swift
//  BikeRental-MVVM
//
//  Created by DenizCagilligecit on 19.04.2021.
//

import UIKit
import MapKit
class BikeRentalZoneDetailVC: UIViewController {
  let zoneNameLabel = UILabel()
  let bikeCountLabel = UILabel()
  let bikeImage = UIImageView()
  let lastActiveLabel = UILabel()
  let bikeIcon = UIImageView()
  let routeButton = UIButton()
  var lat: CLLocationDegrees?
  var lon: CLLocationDegrees?
  var viewModel: BRZoneDetailProtocol? {
    didSet {
      viewModel?.delegate = self
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    title = "Zone Detail"
    viewModel?.load()
    configBikeImage()
    configZoneNameLabel()
    configBikeCountLabel()
    configBikeIcon()
    configLastActiveLabel()
    configureRouteButton()
  }
  func configureRouteButton() {
    view.addSubview(routeButton)
    routeButton.titleLabel?.textAlignment = .center
    routeButton.layer.cornerRadius = 10
    routeButton.setTitle("Route", for: .normal)
    routeButton.titleLabel!.font = UIFont(name: "Helvetica", size: 20)
    routeButton.backgroundColor = .darkGray
    routeButton.translatesAutoresizingMaskIntoConstraints = false
    routeButton.addTarget(self, action: #selector(go), for: .touchUpInside)

    NSLayoutConstraint.activate([
      routeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
      routeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
      routeButton.heightAnchor.constraint(equalToConstant: 50),
      routeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)

    ])
  }
  @objc func go() {
    let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: lat!, longitude: lon!)))
    destination.name = "Destination"

    MKMapItem.openMaps(
      with: [destination],
      launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
    )

  }

  func configZoneNameLabel() {
    view.addSubview(zoneNameLabel)

    zoneNameLabel.translatesAutoresizingMaskIntoConstraints = false
    zoneNameLabel.sizeToFit()
    zoneNameLabel.font = UIFont(name: "Helvetica", size: 25)
    NSLayoutConstraint.activate([
      zoneNameLabel.topAnchor.constraint(equalTo: bikeImage.bottomAnchor, constant: 30),
      zoneNameLabel.leadingAnchor.constraint(equalTo: bikeImage.leadingAnchor),
      zoneNameLabel.heightAnchor.constraint(equalToConstant: 40)
    ])

  }
  func configBikeCountLabel() {
    view.addSubview(bikeCountLabel)
    bikeCountLabel.sizeToFit()
    bikeCountLabel.translatesAutoresizingMaskIntoConstraints = false
    bikeCountLabel.font = UIFont(name: "Helvetica", size: 25)

    NSLayoutConstraint.activate([
      bikeCountLabel.topAnchor.constraint(equalTo: zoneNameLabel.bottomAnchor, constant: 10),
      bikeCountLabel.leadingAnchor.constraint(equalTo: zoneNameLabel.leadingAnchor),
      bikeCountLabel.heightAnchor.constraint(equalToConstant: 40)
    ])

  }
  func configBikeIcon() {
    view.addSubview(bikeIcon)
    bikeIcon.image = UIImage(named: "bicycle.png")
    bikeIcon.contentMode = .scaleToFill
    bikeIcon.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      bikeIcon.leadingAnchor.constraint(equalTo: bikeCountLabel.trailingAnchor, constant: 5),
      bikeIcon.centerYAnchor.constraint(equalTo: bikeCountLabel.centerYAnchor),
      bikeIcon.heightAnchor.constraint(equalToConstant: 40),
      bikeIcon.widthAnchor.constraint(equalToConstant: 40)
    ])

  }

  func configBikeImage() {
    view.addSubview(bikeImage)
    bikeImage.image = UIImage(named: "21936.jpg")
    bikeImage.contentMode = .scaleToFill
    bikeImage.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      bikeImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
      bikeImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      bikeImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      bikeImage.heightAnchor.constraint(equalToConstant: view.frame.size.height * 0.3)
    ])
  }
  func configLastActiveLabel() {
    view.addSubview(lastActiveLabel)
    lastActiveLabel.translatesAutoresizingMaskIntoConstraints = false
    lastActiveLabel.sizeToFit()
    lastActiveLabel.font = UIFont(name: "Helvetica", size: 25)

    NSLayoutConstraint.activate([
      lastActiveLabel.topAnchor.constraint(equalTo: bikeIcon.bottomAnchor, constant: 10),
      lastActiveLabel.leadingAnchor.constraint(equalTo: bikeCountLabel.leadingAnchor),
      lastActiveLabel.heightAnchor.constraint(equalToConstant: 30)
      // lastActiveLabel.widthAnchor.constraint(equalToConstant: 135),
    ])

  }

}
extension BikeRentalZoneDetailVC: BRZoneDetailVMDelegate {
  func show(zone: BRZone?) {
    if let zone = zone {
      self.lat = Double(zone.lat)
      self.lon = Double(zone.lon)
      zoneNameLabel.text = zone.name
      if let rentable = Int(zone.rentable),
         let rented  = Int(zone.rentedCount) {
        bikeCountLabel.text = "\(zone.rentable)/\(rentable + rented)"
      } else {
        bikeCountLabel.text = "Unknown"
      }

      lastActiveLabel.text = zone.lastCheck.toDate()
    }

  }

}
