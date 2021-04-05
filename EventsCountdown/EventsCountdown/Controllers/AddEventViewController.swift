//
//  AddEventViewController.swift
//  EventsCountdown
//
//  Created by Kevin Topollaj on 5.4.21.
//

import UIKit

class AddEventViewController: UIViewController {
  
  var viewModel: AddEventViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    viewModel.viewDidDisappear()
  }
  
}
