//
//  EventListViewController.swift
//  EventsCountdown
//
//  Created by Kevin Topollaj on 5.4.21.
//

import CoreData
import UIKit

class EventListViewController: UIViewController {
  
  private let coreDataManager = CoreDataManager()
  
  static func instantiate() -> EventListViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: .main)
    let controller = storyboard.instantiateViewController(identifier: "EventListViewController") as! EventListViewController
    return controller
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavigationController()
    
    coreDataManager.saveEvent(name: "Bora bora", date: Date(), image: #imageLiteral(resourceName: "borabora"))
    print(coreDataManager.fetchEvents())
  }
  
  private func setupNavigationController() {
    let plusImage = UIImage(systemName: "plus.circle.fill")
    let barButtonItem = UIBarButtonItem(image: plusImage, style: .plain, target: self, action: #selector(tappedAddBarButton))
    barButtonItem.tintColor = .primary
    navigationItem.rightBarButtonItem = barButtonItem
    navigationItem.title = "Events"
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  @objc func tappedAddBarButton() {
    print("tapped add button")
  }
  
}
