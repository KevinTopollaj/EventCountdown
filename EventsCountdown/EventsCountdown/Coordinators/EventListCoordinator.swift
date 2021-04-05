//
//  EventListCoordinator.swift
//  EventsCountdown
//
//  Created by Kevin Topollaj on 5.4.21.
//

import UIKit

final class EventListCoordinator: Coordinator {
  private(set) var childCoordinators: [Coordinator] = []
  private let navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let eventListViewController = EventListViewController.instantiate()
    let eventListViewModel = EventListViewModel()
    eventListViewController.viewModel = eventListViewModel
    navigationController.setViewControllers([eventListViewController], animated: false)
  }
  
  func startAddEvent() {
    let addEventCoordinator = AddEventCoordinator(navigationController: navigationController)
    childCoordinators.append(addEventCoordinator)
    addEventCoordinator.start()
  }
}

