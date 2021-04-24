//
//  BikeRentalZoneListVC.swift
//  BikeRental-MVVM
//
//  Created by DenizCagilligecit on 19.04.2021.
//

import UIKit
class BRZoneListVC: UIViewController {

  let tableView = UITableView()
  var viewModel: BRZoneListVMProtocol? {
    didSet {
      viewModel?.delegate = self
    }
  }
  private var zoneList = [BRZone]()
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .gray
    viewModel?.fetch()
    setupTableView()
  }
  func setupTableView() {
    view.addSubview(tableView)
    tableView.delegate = self
    tableView.rowHeight = 100
    tableView.dataSource = self
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.register(BRZoneTableViewCell.self, forCellReuseIdentifier: BRZoneTableViewCell.reuseID)

    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
      ])
  }
}
extension BRZoneListVC: UITableViewDelegate, UITableViewDataSource, BRZoneListVMDelegate {
  func navigateToDetailScreen(for zone: BRZone?) {

    let viewController = BRZoneDetailBuilder.make(zone: zone)
    navigationController?.pushViewController(viewController, animated: true)
  }

  func handleViewModelOutputs(_ output: BRZoneListVMOutput) {
    switch output {
    case .setLoading(let loading):
      UIApplication.shared.isNetworkActivityIndicatorVisible = loading
    case .showZoneList(let zones):
      self.zoneList = zones
      tableView.reloadData()
    case .updateTitle(let pageTitle):
      self.title = pageTitle
    }
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return zoneList.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let zone = zoneList[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: BRZoneTableViewCell.reuseID, for: indexPath) as? BRZoneTableViewCell
    cell?.config(zone)
    return cell!
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel?.selectZone(at: indexPath.row)
  }

}
