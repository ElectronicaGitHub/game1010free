import Foundation
import UIKit

// создание и отрисовка квадрата
class Rectangle {
    var box : UIView
    var x : CGFloat
    var y : CGFloat
    var size : CGFloat
    var type : NSString
    var startX : CGFloat
    var startY : CGFloat
    var color : UIColor
    init(type : NSString, x : CGFloat, y : CGFloat, size : CGFloat, color : UIColor, view : UIView) {
        self.type = type
        self.x = x
        self.y = y
        self.size = size
        self.startX = x
        self.startY = y
        self.color = color
        self.box = UIView(frame: CGRect(x: self.x, y: self.y, width: size, height: size))
        self.box.backgroundColor = color
        view.addSubview(box)
    }
}
