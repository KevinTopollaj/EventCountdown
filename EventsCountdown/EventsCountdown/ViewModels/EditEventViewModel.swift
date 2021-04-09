//
//  EditEventViewModel.swift
//  EventsCountdown
//
//  Created by Kevin Topollaj on 9.4.21.
//

import UIKit

final class EditEventViewModel {
  
  let title = "Edit"
  var onUpdate: () -> Void = {}
  
  enum Cell {
    case titleSubtitle(TitleSubtitleCellViewModel)
  }
  
  private(set) var cells: [EditEventViewModel.Cell] = []
  weak var coordinator: EditEventCoordinator?
  
  private var nameCellViewModel: TitleSubtitleCellViewModel?
  private var dateCellViewModel: TitleSubtitleCellViewModel?
  private var backgroundImageCellViewModel: TitleSubtitleCellViewModel?
 
  private let eventCellBuilder: EventCellBuilder
  private let coreDataManager: CoreDataManager
  private let event: Event
  
  lazy var dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM.yyy"
    return dateFormatter
  }()
  
  init(
    event: Event,
    eventCellBuilder: EventCellBuilder,
    coreDataManager: CoreDataManager = CoreDataManager.shared
  ) {
    self.event = event
    self.eventCellBuilder = eventCellBuilder
    self.coreDataManager = coreDataManager
  }
  
  func viewDidLoad() {
    setupCells()
    onUpdate()
  }
  
  func viewDidDisappear() {
    coordinator?.didFinish()
  }
  
  func numberOfRows() -> Int {
    return cells.count
  }
  
  func cell(for indexPath: IndexPath) -> Cell {
    return cells[indexPath.row]
  }
  
  func tappedDone() {
    // extract info from cell view models and save in core data
    guard let name = nameCellViewModel?.subtitle,
          let dateString = dateCellViewModel?.subtitle,
          let image = backgroundImageCellViewModel?.image,
          let date = dateFormatter.date(from: dateString) else { return }
    
    // update the existing event
    coreDataManager.updateEvent(event: event, name: name, date: date, image: image)
    
    // tell the coordinator to dismiss
    coordinator?.didFinishUpdateEvent()
  }
  
  func updateCell(indexPath: IndexPath, subtitle: String) {
    switch cells[indexPath.row] {
    case .titleSubtitle(let titleSubtitleCellViewModel):
      titleSubtitleCellViewModel.update(subtitle)
    }
  }
  
  func didSelectRow(at indexPath: IndexPath) {
    switch cells[indexPath.row] {
    case .titleSubtitle(let titleSubtitleCellViewModel):
      guard titleSubtitleCellViewModel.type == .image else {
        return
      }
      
      coordinator?.showImagePicker { image in
        titleSubtitleCellViewModel.update(image)
      }
    }
  }
}

private extension EditEventViewModel {
  func setupCells() {
    nameCellViewModel = eventCellBuilder.makeTitleSubtitleCellViewModel(.text)
    
    dateCellViewModel = eventCellBuilder.makeTitleSubtitleCellViewModel(.date, onCellUpdate: { [weak self] in
      self?.onUpdate()
    })
    
    backgroundImageCellViewModel = eventCellBuilder.makeTitleSubtitleCellViewModel(.image, onCellUpdate: { [weak self] in
      self?.onUpdate()
    })
    
    guard let nameCellViewModel = nameCellViewModel,
          let dateCellViewModel = dateCellViewModel,
          let backgroundImageCellViewModel = backgroundImageCellViewModel else { return}
    
    cells = [
      .titleSubtitle(nameCellViewModel),
      .titleSubtitle(dateCellViewModel),
      .titleSubtitle(backgroundImageCellViewModel)
    ]
    
    guard let name = event.name,
          let date = event.date,
          let imageData = event.image,
          let image = UIImage(data: imageData) else { return }
    
    nameCellViewModel.update(name)
    dateCellViewModel.update(date)
    backgroundImageCellViewModel.update(image)
  }
}

