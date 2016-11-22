//
//  GameSceneViewController.swift
//  PokemonQuiz
//
//  Created by Hoang Doan on 11/19/16.
//  Copyright © 2016 Hoang Doan. All rights reserved.
//

import UIKit

class GameSceneViewController: UIViewController {
    
    @IBOutlet var screenBackground: UIView!
    @IBOutlet weak var backgroundLayer: UIView!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet var buttonGroup : [AnswerButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var pokemonInfo: UILabel!
    @IBOutlet weak var progressView: RPCircularProgress!
    
    @IBAction func backToMenu(_ sender: AnyObject) {
        navigationController?.popViewController(animated: true)
    }
    
    static var pokemonCollection = [Pokemon]()
    var rightPokemon = Pokemon()
    
    var gameScore: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.setValue(0, forKey: "CurrentScore")
        self.backgroundLayer.layer.cornerRadius = 10
        self.createGame()
        
        self.progressView.updateProgress(1, animated: true, initialDelay: 0, duration: 30) {
            self.pokemonImage.image = self.pokemonImage.image?.withRenderingMode(.alwaysOriginal)
            self.pokemonImage.image = UIImage(named: self.rightPokemon.pokemonImg!)
            self.pokemonInfo.text = self.rightPokemon.pokemonTag! + " " + self.rightPokemon.pokemonName!
            self.pokemonInfo.isHidden = false
            for button in self.buttonGroup {
                button.isUserInteractionEnabled = false
            }
            let when = DispatchTime.now() + 1 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.navigationController?.popViewController(animated: true)

            }
        }
    }
    
    func createGame() {
        
        
        
        for button in self.buttonGroup {
            button.isUserInteractionEnabled = true
            button.backgroundColor = UIColor.white
        }
        self.pokemonInfo.isHidden = true
        
        let pokemonIndex = Int(arc4random_uniform(UInt32(3)))
        DataManager.shared.generatePokemon()
        self.rightPokemon = GameSceneViewController.pokemonCollection[pokemonIndex]
        
        self.screenBackground.backgroundColor = self.hexStringToUIColor(hex: self.rightPokemon.pokemonColor!)
        

        self.pokemonImage.image = UIImage(named: self.rightPokemon.pokemonImg!)
        self.pokemonImage.image = self.pokemonImage.image?.withRenderingMode(.alwaysTemplate)
        self.pokemonInfo.text = self.rightPokemon.pokemonTag! + " " + self.rightPokemon.pokemonName!
        
        for (index, button) in buttonGroup.enumerated() {
            button.pokemon = GameSceneViewController.pokemonCollection[index]
            button.setTitle(button.pokemon?.pokemonName, for: .normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionAnswer(_ sender: UIButton) {
        var rightTag: Int = 0

        
//        for button in self.buttonGroup {
//            button.isUserInteractionEnabled = false
//        }
        
//        let when = DispatchTime.now() + 1 // change 2 to desired number of seconds
//        DispatchQueue.main.asyncAfter(deadline: when) {
//            self.createGame()
//        }
        
        UIView.transition(with: self.backgroundLayer, duration: 0.3, options: .transitionFlipFromRight, animations: {
            self.pokemonImage.image = self.pokemonImage.image?.withRenderingMode(.alwaysOriginal)
            self.pokemonInfo.isHidden = false
            if sender.titleLabel?.text == self.rightPokemon.pokemonName {
                sender.backgroundColor = UIColor.green
                self.gameScore += 1
                self.scoreLabel.text = String(self.gameScore)
                UserDefaults.standard.setValue(self.gameScore, forKey: "CurrentScore")
                rightTag = sender.tag
            } else {
                sender.backgroundColor = UIColor.red
                for button in self.buttonGroup {
                    
                    if button.titleLabel?.text == self.rightPokemon.pokemonName {
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
        }) { (complete) in
            

            let when = DispatchTime.now() + 0.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.createGame()
            }
            
        }
        
    }
    
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
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
