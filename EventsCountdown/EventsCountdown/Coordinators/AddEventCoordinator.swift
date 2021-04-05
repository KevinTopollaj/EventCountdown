//
//  AddEventCoordinator.swift
//  EventsCountdown
//
//  Created by Kevin Topollaj on 5.4.21.
//

import UIKit

final class AddEventCoordinator: Coordinator {
  private(set) var childCoordinators: [Coordinator] = []
  private let navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    // create add event viewController
    // create add event viewModel
    // present modally add event viewController using navigation controller
  }
}
