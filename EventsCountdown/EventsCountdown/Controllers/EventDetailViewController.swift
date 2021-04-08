//
//  EventDetailViewController.swift
//  EventsCountdown
//
//  Created by Kevin Topollaj on 8.4.21.
//

import UIKit

final class EventDetailViewController: UIViewController {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var timeRemainingStackView: TimeRemainingStackView! {
    didSet {
      timeRemainingStackView.setup()
    }
  }
  
  var viewModel: EventDetailViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.onUpdate = { [weak self] in
      guard let self = self,
            let timeRemainingViewModel = self.viewModel.timeRemainingViewModel else { return }
      self.imageView.image = self.viewModel.image
      // update the time remaining labels, event name and date label
      self.timeRemainingStackView.update(with: timeRemainingViewModel)
    }
    viewModel.viewDidLoad()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    viewModel.viewDidDisappear()
  }
}
