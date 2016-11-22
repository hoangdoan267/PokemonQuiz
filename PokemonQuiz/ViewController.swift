//
//  ViewController.swift
//  PokemonQuiz
//
//  Created by Hoang Doan on 11/17/16.
//  Copyright © 2016 Hoang Doan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentScore: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var gameLabel: UILabel!
    
    var highScore:Int = 0
    var current:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.setValue(0, forKey: "CurrentScore")
        self.highScore = UserDefaults.standard.value(forKey: "HighScore") as! Int
        self.current = UserDefaults.standard.value(forKey: "CurrentScore") as! Int
        print(highScore)
        if (highScore > 0) {
            highScoreLabel.text = String(highScore)
            highScoreLabel.isHidden = false
        } else {
            highScoreLabel.isHidden = true
        }

        self.currentScore.text = String(current)
         // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.highScore = UserDefaults.standard.value(forKey: "HighScore") as! Int
        self.current = UserDefaults.standard.value(forKey: "CurrentScore") as! Int
        self.currentScore.text = String(current)
        if highScore < current {
            UserDefaults.standard.set(current, forKey: "HighScore")
            gameLabel.text = "NEW HIGHSCORE"
            highScoreLabel.text = String(current)
            highScoreLabel.isHidden = true
            
            
        } else {
            highScoreLabel.text = String(highScore)
            gameLabel.text = "HIGHSCORE"
            highScoreLabel.isHidden = false
            
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

