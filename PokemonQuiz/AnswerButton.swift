//
//  AnswerButton.swift
//  PokemonQuiz
//
//  Created by Hoang Doan on 11/19/16.
//  Copyright © 2016 Hoang Doan. All rights reserved.
//

import Foundation
import UIKit

class AnswerButton: UIButton {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
    }
}
