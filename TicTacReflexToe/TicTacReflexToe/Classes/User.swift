//
//  User.swift
//  TicTacReflexToe
//
//  Created by otet_tud on 8/14/20.
//  Copyright © 2020 otet. All rights reserved.
//

import Foundation

class User : CustomStringConvertible {

    
    private var username : String
    private var email : String
    private var passwd : String
    private var score : Int
    
    init() {
        self.username = ""
        self.email = ""
        self.passwd = ""
        self.score = 0
    }
    
    init(uname : String, eadd : String, pwd : String, score : Int) {
        self.username = uname
        self.email = eadd
        self.passwd = pwd
        self.score = score
    }
    
    var description: String {
        var detailStr = "--------------------------------\nName: \(self.username)\nEmail: \(self.email)\nPassword: \(self.passwd)\nScore: \(self.score)\n"
        detailStr += "--------------------------------\n"
        return detailStr
    }
    
}

