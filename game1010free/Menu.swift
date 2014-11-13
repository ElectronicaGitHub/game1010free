import Foundation
import UIKit

// menu construct

var endGameView : UIView = UIView()
var endGameViewLabel : UILabel?
var endGameViewButton : UIButton?
var ranklabel : UILabel = UILabel()
var rankPicture : UIImageView = UIImageView()
var rankName : UILabel = UILabel()
var scoreNumber : UILabel = UILabel()

public class Menu {
    var view : UIView
    var _self : UIViewController
    init(view : UIView, _self : UIViewController) {
        self._self = _self
        self.view  = view
    }
    
    func menuInit() {
        
        endGameView = UIView(frame: CGRect(x: 0, y: 0, width: 180 * menuCoefficient, height: 360 * menuCoefficient))
        endGameView.center = CGPoint(x: view.center.x, y: -400)
        endGameView.backgroundColor = UIColor(rgb: 0xFFFFFF)
        endGameView.layer.shadowColor = UIColor.blackColor().CGColor
        endGameView.layer.shadowOpacity = 0.3
        endGameView.layer.shadowOffset = CGSize(width: 1, height: 3)
        
        var endL = UILabel(frame: CGRect(x: 0, y: 0, width: endGameView.frame.width, height: 30 * menuCoefficient))
        endL.text = "No moves"
        endL.frame.origin.y = 15
        endL.textAlignment = NSTextAlignment.Center
        endL.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 30 * menuCoefficient)
        endGameView.addSubview(endL)
        
        ranklabel = UILabel(frame: CGRect(x: 0, y: 0, width: endGameView.frame.width, height: 30 * menuCoefficient))
        ranklabel.text = "Archieved rank"
        ranklabel.frame.origin.y = 50 * menuCoefficient
        ranklabel.textAlignment = NSTextAlignment.Center
        ranklabel.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 20 * menuCoefficient)
        endGameView.addSubview(ranklabel)
        
        rankPicture = UIImageView(frame: CGRect(x: 0, y: 0, width: 110 * menuCoefficient, height: 110 * menuCoefficient))
        rankPicture.center = CGPoint(x: endGameView.frame.width/2, y: 140 * menuCoefficient)
//        var image = CGImageCreateWithImageInRect(UIImage(named: "ranks.png").CGImage, CGRect(x: 0, y: 0, width: 220, height: 220))
//        rankPicture.image = UIImage(CGImage: image)
        endGameView.addSubview(rankPicture)
        
        rankName = UILabel(frame: CGRect(x: 0, y: 0, width: endGameView.frame.width, height: 30 * menuCoefficient))
        rankName.frame.origin.y = 200 * menuCoefficient
        rankName.textAlignment = NSTextAlignment.Center
        rankName.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 20 * menuCoefficient)
        endGameView.addSubview(rankName)
        
        var rectStrip = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 2 * menuCoefficient))
        rectStrip.center = CGPoint(x: endGameView.frame.width/2, y: 0)
        rectStrip.backgroundColor = UIColor(rgb: 0xd5d5d5)
        rectStrip.frame.origin.y = 235 * menuCoefficient
        endGameView.addSubview(rectStrip)
        
        endGameViewLabel = UILabel(frame: CGRect(x: 0, y: 0, width: endGameView.frame.width, height: 30 * menuCoefficient))
        endGameViewLabel!.frame.origin.y = 245 * menuCoefficient
        endGameViewLabel!.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 18 * menuCoefficient)
        endGameViewLabel!.text = "Score"
        endGameViewLabel!.textAlignment = NSTextAlignment.Center
        endGameView.addSubview(endGameViewLabel!)
        
        scoreNumber = UILabel(frame: CGRect(x: 0, y: 0, width: endGameView.frame.width, height: 40 * menuCoefficient))
        scoreNumber.frame.origin.y = 275 * menuCoefficient
        scoreNumber.textAlignment = NSTextAlignment.Center
        scoreNumber.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 40 * menuCoefficient)
        endGameView.addSubview(scoreNumber)
        
        // добавляем кнопку
        endGameViewButton = UIButton(frame: CGRect(x: 0, y: 0, width: endGameView.frame.width, height: 40 * menuCoefficient))
        endGameViewButton!.backgroundColor = UIColor(rgb: 0x29ABE2)
        endGameViewButton!.setTitle("PLAY AGAIN", forState: UIControlState.Normal)
        endGameViewButton!.titleLabel!.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 20 * menuCoefficient)
        endGameViewButton!.addTarget(_self, action: "startGame", forControlEvents: UIControlEvents.TouchUpInside)
        endGameViewButton!.frame.origin.y = 330 * menuCoefficient
        endGameView.addSubview(endGameViewButton!)
        
        view.addSubview(endGameView)
    }
    
    func showMenu(score : Int, rank : Int) {
        
//        blurView!.frame = CGRect(x: 0, y: 0, width: gameView!.frame.width, height: gameView!.frame.height)
//        blurView!.backgroundColor = UIColor.blackColor()
//        gameView!.addSubview(blurView!)
        lastShowedRank.removeFromSuperview()
        scoreNumber.text = String(score)
        
        let _rank = rank == -1 ? 0 : rank
        let rank_label = Ranks[_rank][1] as String
        
        println("\(rank_label) and \(_rank)")
        
        var image = CGImageCreateWithImageInRect(UIImage(named: "ranks.png").CGImage, CGRect(x: 220 * _rank, y: 0, width: 220, height: 220))
        rankPicture.image = UIImage(CGImage: image)
        rankName.text = String(rank_label)
        
        UIView.animateWithDuration(0.6, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: nil, animations: {
            endGameView.center = CGPoint(x: self._self.view.center.x, y: self._self.view.center.y)
            //            self.endGameView.center = CGPoint(x: self.view.center.x, y: 20)
            }, completion: nil)
    }
    
    func hideMenu() {
        
//        blurView!.removeFromSuperview()
        
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: nil, animations: {
            endGameView.center = CGPoint(x: self._self.view.center.x, y: -200 * menuCoefficient)
            }, completion: nil)
    }

}





