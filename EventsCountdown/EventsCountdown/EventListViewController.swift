//
//  EventListViewController.swift
//  EventsCountdown
//
//  Created by Kevin Topollaj on 5.4.21.
//

import UIKit

class EventListViewController: UIViewController {
  
  static func instantiate() -> EventListViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: .main)
    let controller = storyboard.instantiateViewController(identifier: "EventListViewController") as! EventListViewController
    return controller
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .red
  }
  
  
}
