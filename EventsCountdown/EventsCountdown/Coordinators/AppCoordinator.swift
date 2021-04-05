//
//  AppCoordinator.swift
//  EventsCountdown
//
//  Created by Kevin Topollaj on 5.4.21.
//

import UIKit

protocol Coordinator {
  // keeps track of coordinators and makes sure we dont dealocate them imediately
  var childCoordinators: [Coordinator] { get }
  // entry point for each coordinator
  func start()
}

final class AppCoordinator: Coordinator {
  private(set) var childCoordinators: [Coordinator] = []
  private let window: UIWindow
  
  init(window: UIWindow) {
    self.window = window
  }
  
  func start() {
    let navigationController = UINavigationController()
    
    let eventListCoordinator = EventListCoordinator(navigationController: navigationController)

    childCoordinators.append(eventListCoordinator)
    eventListCoordinator.start()
    
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
  }
}