# SAHLSPlayer
HLS Player 


import UIKit
import SAHLSPlayer

class ViewController: UIViewController {

var playerView: SAPlayerView!
    override func viewDidLoad() {
       super.viewDidLoad() 
      playerView = .init(urls: [.init(string: "YOUR URL")!])
      view.addSubview(playerView) 
  } 
  
  override func viewWillLayoutSubviews() {
     super.viewWillLayoutSubviews()
     if playerView != nil {
       playerView.frame = view.bounds
  }
  }
}
