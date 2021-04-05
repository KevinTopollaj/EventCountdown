//
//  AddEventViewModel.swift
//  EventsCountdown
//
//  Created by Kevin Topollaj on 5.4.21.
//

import Foundation

final class AddEventViewModel {
  var coordinator: AddEventCoordinator?
  
  func viewDidDisappear() {
    coordinator?.didFinishAddEvent()
  }
}
