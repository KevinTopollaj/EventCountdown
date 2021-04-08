//
//  EventDetailViewController.swift
//  EventsCountdown
//
//  Created by Kevin Topollaj on 8.4.21.
//

import UIKit

final class EventDetailViewController: UIViewController {
  
  @IBOutlet weak var imageView: UIImageView!
  
  var viewModel: EventDetailViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.onUpdate = { [weak self] in
      self?.imageView.image = self?.viewModel.image
      // update the time remaining labels, event name and date label
      
    }
    viewModel.viewDidLoad()
  }
  
}
