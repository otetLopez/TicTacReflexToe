//
//  ProfileViewController.swift
//  TicTacReflexToe
//
//  Created by otet_tud on 8/19/20.
//  Copyright © 2020 otet. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var uname: UIButton!
    @IBOutlet weak var eadd: UIButton!
    @IBOutlet weak var score: UIButton!
    @IBOutlet weak var outBtn: UIButton!
    
    var userEmail : String = "Email: "
    var points : Int = 0
    var userName : String = "Username: "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureView()
    }
    
    func configureView() {
        print("ProfileViewController: Configure View")
        uname.layer.cornerRadius = 5
        eadd.layer.cornerRadius = 5
        score.layer.cornerRadius = 5
        outBtn.layer.cornerRadius = 5
        
        retrieveData()
    }
    
    func setUserInfo() {
        eadd.titleLabel?.text = "Email Address: " + userEmail
        score.titleLabel?.text = "Points: \(points)"
        uname.titleLabel?.text = "Username: " + userName
    }
    
    func retrieveData() {
        let ref : DatabaseReference! = Database.database().reference();
        let userID = (Auth.auth().currentUser?.uid)!
        print("Current user ID is" + userID)
               
        ref?.child("users").child(userID).observeSingleEvent(of: .value, with: {(snapshot) in
            print(snapshot.value!)
            
            self.userEmail = (snapshot.value as! NSDictionary)["Email"] as! String
            print(self.userEmail)
            
            self.userName = (snapshot.value as! NSDictionary)["Username"] as! String
            print(self.userName)
            
            self.points = (snapshot.value as! NSDictionary)["Point"] as! Int
            print(self.points)
            
            self.setUserInfo()
        })
    }

    @IBAction func signout_btn_pressed(_ sender: UIButton) {
        print("ProfileViewController: signout_btn_pressed()")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
