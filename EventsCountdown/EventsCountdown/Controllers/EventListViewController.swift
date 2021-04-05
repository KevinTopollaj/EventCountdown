//
//  EventListViewController.swift
//  EventsCountdown
//
//  Created by Kevin Topollaj on 5.4.21.
//

import UIKit

class EventListViewController: UIViewController {
  
  var viewModel: EventListViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavigationController()
  }
  
  private func setupNavigationController() {
    let plusImage = UIImage(systemName: "plus.circle.fill")
    let barButtonItem = UIBarButtonItem(image: plusImage, style: .plain, target: self, action: #selector(tappedAddEventBarButton))
    barButtonItem.tintColor = .primary
    navigationItem.rightBarButtonItem = barButtonItem
    navigationItem.title = viewModel.title
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  @objc func tappedAddEventBarButton() {
    viewModel.tappedAddEvent()
  }
  
}
