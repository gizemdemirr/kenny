//
//  ViewController.swift
//  kenny
//
//  Created by Gizem on 15.06.2022.
//

import UIKit

class ViewController: UIViewController {
//variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var kennyArray = [UIImageView]()
    var hideTimmer = Timer()
    var highScore = 0
// views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        highscore u kontrol etmek
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "HighScore: \(highScore)"
        }
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "HighScore: \(highScore)"
        }
        
        scoreLabel.text = "Score: \(score)"
// kullanıcıların kennynin üstüne tıklamsını etkin hale getirir
//        images
        kenny1.isUserInteractionEnabled =  true
        kenny2.isUserInteractionEnabled =  true
        kenny3.isUserInteractionEnabled =  true
        kenny4.isUserInteractionEnabled =  true
        kenny5.isUserInteractionEnabled =  true
        kenny6.isUserInteractionEnabled =  true
        kenny7.isUserInteractionEnabled =  true
        kenny8.isUserInteractionEnabled =  true
        kenny9.isUserInteractionEnabled =  true
        
//        image e tıkladığında ne yapacağını yazdığımız yer (UITapGestureRecognizer)
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)
        
        kennyArray = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]
        
//        timers
        counter = 10
        timeLabel.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimmer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
        
        hideKenny()
    }
    
    @objc func hideKenny() {
        for kenny in kennyArray {
//            kennyi saklamak
            kenny.isHidden = true
        }
//        rastgale sayı oluşturmak
       let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false
    }
    
    
    
    @objc func countDown() {
        counter -= 1
        timeLabel.text = String(counter)
//        sıfıra geldiğinde
        if counter == 0 {
//            timerı durdurma
            timer.invalidate()
            hideTimmer.invalidate()
//            süre bittiğinde kennyi saklamak için
            for kenny in kennyArray {
    //            kennyi saklamak
                kenny.isHidden = true
            }
//            HIGHSCORE
            
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "HighScore: \(self.highScore)"
//                userdefault kaydetmek uygulamadan çıkıldığında bile değeri tutmak
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            
            
            let alert = UIAlertController(title: "Times Up", message: "Do you want to play again", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
//                replay function
//                score a erişebilmek için self koy
//                replay tuşuna basıldığında timer ve skoru sıfırladık labele koyduk, timerlerı tekrar çalıştırdık.
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                
                self.hideTimmer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
                
            }
//            butonları eklemek
            alert.addAction(okButton)
            alert.addAction(replayButton)
//            alerti göstermek
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }

    @objc func increaseScore() {
//        skoru bir arttırarak yazdır
        score += 1
        scoreLabel.text = "Score: \(score)"
        
    }

}

