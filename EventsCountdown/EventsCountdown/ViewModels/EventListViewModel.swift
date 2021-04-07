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
  var onUpdate: () -> Void = {}
  
  enum Cell {
    case event(EventCellViewModel)
  }
  
  private(set) var cells: [Cell] = []
  
  func viewDidLoad() {
    cells = [.event(EventCellViewModel()), .event(EventCellViewModel())]
    onUpdate()
  }
  
  func tappedAddEvent() {
    coordinator?.startAddEvent()
  }
  
  func numberOfRows() -> Int {
    return cells.count
  }
  
  func cell(at indexPath: IndexPath) -> Cell {
    return cells[indexPath.row]
  }
}
