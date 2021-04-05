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
  private var modalNavigationController: UINavigationController?
  private var completion: (UIImage) -> Void = { _ in }
  
  var parentCoordinator: EventListCoordinator?
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    self.modalNavigationController = UINavigationController()
    let addEventViewController: AddEventViewController = .instantiate()
    modalNavigationController?.setViewControllers([addEventViewController], animated: false)
    let addEventViewModel = AddEventViewModel()
    addEventViewModel.coordinator = self
    addEventViewController.viewModel = addEventViewModel
    if let modalNavigationController = modalNavigationController {
      navigationController.present(modalNavigationController, animated: true, completion: nil)
    }
  }
  
  func didFinishAddEvent() {
    parentCoordinator?.childDidFinish(self)
  }
  
  func showImagePicker(completion: @escaping (UIImage) -> Void) {
    guard let modalNavigationController = modalNavigationController else { return }
    self.completion = completion
    let imagePickerCoordinator = ImagePickerCoordinator(navigationController: modalNavigationController)
    imagePickerCoordinator.parentCoordinator = self
    childCoordinators.append(imagePickerCoordinator)
    imagePickerCoordinator.start()
  }
  
  func didFinishPicking(_ image: UIImage) {
    completion(image)
    modalNavigationController?.dismiss(animated: true)
  }
  
  func childDidFinish(_ childCoordinator: Coordinator) {
    if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
      return childCoordinator === coordinator
    }) {
      childCoordinators.remove(at: index)
    }
  }
}
