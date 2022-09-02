//
//  ViewController.swift
//  CatchThePikaGame
//
//  Created by Tunahan Çelik on 1.09.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    
    var imgArray = [UIImageView]()
    
    @IBOutlet weak var img9: UIImageView!
    @IBOutlet weak var img8: UIImageView!
    @IBOutlet weak var img7: UIImageView!
    @IBOutlet weak var img6: UIImageView!
    @IBOutlet weak var img5: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img1: UIImageView!
    
    //Variables
    var score = 0
    var timer = Timer()
    var hideTimer = Timer()
    var time = 20
    var highScore = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gui()
        
        let highStored = UserDefaults.standard.object(forKey: "score")
        
        if highStored == nil {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
       
        scoreLabel.text = "Score: \(score)"
        
        gameStart()
        
        if let newScore = highStored as? Int{
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        
        
        
        
    }
    
    @objc func incraseScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    @objc func hideImg(){
       
        for linux in imgArray{
            linux.isHidden = true
        }
        
        let index = Int.random(in: 0..<imgArray.count)
        imgArray[index].isHidden = false
    }
    @objc func timerFunc(){
        time -= 1
        timeLabel.text = String(time)
        
        if time == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            for linux in imgArray{
                linux.isHidden = true
            }
            highScoreSet(score: score)
            let  alert = UIAlertController(title: "Time's Up!", message: "Your's Score: \(score) \nDo you want to play again", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Okey", style: UIAlertAction.Style.cancel, handler: nil)
            let replay = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
               
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.time = 20
                self.timeLabel.text = String(self.time)
                
                self.gameStart()
                
                
            }
            
            alert.addAction(okButton)
            alert.addAction(replay)
            
            self.present(alert, animated: true)
            
        }
        
        
        
    }

    func gui(){
        img1.isUserInteractionEnabled = true
        img2.isUserInteractionEnabled = true
        img3.isUserInteractionEnabled = true
        img4.isUserInteractionEnabled = true
        img5.isUserInteractionEnabled = true
        img6.isUserInteractionEnabled = true
        img7.isUserInteractionEnabled = true
        img8.isUserInteractionEnabled = true
        img9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(incraseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(incraseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(incraseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(incraseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(incraseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(incraseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(incraseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(incraseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(incraseScore))
        
        img1.addGestureRecognizer(recognizer1)
        img2.addGestureRecognizer(recognizer2)
        img3.addGestureRecognizer(recognizer3)
        img4.addGestureRecognizer(recognizer4)
        img5.addGestureRecognizer(recognizer5)
        img6.addGestureRecognizer(recognizer6)
        img7.addGestureRecognizer(recognizer7)
        img8.addGestureRecognizer(recognizer8)
        img9.addGestureRecognizer(recognizer9)
        
        
        imgArray =  [img1, img2, img3, img4, img5, img6, img7, img8, img9]
        hideLinux()
    }
    
    func hideLinux(){
        for linux in imgArray{
            linux.isHidden = true
        }
        let index = Int.random(in: 0..<imgArray.count)
        imgArray[index].isHidden = false
    }
    
    func highScoreSet(score:Int){
        
            if self.score > self.highScore{
                self.highScore = self.score
                highScoreLabel.text = "Higgscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "score")
        }
    }
    
    func gameStart(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideImg), userInfo: nil, repeats: true)
    }
    

}

