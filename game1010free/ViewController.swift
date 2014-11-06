import UIKit
import iAd

 let padding : CGFloat = 2;
 let size : CGFloat = 28;
 let map_size = 10;

class ViewController: UIViewController, ADBannerViewDelegate {
    @IBOutlet weak var adBanner: ADBannerView!
    
    let defaultColor = UIColor(rgb: 0xEEEEEE)
    var rectanglesArray = [Rectangle]()
    var figuresArray = [Figure]()
    let afterTouchYOffset : CGFloat = 70
    let figuresScaling = (300/3) / ((size + padding) * 5)
    var score = 0
    var round_score = 0
    var score_multiplier = 0
    var pointsLabel : UILabel = UILabel()
    var endGameView : UIView = UIView()
    var figures_for_test_inited : figures_for_test = figures_for_test()
    // DIMENSIONS
    let rectsHeight = 50
    let figuresHeight = 435
    var gameView : UIView?
    var blurView : UIVisualEffectView?
    var endGameViewLabel : UILabel?
    var endGameViewButton : UIButton?
    var rectsForDissapear = Array<Dictionary<String,Any>>()
    var clearNumbers = Array<Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // НАПОЛНЯЕМ МАССИВ СВОБОДНЫХ ЭЛЕМЕНТОВ
        
        for i in 0...99 {
            clearNumbers.append(i)
        }
        
        // GAME VIEW INIT
        
        gameView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        view.addSubview(gameView!)
        
        var blur = UIBlurEffect(style: UIBlurEffectStyle.Light)
        blurView = UIVisualEffectView(effect: blur)


        // LOAD IAD HIDDEN
        
        self.canDisplayBannerAds = true
        self.adBanner.delegate = self
        self.adBanner.hidden = true
        
