//
//  LogViewController.swift
//  TicTacReflexToe
//
//  Created by otet_tud on 8/12/20.
//  Copyright © 2020 otet. All rights reserved.
//

import UIKit
import Firebase

class LogViewController: UIViewController {

    @IBOutlet weak var tf_uname: UITextField!
    @IBOutlet weak var tf_pwd: UITextField!
    @IBOutlet weak var logInBtn: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.view.addGestureRecognizer(tapGesture)
        
        if(retrieveData()) {
             self.performSegue(withIdentifier: "loginSuccess", sender: nil);
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureView()
    }
    
    func configureView() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.setToolbarHidden(true, animated: true)
        clearFields()
        logInBtn.layer.cornerRadius = 10
        tf_uname.layer.borderWidth = 0
        tf_uname.layer.cornerRadius = 10
        tf_uname.text = ""
        tf_pwd.layer.borderWidth = 0
        tf_pwd.layer.cornerRadius = 10
        tf_pwd.text = ""
    }

    @objc func viewTapped() {
        tf_uname.resignFirstResponder()
        tf_pwd.resignFirstResponder()
    }
    
    func clearFields() {
        tf_uname.text = ""
        tf_pwd.text = ""
    }
    
    func checkFields() -> Bool {
        if tf_uname.text!.isEmpty || tf_pwd.text!.isEmpty {
            if tf_uname.text!.isEmpty {
                tf_uname.layer.borderWidth = 1
                tf_uname.layer.borderColor = UIColor.red.cgColor
            } else {
                tf_uname.layer.borderWidth = 0
            }
            
            if tf_pwd.text!.isEmpty {
                tf_pwd.layer.borderWidth = 1
                tf_pwd.layer.borderColor = UIColor.red.cgColor
            } else {
                tf_pwd.layer.borderWidth = 0
            }
            return false
        }
        return true
    }

    @IBAction func logInBtnPressed(_ sender: Any) {
        if(!checkFields()) {
                let alertController = UIAlertController(title: "Error: ", message: "Missing mandatory fields", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
        } else {
            //Should check internet
            //Should check credentials
            //Allow Segue
            
            //Check if user is already logged In
            Auth.auth().signIn(withEmail: self.tf_uname.text!, password: self.tf_pwd.text!) { (user, error) in
                if(error != nil){
                    self.alertErrors(msg: error?.localizedDescription ?? "Unknown Error");
                }
                else{
                    self.performSegue(withIdentifier: "loginSuccess", sender: nil);
                }
            
            }
        }
    }
    

    func retrieveData() -> Bool {
        let userID = (Auth.auth().currentUser?.uid) ?? "undefined";
        print(userID)
        
        if(userID == "undefined") {
            return false
        }
        
        return true
    }
    
    func alertErrors(msg: String) {
           let alertController = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
           alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
           self.present(alertController, animated: true, completion: nil)
       }
}
