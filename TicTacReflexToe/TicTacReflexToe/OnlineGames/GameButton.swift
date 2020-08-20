//
//  GameButton.swift
//  TicTacReflexToe
//
//  Created by DKU on 19.08.2020.
//  Copyright © 2020 otet. All rights reserved.
//

import UIKit

class GameButton: UIButton {

    func update(canPlay: Bool) {
        let label = self.titleLabel ?? UILabel.init()
        let t = label.text ?? ""
        self.isEnabled = canPlay ? !["O" , "X"].contains(t) :  false
    }
    
    func set(title: String) {
        setTitleColor(.black, for: .normal)
        setTitle(title, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 40)
        isEnabled = false
        self.titleLabel?.isHidden=true
        if(title == "X"){
            self.setImage(UIImage(named: "cross.png"), for: [])
        }
                      
        else{
            self.setImage(UIImage(named: "nought.png"), for: [])
        }
        
    }
}

