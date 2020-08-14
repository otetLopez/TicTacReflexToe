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
    
    init(uname : String, eadd : String, pwd : String) {
        self.username = uname
        self.email = eadd
        self.passwd = pwd
        self.score = 0
    }
    
    init(uname : String, eadd : String, pwd : String, score : Int) {
        self.username = uname
        self.email = eadd
        self.passwd = pwd
        self.score = score
    }
    
    
    public func addScore() {
        self.score = self.score +  1
    }
    
    public func addScore(points : Int) {
        self.score = self.score + points
    }
    
    
    /* Getters */
    public func getUname() -> String { return self.username }
    
    public func getEmail() -> String { return self.email }
    
    public func getPassword() -> String { return self.passwd }
    
    public func getScore() -> Int { return self.score }
    
    
    /* Setters */
    public func setUname(uname: String) { self.username = uname }
    
    public func setEmail(eadd: String) { self.email = eadd }
    
    public func setPassword(pwd: String) { self.passwd = pwd }

    public func setScore(score: Int) { self.score = score }
    
    
    
    var description: String {
        var detailStr = "--------------------------------\nName: \(self.username)\nEmail: \(self.email)\nPassword: \(self.passwd)\nScore: \(self.score)\n"
        detailStr += "--------------------------------\n"
        return detailStr
    }
    
}

