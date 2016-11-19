//
//  GameSceneViewController.swift
//  PokemonQuiz
//
//  Created by Hoang Doan on 11/19/16.
//  Copyright © 2016 Hoang Doan. All rights reserved.
//

import UIKit

class GameSceneViewController: UIViewController {
    @IBOutlet weak var backgroundLayer: UIView!

    @IBOutlet weak var pokemonImage: UIImageView!

    @IBOutlet var buttonGroup : [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var pokemonInfo: UILabel!
    
    
    @IBOutlet weak var progressView: RPCircularProgress!
    
    @IBAction func backToMenu(_ sender: AnyObject) {
        navigationController?.popViewController(animated: true)
    }
    
    
    var gameScore: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backgroundLayer.layer.cornerRadius = 10
        self.pokemonImage.image = self.pokemonImage.image?.withRenderingMode(.alwaysTemplate)
        self.pokemonInfo.isHidden = true
//        self.progressView.progressTintColor = UIColor.white
//        self.progressView.innerTintColor = UIColor.lightText
//        self.progressView.clockwiseProgress = true
//        self.progressView.trackTintColor = UIColor.white

        self.progressView.updateProgress(1, animated: true, initialDelay: 0, duration: 5) {
            self.pokemonImage.image = self.pokemonImage.image?.withRenderingMode(.alwaysOriginal)
            self.pokemonInfo.text = "#384" + " " + "Rayquaza"
            self.pokemonInfo.isHidden = false
            for button in self.buttonGroup {
                button.isUserInteractionEnabled = false
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionAnswer(_ sender: UIButton) {
        var rightTag: Int = 0
        self.pokemonImage.image = self.pokemonImage.image?.withRenderingMode(.alwaysOriginal)
        self.pokemonInfo.text = "#384" + " " + "Rayquaza"
        self.pokemonInfo.isHidden = false
        if sender.titleLabel?.text == "Right" {
            sender.backgroundColor = UIColor.green
            self.gameScore += 1
            self.scoreLabel.text = String(self.gameScore)
            rightTag = sender.tag
        } else {
            sender.backgroundColor = UIColor.red
            for button in self.buttonGroup {
                
                if button.titleLabel?.text == "Right" {
                    button.backgroundColor = UIColor.green
                }
                
                if button.tag == rightTag {
                    button.backgroundColor = UIColor.green
                    break
                }
            }
        }
        
        for button in self.buttonGroup {
            button.isUserInteractionEnabled = false
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
