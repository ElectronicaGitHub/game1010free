import Foundation

struct figures_for_test {
    var maps = Dictionary<String,Array<Int>>()
    let ms = 10
    init() {
//        println("figures_for_test init")
//        self.maps["rect"] = [0, 1, 0 + ms, 1 + ms]
//        self.maps["dot"] = [0]
//        self.maps["line2h"] = [0, 1]
//        self.maps["line3h"] = [0, 1, 2]
//        self.maps["line4h"] = [0, 1, 3, 4]
//        self.maps["line5h"] = [0, 1, 3, 4, 5]
//        self.maps["line2w"] = [0, ms]
//        self.maps["line3w"] = [0, ms, ms * 2]
//        self.maps["line4w"] = [0, ms, ms * 2, ms * 3]
//        self.maps["line5w"] = [0, ms, ms * 2, ms * 3, ms * 4]
//        self.maps["bigrect"] = [0, 1 ,2, ms, ms + 1, ms + 2, ms * 2 + 0, ms * 2 + 1, ms * 2 + 2]
//        self.maps["r"] = [ 0, 1, ms]
//        self.maps["L"] = [ 0, ms, ms + 1]
//        self.maps["r_inv"] = [ 0, 1, ms + 1]
//        self.maps["L_inv"] = [ 1, ms, ms + 1]
//        self.maps["bigr"] = [0, 1, 2, ms, ms * 2]
//        self.maps["bigr_inv"] = [0, 1, 2, 2 + ms, 2 + ms * 2]
//        self.maps["bigL"] = [0, ms, ms * 2, 1 + ms * 2, 2 + ms * 2]
//        self.maps["bigL_inv"] = [2, 2 + ms, ms * 2, 1 + ms * 2, 2 + ms * 2]
        self.maps["dot"] = [0]
        self.maps["rect"] = [0, 1, 10, 11]
        self.maps["line2h"] = [0, 1]
        self.maps["line3h"] = [0, 1, 2]
        self.maps["line4h"] = [0, 1, 2, 3]
        self.maps["line5h"] = [0, 1, 2, 3, 4]
        self.maps["line2w"] = [0, 10]
        self.maps["line3w"] = [0, 10, 20]
        self.maps["line4w"] = [0, 10, 20, 30]
        self.maps["line5w"] = [0, 10, 20, 30, 40]
        self.maps["bigrect"] = [0, 1 ,2, 10, 11, 12, 20, 21, 22]
        self.maps["r"] = [ 0, 1, 10]
        self.maps["L"] = [ 0, 10, 11]
        self.maps["r_inv"] = [ 0, 1, 11]
        self.maps["L_inv"] = [ 0, 9, 10]
        self.maps["bigr"] = [0, 1, 2, 10, 20]
        self.maps["bigr_inv"] = [0, 1, 2, 12, 22]
        self.maps["bigL"] = [0, 10, 20, 21, 22]
        self.maps["bigL_inv"] = [0, 10, 18, 19, 20]
    }
}
