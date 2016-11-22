//
//  SettingViewController.swift
//  PokemonQuiz
//
//  Created by Hoang Doan on 11/20/16.
//  Copyright © 2016 Hoang Doan. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    
    @IBOutlet var geneCollection: [GeneButton]!


    @IBAction func backToHome(_ sender: AnyObject) {
         navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func selectGene(_ sender: UIButton) {
       
        if (sender.alpha < 1) {
            sender.alpha = 1
        } else {
            sender.alpha = 0.5
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
