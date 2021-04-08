//
//  EventDetailCoordinator.swift
//  EventsCountdown
//
//  Created by Kevin Topollaj on 8.4.21.
//

import CoreData
import UIKit

final class EventDetailCoordinator: Coordinator {
  private(set) var childCoordinators: [Coordinator] = []
  private let navigationController: UINavigationController
  private let eventID: NSManagedObjectID
  
  var parentCoordinator: EventListCoordinator?
  
  init(eventID: NSManagedObjectID, navigationController: UINavigationController) {
    self.eventID = eventID
    self.navigationController = navigationController
  }
  
  func start() {
    // create event detail view controller
    let detailViewController: EventDetailViewController = .instantiate()
    // create and add event detail view model to the detail view controller
    let eventDetailViewModel = EventDetailViewModel(eventID: eventID)
    eventDetailViewModel.coordinator = self
    detailViewController.viewModel = eventDetailViewModel
    // push detail view controller into navigation controller
    navigationController.pushViewController(detailViewController, animated: true)
  }
  
  func didFinish() {
    parentCoordinator?.childDidFinish(self)
  }
}
