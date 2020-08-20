//
//  WhosMoveLabel.swift
//  TicTacReflexToe
//
//  Created by DKU on 19.08.2020.
//  Copyright © 2020 otet. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class WhosMoveLabel: UILabel {
    
    let ref : DatabaseReference! = Database.database().reference();
    let userID : String = (Auth.auth().currentUser?.uid)!

    
    
 
    
    func listen(game: Game, userId: String) {
        
        update(game: game, userId: userId)
        _ = game.changed { [weak self](game, uint) in
            guard let _game = game else {return  print(Error.self) }
            self?.update(game: _game, userId: userId)
        }
    }

    func update(game: Game, userId: String) {
       
        if let winner = game.winner {
            switch winner.uid {
            case "DRAW":
                self.text = "DRAW"
            default:
                if(winner.uid == userId){
                    self.text = "You Win"
                    ref?.child("users").child(userID).observeSingleEvent(of: .value, with: {(snapshot) in
                    let points = (snapshot.value as! NSDictionary)["Point"] as! Int
                    self.ref.child("users").child(userId).setValue(["Point": points+100 ])
                    })
                   
                }
                
                else{
                     self.text = "You Lose"
                    ref?.child("users").child(userID).observeSingleEvent(of: .value, with: {(snapshot) in
                    let points = (snapshot.value as! NSDictionary)["Point"] as! Int
                    self.ref.child("users").child(userId).setValue(["Point": points-50100 ])
                    })
                }
                
            }
            return
        }
        
        switch game.canPlay() {
        case false:
            self.text = "Waiting for player"
            return
        default: break
        }

        switch game.canMove(id: userId) {
        case false:
            self.text =  NextMoveText.theirs.rawValue
        case true:
            self.text = NextMoveText.yours.rawValue
        }
    }
}