        // MENU ADD
        func menuInit() {
            endGameView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 150))
            endGameView.center = CGPoint(x: view.center.x, y: -400)
            endGameView.backgroundColor = UIColor(rgb: 0xFFFFFF)
            endGameView.layer.shadowColor = UIColor.blackColor().CGColor
            endGameView.layer.shadowOpacity = 0.3
            endGameView.layer.shadowOffset = CGSize(width: 1, height: 3)
            view.addSubview(endGameView)
            endGameViewLabel = UILabel(frame: CGRect(x: 0, y: 0, width: endGameView.frame.width, height: 40))
            endGameViewLabel!.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 20)
            endGameViewLabel!.text = "Menu"
            endGameViewLabel!.backgroundColor = UIColor.brownColor()
            endGameViewLabel!.textAlignment = NSTextAlignment.Center
            endGameView.addSubview(endGameViewLabel!)
            
            endGameViewButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
            endGameViewButton!.backgroundColor = UIColor(rgb: 0xD6D6D6)
            endGameViewButton!.setTitle("New Game", forState: UIControlState.Normal)
            endGameViewButton!.addTarget(self, action: "startGame", forControlEvents: UIControlEvents.TouchUpInside)
            endGameViewButton!.center = CGPoint(x: endGameView.frame.size.width/2, y: 100)
            endGameView.addSubview(endGameViewButton!)

        }
        menuInit()
        showMenu(score)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // для координат внутри фигуры и других обработок
    var selectedFigure : Figure?
    var startTouchCoords : CGPoint = CGPoint()

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        // TOUCH START
        let touch = touches.allObjects[0] as UITouch
        // detect element type
        var viewCoords = touch.locationInView(view)
        //ищем в FIGURES и находим нужный RECT
        for j in figuresArray {
            let i = j.figureView.frame
            if viewCoords.x >= i.origin.x  && viewCoords.x <= i.origin.x + i.width &&
                viewCoords.y >= i.origin.y && viewCoords.y <= i.origin.y + i.height {
                    selectedFigure = j
                    selectedFigure!.start_x = selectedFigure!.figureView.frame.origin.x
                    selectedFigure!.start_y = selectedFigure!.figureView.frame.origin.y
            }
        }
        startTouchCoords = touch.locationInView(view)
        
        if selectedFigure != nil {
            // НЕМНОГО ПОДНИМАЕМ ФИГУРУ ДЛЯ УДОБСТВА
            UIView.animateWithDuration(0.1, animations: {
                self.selectedFigure!.figureView.transform = CGAffineTransformIdentity
                self.selectedFigure!.figureView.frame.origin.y -= self.afterTouchYOffset
//                self.selectedFigure!.figureView.frame.origin.x += 25
                
            })
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        // TOUCH MOVE
        let touch = touches.allObjects[0] as UITouch
        
        if (touch.view != self.view && selectedFigure != nil ) {
            let coords = touch.locationInView(self.view) as CGPoint
            
            var dx = coords.x - startTouchCoords.x as CGFloat
            var dy = coords.y - startTouchCoords.y as CGFloat
            
            selectedFigure!.figureView.frame.origin.x = selectedFigure!.start_x + dx - 25
            selectedFigure!.figureView.frame.origin.y = selectedFigure!.start_y + dy - afterTouchYOffset - 25
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        // TOUCH ENDED
        
        var modified = 0
        var rectArr : [Int] = [Int]()
        var figArr : [Int] = [Int]()
        
        if selectedFigure != nil {
            // ОБРАБОТКА ФИГУРЫ
            let figurePos : CGPoint = CGPoint(x: selectedFigure!.figureView.frame.origin.x, y: selectedFigure!.figureView.frame.origin.y)
            for var i=0; i < selectedFigure!.figure.count; i++ {
                for var j=0; j < rectanglesArray.count; j++ {
                    if selectedFigure!.figure[i].inner_x + figurePos.x + selectedFigure!.figure[i].size/2 >= rectanglesArray[j].outer_x &&
                        selectedFigure!.figure[i].inner_x + figurePos.x + selectedFigure!.figure[i].size/2 <= rectanglesArray[j].outer_x + rectanglesArray[j].size &&
                        selectedFigure!.figure[i].inner_y + figurePos.y + selectedFigure!.figure[i].size/2 >= rectanglesArray[j].outer_y &&
                        selectedFigure!.figure[i].inner_y + figurePos.y + selectedFigure!.figure[i].size/2 <= rectanglesArray[j].outer_y + rectanglesArray[j].size &&
                        rectanglesArray[j].type == "default"
                    {
                            modified++
                            rectArr.append(j)
                            figArr.append(i)
                        
                        if let q = find(clearNumbers, j) {
                            clearNumbers.removeAtIndex(q)
                        }
                    }
                }
            }
            
            if modified == selectedFigure?.figure.count {
                // ФИГУРА ПОПАЛА
                for i in selectedFigure!.figure {
                    i.box.frame.origin.x = selectedFigure!.figureView.frame.origin.x + i.inner_x
                    i.box.frame.origin.y = selectedFigure!.figureView.frame.origin.y + i.inner_y
                    view.addSubview(i.box)
                }
                
                selectedFigure!.figureView.removeFromSuperview()
                UIView.animateKeyframesWithDuration(0.1, delay: 0, options: nil, animations: {
                    for var i=0; i < rectArr.count; i++ {
                        self.rectanglesArray[rectArr[i]].type = "modified"
                        self.selectedFigure!.figure[figArr[i]].box.frame.origin.x = self.rectanglesArray[rectArr[i]].outer_x
                        self.selectedFigure!.figure[figArr[i]].box.frame.origin.y = self.rectanglesArray[rectArr[i]].outer_y
                    }
                    }, completion: { _ in
                        for var i=0; i < rectArr.count; i++ {
                            if self.selectedFigure != nil {
                                self.rectanglesArray[rectArr[i]].color = self.selectedFigure!.figure[figArr[i]].color
                                self.rectanglesArray[rectArr[i]].box.backgroundColor = self.selectedFigure!.figure[figArr[i]].color
                                self.selectedFigure!.figure[figArr[i]].box.removeFromSuperview()
                                self.round_score++
                            }
                        }
                        
                        for (index, i) in enumerate(self.figuresArray) {
                            if i===self.selectedFigure {
                                self.figuresArray.removeAtIndex(index)
                                // ПРОВЕРЯЕМ ЕСЛИ ФИГУР НЕ ОСТАЛОСЬ ТО СОЗДАЕМ НОВЫЕ ФИГУРЫ
                                if self.figuresArray.count == 0 {
                                    self.generateFigures()
                                }
                            }
                        }
                        self.breakLines(rectArr)
                    
                        var game_ended = true
                        
                        for i in self.figuresArray {
                            let res = self.tryFigureOnMap(i)
                            if res == true {
                                game_ended = false
                                break
                            }
                        }
                        
                        if game_ended == true {
                            println("игра закончена нахуй")
                            for i in self.figuresArray {
                                i.figureView.removeFromSuperview()
                            }
                            self.showMenu(self.score)
                        }
                        
                        self.selectedFigure = nil
                        rectArr.removeAll(keepCapacity: true)
                        figArr.removeAll(keepCapacity: true)

                })
                
            } else {
                // ФИГУРА НЕ ПОПАЛА И ВОЗРВРАЩАЕТСЯ НА ПРЕЖНЕЕ МЕСТО
                
                    UIView.animateKeyframesWithDuration(0.2, delay: 0, options: nil, animations: {
                        self.selectedFigure!.figureView.transform = CGAffineTransformMakeScale(self.figuresScaling, self.figuresScaling)
                        self.selectedFigure!.figureView.frame.origin.x = self.selectedFigure!.start_x
                        self.selectedFigure!.figureView.frame.origin.y = self.selectedFigure!.start_y
                    }, completion: nil)
                selectedFigure = nil
            }
        }
    }
    
    func breakLines(blocks : [Int]) {
//        var date = NSDate()
        var rows : [Int] = [Int](),
            cols : [Int] = [Int]()
        
        for (index, a) in enumerate(blocks) {
            var row = Int(floor(Float(a)/Float(map_size))),
                col = a%map_size
            var has_col = false,
                has_row = false
            for i in rows {
                if i == row { has_row = true }
            }
            for k in cols {
                if k == col { has_col = true }
            }
            if has_row == false { rows.append(row) }
            if has_col == false { cols.append(col) }
        }
        for r in rows {
            var row_full = true
            for var i = 0; i < map_size; i++ {
                var n = r * map_size + i;
                if (rectanglesArray[n].type == "default") {
                    row_full = false;
                }
            }
            if row_full == true {
                for var j = 0; j < map_size; j++ {
                    rectsForDissapear.append([
                        "n" : Int(r * map_size + j),
                        "element" : "row"
                    ])
                }
                score_multiplier++;
            }
        }
        for c in cols {
            var col_full = true;
            for var i = 0; i < map_size; i++ {
                var n = i * map_size + c;
                if (rectanglesArray[n].type == "default") {
                    col_full = false;
                }
            }
            if col_full == true {
                for var j = 0; j < map_size; j++ {
                    rectsForDissapear.append([
                        "n" : Int(j * map_size + c),
                        "element" : "col"
                    ])
                    
                }
                score_multiplier++;
            }   
        }
        
        for i in rectsForDissapear {
            var n = i["n"]! as Int
            var elem = i["element"]! as String
            dissapearing(n, element: elem)
            if let q = find(clearNumbers, n) {
            } else {
                clearNumbers.append(n)
            }
        }
        rectsForDissapear = []
        
        if score_multiplier != 0 {
            score = score + (round_score * score_multiplier) + (score_multiplier * 10) + ((score_multiplier-1) * 10)
        } else {
            score = score + round_score
        }
        setScore(score)
        round_score = 0
        score_multiplier = 0
        
//        var endDate = NSDate()
//        var exec_time = endDate.timeIntervalSinceDate(date)
//        println("breakLines \(exec_time)")
    }
    
    func dissapearing(j : Int, element : String) {
        var stTime : Float = Float()
        if element == "row" { stTime = ( (Float(j) % Float(map_size) ) + 1) * 0.02; }
        else if element == "col" { stTime = (floor(Float(j)/Float(map_size) ) + 1) * 0.02 }
        
        let delay : NSTimeInterval = NSTimeInterval(stTime)
        
        UIView.animateKeyframesWithDuration(0.3, delay: delay, options: nil, animations: {
                self.rectanglesArray[j].type = "default"
                self.rectanglesArray[j].box.transform = CGAffineTransformMakeScale(1.2, 1.2)
                self.rectanglesArray[j].box.backgroundColor = self.defaultColor
            }, completion: {
                _ in
                self.rectanglesArray[j].box.transform = CGAffineTransformIdentity
                self.rectanglesArray[j].color = self.defaultColor
                self.rectanglesArray[j].box.backgroundColor = self.defaultColor
        })
    }
    
    func generateFigures() {
//        var date = NSDate()
        var figuresPositions : [CGFloat] = [view.frame.width/6, view.frame.width/2, view.frame.width*5/6]
        for var i = 0; i < 3; i++ {
            var cnt = UInt32(figures_map.maps.count)
            var figNumber = Int(arc4random_uniform(cnt))
            var figureView = UIView(frame: CGRect(x: 0, y: 0, width: (size + padding) * 5, height: (size + padding) * 5))
            var fig = Figure(map: figures_map.maps[figNumber]["map"] as [NSDictionary],
                             color: figures_map.maps[figNumber]["color"] as UIColor,
                             view : gameView!,
                             figure_view : figureView,
                             x: figuresPositions[i],
                             w: figures_map.maps[figNumber]["w"] as Int,
                             h: figures_map.maps[figNumber]["h"] as Int,
                             type: figures_map.maps[figNumber]["type"] as String,
                             start_w_offset : figures_map.maps[figNumber]["start_w"] as? Int
            )
            figureView.center = CGPoint(x: figuresPositions[i], y: CGFloat(figuresHeight))
            view.addSubview(figureView)
            for i in fig.figure {
                figureView.addSubview(i.box)
            }
            figureView.transform = CGAffineTransformMakeScale(figuresScaling, figuresScaling)
            
            figuresArray.append(fig)
        }
//        var endDate = NSDate()
//        var exec_time = endDate.timeIntervalSinceDate(date)
//        println("generateFigures \(exec_time)")
    }
    
    func setScore(score : Int) {
        pointsLabel.text = String(score)
    }
    
    
    // FOR TESTS
//    var last_rects = Array<UIView>()
    
    func tryFigureOnMap(figure : Figure) -> Bool {
//        var date = NSDate()
        let rect_map = figures_for_test_inited.maps[figure.type]!
        let except_first_element_width = figure.w
        let start_width_offset = figure.start_w_offset == nil ? 0 : figure.start_w_offset
        let except_first_element_height = figure.h
        var rect_figures = Array<Array<Int>>()
        var rect_offsets = Array<Array<Int>>()
        var num = Int()
        var direction : Bool = except_first_element_width > except_first_element_height
        
        for var c = 0; c < map_size; c++ {
            for var r = 0; r < map_size; r++ {
                num = c * map_size + r
                
                if rectanglesArray[num].type == "default" {
                    var counter = 0
                    var array_helpers = Array<Int>()
                    
                    if r < map_size - except_first_element_width && c < map_size - except_first_element_height && r >= start_width_offset {
                        for (index, i) in enumerate(rect_map) {
                            
                            let need_num = num + i
//                            println("фигура образуется из \(need_num) в точке \(num)")
                            
                            if let q = find(clearNumbers, need_num) {
                                counter++
                                array_helpers.append(need_num)
                            } else {
//                                println("для квадрата  \(need_num) нет ячейки в списке свободных квадратов")
                                break
                            }
                        }
//                        println("========")
                        if counter == rect_map.count {
//                            var endDate = NSDate()
//                            var exec_time = endDate.timeIntervalSinceDate(date)
//                            println("tryFiguresOnMap \(exec_time)")
                            
                            // tests
//                            for i in last_rects {
//                                i.removeFromSuperview()
//                            }
//                            last_rects = []
//                            for i in array_helpers {
//                                let rect = rectanglesArray[i]
//                                var q : UIView = UIView(frame: CGRect(x: rect.outer_x, y: rect.outer_y, width: rect.size, height: rect.size))
//                                q.backgroundColor = UIColor.blueColor()
//                                q.alpha = 0.1
//                                view.addSubview(q)
//                                last_rects.append(q)
//                            }
                            //
                            return true
                        }
                    }
                }
            }
        }
        return false
    }
    
    func showMenu(score : Int) {
        blurView!.frame = CGRect(x: 0, y: 0, width: gameView!.frame.width, height: gameView!.frame.height)
        gameView!.addSubview(blurView!)
        endGameViewLabel!.text = score != 0 ? "Your score: " + String(score) : "Hello"
        
        UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: nil, animations: {
            self.endGameView.center = CGPoint(x: self.view.center.x, y: self.view.center.y)
//            self.endGameView.center = CGPoint(x: self.view.center.x, y: 20)
        }, completion: nil)
    }
    
    func hideMenu() {
        
        blurView!.removeFromSuperview()
        
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: nil, animations: {
            self.endGameView.center = CGPoint(x: self.view.center.x, y: -200)
        }, completion: nil)
    }
    
    func startGame() {
        endGame()
        hideMenu()
        // POINTS LABEL
        pointsLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        pointsLabel.center = CGPoint(x: 160, y: 25)
        pointsLabel.textAlignment = NSTextAlignment.Center
        pointsLabel.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 20)
        pointsLabel.text = String(0)
        gameView!.addSubview(pointsLabel)
        
        // GENERATING MAP
        for i in 1...map_size {
            for j in 1...map_size {
                let _x = (view.frame.width - CGFloat(map_size) * (CGFloat(size) + CGFloat(padding)))/2 + CGFloat(j-1) * (size + padding)
                let _y = CGFloat(rectsHeight) + CGFloat(i-1) * (size + padding)
                var r = Rectangle(type: "default", x: _x, y: _y, size: size, color: defaultColor, view: gameView!,real_x : _x, real_y : _y)
                rectanglesArray.append(r)
            }
        }
        
        // GENERATE FIGURE
        generateFigures()
    }
    
    func endGame() {
        for i in gameView!.subviews {
            i.removeFromSuperview()
        }
        figuresArray = []
        rectanglesArray = []
        score = 0
        round_score = 0
        clearNumbers = []
        for i in 0...99 {
            clearNumbers.append(i)
        }
    }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        adBanner.hidden = false
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        adBanner.hidden = true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}

