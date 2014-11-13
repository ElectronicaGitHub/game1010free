import Foundation
import UIKit

var startScreenWrapper : UIView = UIView()

class StartScreen {
    var view : UIView
    var _self : UIViewController
    var uh : NSDictionary
    init(view : UIView, _self : UIViewController) {
        
        self.uh = userHighscores as NSDictionary
        self.view = view
        self._self = _self
    }
    func startScreenInit() {
        
        var rank = uh["rank"] as Int
        var score = uh["score"] as Int
        
        startScreenWrapper = UIView(frame: CGRectMake(0, 0, view.frame.width, view.frame.height))
        startScreenWrapper.backgroundColor = UIColor.whiteColor()
        
        view.addSubview(startScreenWrapper)
        
        var startScreenView = UIView(frame: CGRect(x: 0, y: 0, width: 200 * menuCoefficient, height: 360 * menuCoefficient))
        startScreenView.center = CGPoint(x: view.center.x, y: view.center.y)
        startScreenView.backgroundColor = UIColor(rgb: 0xFFFFFF)

        var logo = UIImageView(frame: CGRectMake(0, 0, startScreenView.frame.width, 40 * menuCoefficient))
        var img = UIImage(named: "block2blocklogoblack.png")
        logo.frame.size.width = startScreenView.frame.width
        logo.center.x = startScreenView.frame.width/2
        logo.contentMode = UIViewContentMode.ScaleAspectFit
        logo.image = img
        startScreenView.addSubview(logo)
        
        ranklabel = UILabel(frame: CGRect(x: 0, y: 0, width: startScreenView.frame.width, height: 30 * menuCoefficient))
        ranklabel.text = "Your rank"
        ranklabel.frame.origin.y = 50 * menuCoefficient
        ranklabel.textAlignment = NSTextAlignment.Center
        ranklabel.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 20 * menuCoefficient)
        startScreenView.addSubview(ranklabel)
        
        var rp = UIImageView(frame: CGRect(x: 0, y: 0, width: 110 * menuCoefficient, height: 110 * menuCoefficient))
        rp.center = CGPoint(x: startScreenView.frame.width/2, y: 140 * menuCoefficient)
        var image = CGImageCreateWithImageInRect(UIImage(named: "ranks.png").CGImage, CGRect(x: 220 * rank, y: 0, width: 220, height: 220))
        rp.image = UIImage(CGImage: image)
        startScreenView.addSubview(rp)
        
        var rn = UILabel(frame: CGRect(x: 0, y: 0, width: startScreenView.frame.width, height: 30 * menuCoefficient))
        rn.text = Ranks[rank][1] as? String
        rn.frame.origin.y = 200 * menuCoefficient
        rn.textAlignment = NSTextAlignment.Center
        rn.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 20 * menuCoefficient)
        startScreenView.addSubview(rn)
        
        var rectStrip = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 2 * menuCoefficient))
        rectStrip.center = CGPoint(x: startScreenView.frame.width/2, y: 0)
        rectStrip.backgroundColor = UIColor(rgb: 0xd5d5d5)
        rectStrip.frame.origin.y =  235 * menuCoefficient
        startScreenView.addSubview(rectStrip)
        
        var scoreLabel = UILabel(frame: CGRect(x: 0, y: 0, width: startScreenView.frame.width, height: 30 * menuCoefficient))
        scoreLabel.frame.origin.y = 245 * menuCoefficient
        scoreLabel.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 20 * menuCoefficient)
        scoreLabel.text = "Top Score"
        scoreLabel.textAlignment = NSTextAlignment.Center
        startScreenView.addSubview(scoreLabel)
        
        var scoreNumber = UILabel(frame: CGRect(x: 0, y: 0, width: startScreenView.frame.width, height: 40 * menuCoefficient))
        scoreNumber.text = String(score)
        scoreNumber.frame.origin.y = 275 * menuCoefficient
        scoreNumber.textAlignment = NSTextAlignment.Center
        scoreNumber.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 40 * menuCoefficient)
        startScreenView.addSubview(scoreNumber)
        
        // добавляем кнопку
        var button = UIButton(frame: CGRect(x: 0, y: 0, width: startScreenView.frame.width, height: 40 * menuCoefficient))
        button.backgroundColor = UIColor(rgb: 0x29ABE2)
        button.setTitle("PLAY", forState: UIControlState.Normal)
        button.titleLabel!.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 20 * menuCoefficient)
        button.addTarget(_self, action: "startGame", forControlEvents: UIControlEvents.TouchUpInside)
        button.frame.origin.y = 320 * menuCoefficient
        startScreenView.addSubview(button)
        
        startScreenWrapper.addSubview(startScreenView)
    }
    
    func hideStartScreen() {
        UIView.animateWithDuration(0.5, animations: {
            startScreenWrapper.frame.origin.y = -1000 * menuCoefficient
            }, completion: {
                _ in
        })
    }
    
}