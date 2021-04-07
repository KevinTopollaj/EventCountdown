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
    cells = events.map { .event(EventCellViewModel($0)) }
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
