import Foundation
import UIKit

// создание фигуры
class Figure {
    var figure = [Rectangle]()
    var type : String = String()
    var w : Int = Int()
    var h : Int = Int()
    var start_x = CGFloat()
    var start_y = CGFloat()
    var start_w_offset : Int? = Int()
    var figureView = UIView()
    init(map : [NSDictionary], color : UIColor, view : UIView, figure_view : UIView, x: CGFloat, w: Int, h: Int, type: String, start_w_offset: Int?) {
        self.figureView = figure_view
        for i in map {
            let lx = i["x"] as CGFloat
            let ly = i["y"] as CGFloat
            let rd_x = x + lx * (size + padding)
            let rd_y = 450 + ly * (size + padding)
            let inner_x = figure_view.frame.width/2 + lx * (size + padding)
            let inner_y = figure_view.frame.height/2 + ly * (size + padding)
            self.start_x = x
            self.start_y = 0
            
            var r = Rectangle(type: "special", x: inner_x, y: inner_y, size: size, color: color, view: view, real_x : rd_x, real_y : rd_y)
            self.figure.append(r)
            self.type = type
            self.w = w
            self.start_w_offset = start_w_offset
            self.h = h
        }
    }
}
