//
//  BikeRentalZoneTableView.swift
//  BikeRental-MVVM
//
//  Created by DenizCagilligecit on 21.04.2021.
//

import UIKit
class BRZoneTableViewCell: UITableViewCell {

  let zoneNameLabel = UILabel()
  let bikeCountLabel = UILabel()
  let bikeImage = UIImageView()
  let lastActiveLabel = UILabel()
  static let reuseID = "BikeRentalZoneTableViewCell"

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configZoneNameLabel()
    configBikeCountLabel()
    configBikeImage()
    configLastActiveLabel()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func config(_ zone: BRZone) {
    zoneNameLabel.text = zone.name
    if let rentable = Int(zone.rentable),
       let rented  = Int(zone.rentedCount) {
      bikeCountLabel.text = "\(zone.rentable)/\(rentable + rented)"
    } else {
      bikeCountLabel.text = "Unknown"
    }
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:sss"

    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "MMM dd,yyyy"

    lastActiveLabel.text = zone.lastCheck.toDate()
  }
  func configZoneNameLabel() {
    addSubview(zoneNameLabel)

    zoneNameLabel.text = "Bostanci Ido 2"
    zoneNameLabel.translatesAutoresizingMaskIntoConstraints = false
    zoneNameLabel.sizeToFit()
    NSLayoutConstraint.activate([
      zoneNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      zoneNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      zoneNameLabel.heightAnchor.constraint(equalToConstant: 40)
    ])

  }

  func configBikeCountLabel() {
    contentView.addSubview(bikeCountLabel)

    bikeCountLabel.text = "9/15"
    bikeCountLabel.textAlignment = .center
    bikeCountLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      bikeCountLabel.topAnchor.constraint(equalTo: zoneNameLabel.bottomAnchor, constant: 5),
      bikeCountLabel.leadingAnchor.constraint(equalTo: zoneNameLabel.leadingAnchor),
      bikeCountLabel.heightAnchor.constraint(equalToConstant: 45),
      bikeCountLabel.widthAnchor.constraint(equalToConstant: 50)
    ])

  }
  func configBikeImage() {
    contentView.addSubview(bikeImage)

    bikeImage.image = UIImage(named: "bicycle.png")
    bikeImage.contentMode = .scaleToFill
    bikeImage.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      bikeImage.leadingAnchor.constraint(equalTo: bikeCountLabel.trailingAnchor),
      bikeImage.centerYAnchor.constraint(equalTo: bikeCountLabel.centerYAnchor),
      bikeImage.heightAnchor.constraint(equalToConstant: 30),
      bikeImage.widthAnchor.constraint(equalToConstant: 30)
    ])

  }
  func configLastActiveLabel() {
    contentView.addSubview(lastActiveLabel)

    lastActiveLabel.translatesAutoresizingMaskIntoConstraints = false
    lastActiveLabel.text = "2020/11/:08:34"
    lastActiveLabel.sizeToFit()

    NSLayoutConstraint.activate([
      lastActiveLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      lastActiveLabel.heightAnchor.constraint(equalToConstant: 30),
      // lastActiveLabel.widthAnchor.constraint(equalToConstant: 135),
      lastActiveLabel.topAnchor.constraint(equalTo: bikeImage.topAnchor)
    ])

  }

}
