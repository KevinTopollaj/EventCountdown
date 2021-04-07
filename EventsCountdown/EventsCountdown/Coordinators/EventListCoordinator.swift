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
  
  var onSaveEvent: () -> Void = {}
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let eventListViewController: EventListViewController = .instantiate()
    let eventListViewModel = EventListViewModel()
    eventListViewModel.coordinator = self
    onSaveEvent = eventListViewModel.reload
    eventListViewController.viewModel = eventListViewModel
    navigationController.setViewControllers([eventListViewController], animated: false)
  }
  
  func startAddEvent() {
    let addEventCoordinator = AddEventCoordinator(navigationController: navigationController)
    addEventCoordinator.parentCoordinator = self
    childCoordinators.append(addEventCoordinator)
    addEventCoordinator.start()
  }
  
  func childDidFinish(_ childCoordinator: Coordinator) {
    if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
      return childCoordinator === coordinator
    }) {
      childCoordinators.remove(at: index)
    }
  }
}

