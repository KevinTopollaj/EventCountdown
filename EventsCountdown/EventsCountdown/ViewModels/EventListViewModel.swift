//
//  EventListViewModel.swift
//  EventsCountdown
//
//  Created by Kevin Topollaj on 5.4.21.
//

import Foundation

final class EventListViewModel {
  
  let title = "Event"
  var coordinator: EventListCoordinator?
  
  func tappedAddEvent() {
    coordinator?.startAddEvent()
  }
}
