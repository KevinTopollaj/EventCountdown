//
//  EditEventCoordinator.swift
//  EventsCountdown
//
//  Created by Kevin Topollaj on 9.4.21.
//

import UIKit

final class EditEventCoordinator: Coordinator {
  private(set) var childCoordinators: [Coordinator] = []
  private let navigationController: UINavigationController
  private var completion: (UIImage) -> Void = { _ in }
  private let event: Event
  
  var parentCoordinator: EventListCoordinator?
  
  init(event: Event, navigationController: UINavigationController) {
    self.event = event
    self.navigationController = navigationController
  }
  
  func start() {
    let editEventViewController: EditEventViewController = .instantiate()
    let editEventViewModel = EditEventViewModel(event: event, eventCellBuilder: EventCellBuilder())
    editEventViewModel.coordinator = self
    editEventViewController.viewModel = editEventViewModel
    navigationController.pushViewController(editEventViewController, animated: true)
  }
  
  func didFinishSaveEvent() {
    parentCoordinator?.onSaveEvent()
    navigationController.dismiss(animated: true, completion: nil)
  }
  
  func showImagePicker(completion: @escaping (UIImage) -> Void) {
    self.completion = completion
    let imagePickerCoordinator = ImagePickerCoordinator(navigationController: navigationController)
    imagePickerCoordinator.parentCoordinator = self
    imagePickerCoordinator.onFinishPicking = { image in
      completion(image)
    }
    childCoordinators.append(imagePickerCoordinator)
    imagePickerCoordinator.start()
  }
  
  func didFinish() {
    parentCoordinator?.childDidFinish(self)
  }
  
  func childDidFinish(_ childCoordinator: Coordinator) {
    if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
      return childCoordinator === coordinator
    }) {
      childCoordinators.remove(at: index)
    }
  }
}