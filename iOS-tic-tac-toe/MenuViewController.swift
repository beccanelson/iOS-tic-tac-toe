import UIKit

public class MenuViewController: UIViewController {
    var rotation: CGFloat = 0.0
    public var humanVsComputerIsDisplayed = true;

    @IBOutlet weak public var player1MarkerLabel: UILabel!
    @IBOutlet weak public var player2MarkerLabel: UILabel!
    
    @IBOutlet weak var gameTypeImage: UIImageView!
    @IBOutlet weak var gameTypeLink: UIButton!
    
    public override func viewDidLoad() {
        setEnvironment()
        appMovedToForeground()
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplicationWillEnterForegroundNotification, object: nil)
    }
    
    func appMovedToForeground() {
        setPlayerMarkers()
        displayPlayerMarkers()
    }

    @IBAction func navigateToSettings(sender: UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string:UIApplicationOpenSettingsURLString)!)
    }
    
    public func displayPlayerMarkers() {
        player1MarkerLabel.text = "Player 1's Marker: \(UIConfig.player1)"
        player2MarkerLabel.text = "Player 2's Marker: \(UIConfig.player2)"
    }
    
    public func setEnvironment() {
        let environment = NSProcessInfo.processInfo().environment["Environment"]
        if (environment == "Local") {
            GameConfig.root = "http://localhost:5000"
        } else {
            GameConfig.root = "http://stormy-savannah-24890.herokuapp.com"
        }
    }

    public func setPlayerMarkers() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let player1Marker = defaults.stringForKey("SettingsPlayer1Marker")
        if markerExists(player1Marker) {
            let userDefinedMarker = String(player1Marker!).characters.first
            UIConfig.player1 = String(userDefinedMarker!)
        } else {
            UIConfig.player1 = Marker.X.rawValue
        }
        
        let player2Marker = defaults.stringForKey("SettingsPlayer2Marker")
        if markerExists(player2Marker) {
            let userDefinedMarker = String(player2Marker!).characters.first
            UIConfig.player2 = String(userDefinedMarker!)
        } else {
            UIConfig.player2 = Marker.O.rawValue
        }
    }
    
    public func markerExists(marker: String?) -> Bool {
        return marker != nil && marker != "" && marker?.characters.first != " "
    }

    @IBAction public func newPlayerVsPlayerGame(sender: UIButton) {
        GameConfig.gameType = GameConfig.humanVsHuman
        GameConfig.game = PlayerVsPlayer()
    }
    
    @IBAction public func newPlayerVsComputerGame(sender: UIButton) {
        GameConfig.gameType = GameConfig.humanVsComputer
        GameConfig.game = PlayerVsComputer()
        GameConfig.game.isXTurn = humanVsComputerIsDisplayed
    }
    
    @IBAction func switchGameType(sender: UIButton) {
        toggleGameDisplay()
        humanVsComputerIsDisplayed = !humanVsComputerIsDisplayed
    }
    
    @IBAction func animateSwitch(sender: UIButton) {
        sender.alpha = 0.5
        UIView.animateWithDuration(0.75,
            animations: {
                self.rotation += CGFloat(M_PI_2) * 2
                if self.humanVsComputerIsDisplayed {
                    sender.transform = CGAffineTransformMakeRotation(self.rotation)
                } else {
                    sender.transform = CGAffineTransformMakeRotation(-self.rotation)
                }
            }, completion: { finished in
                sender.alpha = 1
        })
    }
    
    private func toggleGameDisplay() {
        if humanVsComputerIsDisplayed {
            gameTypeImage.image = UIImage(named: UIConfig.computerVsHumanImage)
            gameTypeLink.setTitle(UIConfig.computerVsPlayerLabel, forState: .Normal)
        } else {
            gameTypeImage.image = UIImage(named: UIConfig.humanVsComputerImage)
            gameTypeLink.setTitle(UIConfig.playerVsComputerLabel, forState: .Normal)

        }
    }
}

