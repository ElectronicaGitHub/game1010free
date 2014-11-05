import Foundation
import UIKit

// создание фигуры
class Figure {
    var figure = [Rectangle]()
    var type : String = String()
    var w : Int = Int()
    var h : Int = Int()
    var start_w_offset : Int? = Int()
    init(map : [NSDictionary], color : UIColor, size : CGFloat, padding : CGFloat, view : UIView, x: CGFloat, w: Int, h: Int, type: String, start_w_offset: Int?) {
        for i in map {
            let lx = i["x"] as CGFloat
            let ly = i["y"] as CGFloat
            let rd_x = x + lx * size
            let rd_y = 450 + ly * size
            var r = Rectangle(type: "special", x: rd_x, y: rd_y, size: size, color: color, view: view)
            self.figure.append(r)
            self.type = type
            self.w = w
            self.start_w_offset = start_w_offset
            self.h = h
        }
    }
}
