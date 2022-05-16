# SAHLSPlayer
HLS Player 
<code>
import UIKit <br>
import SAHLSPlayer <br>
  <br>
class ViewController: UIViewController { <br>
   <br>
  var playerView: SAPlayerView! <br>
    override func viewDidLoad() { <br>
       super.viewDidLoad() <br>
      playerView = .init(urls: [.init(string: "YOUR URL")!]) <br>
      view.addSubview(playerView) <br>
  } <br>
  <br>
  override func viewWillLayoutSubviews() {<br>
     super.viewWillLayoutSubviews()<br>
     if playerView != nil {<br>
       playerView.frame = view.bounds<br>
  }<br>
  }<br>
}

</code> 
