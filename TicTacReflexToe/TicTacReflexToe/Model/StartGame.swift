//
//  StartGame.swift
//  TicTacReflexToe
//
//  Created by DKU on 19.08.2020.
//  Copyright © 2020 otet. All rights reserved.
//

import Foundation

public struct StartGame: Codable {
    public let player: PlayerType
    public let uid: String
    //public let userName : String
}

extension StartGame {
    
    public func dictionary() -> NSDictionary {
        let data = try! JSONEncoder.init().encode(self)
        let dict = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
        return dict as! NSDictionary
    }
    
}

