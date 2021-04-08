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
  private let coreDataManager: CoreDataManager
  
  init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
    self.coreDataManager = coreDataManager
  }
  
  func viewDidLoad() {
    reload()
  }
  
  func reload() {
    let events = coreDataManager.fetchEvents()
    cells = events.map {
      var eventCellViewModel = EventCellViewModel($0)
      if let coordinator = coordinator {
        eventCellViewModel.onSelect = coordinator.onSelect
      }
      return .event(eventCellViewModel)
    }
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
  
  func didSelectRow(at indexPath: IndexPath) {
    switch cells[indexPath.row] {
    case .event(let eventCellViewModel):
      eventCellViewModel.didSelect()
    }
  }
}
