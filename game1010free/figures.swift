import UIKit

extension UIColor {
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

class figures {
    var maps : [NSDictionary] = [NSDictionary]()
    init() {
        var a = -1.5
        var b = -0.5
        var c = -1
        
        // dot
        self.maps.append([
            "map" : [
                [ "x" : b, "y" : b]
            ],
            "color" : UIColor(rgb: 0x468966),
            "w" : 0,
            "h" : 0,
            "type" : "dot"
        ])
        // rect
        self.maps.append([
            "map" : [
                [ "x" : 0, "y" : 0],  [ "x" : 0, "y" : -1],  [ "x" : -1, "y" : 0],  [ "x" : -1, "y" : -1]
            ],
            "color" : UIColor(rgb: 0xFFB03B),
            "w" : 1,
            "h" : 1,
            "type" : "rect"
        ])
        // line 2h
        self.maps.append([
            "map" : [
                [ "x" : 0, "y" : b], [ "x" : -1, "y" : b]
            ],
            "color" : UIColor(rgb: 0xB64926),
            "w" : 1,
            "h" : 0,
            "type" : "line2h"
        ])
        // line 3h
        self.maps.append([
            "map" : [
                [ "x" : b, "y" : b], [ "x" : a, "y" : b], [ "x" : 0.5, "y" : b]
            ],
            "color" : UIColor(rgb: 0x105B63),
            "w" : 2,
            "h" : 0,
            "type" : "line3h"
        ])
        // line 4h
        self.maps.append([
            "map" : [
                ["x" : -2, "y" : b], ["x" : -1, "y" : b], ["x" : 0, "y" : b], ["x" : 1, "y" : b]
            ],
            "color" : UIColor(rgb: 0x644D52),
            "w" : 3,
            "h" : 0,
            "type" : "line4h"
        ])
        // line 5h
        self.maps.append([
            "map" : [
                 [ "x" : -2.5, "y" : b], [ "x" : a, "y" : b], [ "x" : b, "y" : b], [ "x" : 0.5, "y" : b], [ "x" : 1.5, "y" : b]
            ],
            "color" : UIColor(rgb: 0xBD4932),
            "w" : 4,
            "h" : 0,
            "type" : "line5h"
        ])
        // line 2w
        self.maps.append([
            "map" : [
                [ "x" : b, "y" : 0],
                [ "x" : b, "y" : -1]
            ],
            "color" : UIColor(rgb: 0xDB9E36),
            "w" : 0,
            "h" : 1,
            "type" : "line2w"
        ])
        // line 3w
        self.maps.append([
            "map" : [
                [ "x" : b, "y" : 0.5],
                [ "x" : b, "y" : b],
                [ "x" : b, "y" : -1.5]
            ],
            "color" : UIColor(rgb: 0x225378),
            "w" : 0,
            "h" : 2,
            "type" : "line3w"
        ])
        // line 4w
        self.maps.append([
            "map" : [
                [ "x" : b, "y" : -2],
                [ "x" : b, "y" : -1],
                [ "x" : b, "y" : 0],
                [ "x" : b, "y" : 1]
            ],
            "color" : UIColor(rgb: 0xEB7F00),
            "w" : 0,
            "h" : 3,
            "type" : "line4w"
        ])
        // line 5w
        self.maps.append([
            "map" : [
                [ "x" : b, "y" : -2.5],
                [ "x" : b, "y" : a],
                [ "x" : b, "y" : b],
                [ "x" : b, "y" : 0.5],
                [ "x" : b, "y" : 1.5]
            ],
            "color" : UIColor(rgb: 0x588F27),
            "w" : 0,
            "h" : 4,
            "type" : "line5w"
        ])
        // r
        self.maps.append([
            "map" : [
                [ "x" : 0, "y" : c], [ "x" : c, "y" : 0], [ "x" : c, "y" : c]
            ],
            "color" : UIColor(rgb: 0xEB7F00),
            "w" : 1,
            "h" : 1,
            "type" : "r"
        ])
        // L
        self.maps.append([
            "map" : [
                [ "x" : 0, "y" : 0], [ "x" : c, "y" : 0], [ "x" : c, "y" : c]
            ],
            "color" : UIColor(rgb: 0xA9CF54),
            "w" : 1,
            "h" : 1,
            "type" : "L"
        ])
        // r inv
        self.maps.append([
            "map" : [
                [ "x" : 0, "y" : 0], [ "x" : 0, "y" : c], [ "x" : c, "y" : c]
            ],
            "color" : UIColor(rgb: 0xF77A52),
            "w" : 1,
            "h" : 1,
            "type" : "r_inv"
        ])
        // l inv
        self.maps.append([
            "map" : [
                [ "x" : 0, "y" : 0], [ "x" : 0, "y" : c], [ "x" : c, "y" : 0]
            ],
            "color" : UIColor(rgb: 0x332532),
            "w" : 0,
            "h" : 1,
            "start_w" : 1,
            "type" : "L_inv"
        ])
        // big rect
        self.maps.append([
            "map" : [
                [ "x" : a, "y" : a  ], [ "x" : b, "y" : a  ], [ "x" : 0.5, "y" : a  ],
                [ "x" : a, "y" : b], [ "x" : b, "y" : b], [ "x" : 0.5, "y" : b],
                [ "x" : a, "y" : 0.5], [ "x" : b, "y" : 0.5], [ "x" : 0.5, "y" : 0.5]
            ],
            "color" : UIColor(rgb: 0xE85C80),
            "w" : 2,
            "h" : 2,
            "type" : "bigrect"
        ])
        // bigr
        self.maps.append([
            "map" : [
                [ "x" : a, "y" : a  ], [ "x" : b, "y" : a], [ "x" : 0.5, "y" : a],
                [ "x" : a, "y" : b],
                [ "x" : a, "y" : 0.5]
            ],
            "color" : UIColor(rgb: 0xFFAD0D),
            "w" : 2,
            "h" : 2,
            "type" : "bigr"
        ])
        // bigL
        self.maps.append([
            "map" : [
                [ "x" : a, "y" : a  ],
                [ "x" : a, "y" : b],
                [ "x" : a, "y" : 0.5], [ "x" : b, "y" : 0.5], [ "x" : 0.5, "y" : 0.5]
            ],
            "color" : UIColor(rgb: 0x4CDAB0),
            "w" : 2,
            "h" : 2,
            "type" : "bigL"
        ])
        // bigr_inv
        self.maps.append([
            "map" : [
                [ "x" :   a, "y" : a  ], [ "x" : b, "y" : a  ], [ "x" : 0.5, "y" : a  ],
                [ "x" : 0.5, "y" : b  ],
                [ "x" : 0.5, "y" : 0.5]
            ],
            "color" : UIColor(rgb: 0xE6D463),
            "w" : 2,
            "h" : 2,
            "type" : "bigr_inv"
        ])
        // bigL_inv
        self.maps.append([
            "map" : [
                [ "x" : 0.5, "y" : a  ],
                [ "x" : 0.5, "y" : b  ],
                [ "x" :   a, "y" : 0.5], [ "x" : b, "y" : 0.5], [ "x" : 0.5, "y" : 0.5]
            ],
            "color" : UIColor(rgb: 0x41CE57),
            "w" : 0,
            "h" : 2,
            "start_w" : 2,
            "type" : "bigL_inv"
        ])
    }
}

internal var figures_map = figures()