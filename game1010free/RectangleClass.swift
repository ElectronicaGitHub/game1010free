import Foundation
import UIKit

// создание и отрисовка квадрата
class Rectangle {
    var box : UIView
    var inner_x : CGFloat
    var inner_y : CGFloat
    var outer_x : CGFloat
    var outer_y : CGFloat
    var size : CGFloat
    var type : NSString
    var startX : CGFloat
    var startY : CGFloat
    var color : UIColor
    init(type : NSString, x : CGFloat, y : CGFloat, size : CGFloat, color : UIColor, view : UIView, real_x : CGFloat, real_y : CGFloat) {
        self.type = type
        self.inner_x = x
        self.inner_y = y
        self.outer_x = real_x
        self.outer_y = real_y
        self.size = size
        self.startX = x
        self.startY = y
        self.color = color
        self.box = UIView(frame: CGRect(x: self.inner_x, y: self.inner_y, width: size, height: size))
        self.box.backgroundColor = color
        view.addSubview(box)
    }
}
