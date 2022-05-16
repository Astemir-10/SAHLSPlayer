# SAHLSPlayer
HLS Player 


<br>
<code>
import UIKit <br>
import SAHLSPlayer <br>
  <br>
class ViewController: UIViewController { <br> <br>
   <br><br>
  var playerView: SAPlayerView! <br><br>
    override func viewDidLoad() { <br><br>
       super.viewDidLoad() <br><br>
      playerView = .init(urls: [.init(string: "YOUR URL")!]) <br><br>
      view.addSubview(playerView) <br><br>
  } <br><br>
  <br><br>
  override func viewWillLayoutSubviews() {<br><br>
     super.viewWillLayoutSubviews()<br><br>
     if playerView != nil {<br><br>
       playerView.frame = view.bounds<br><br>
  }<br><br>
  }<br><br>
}

</code> 
