//
//  RegisterViewController.swift
//  TicTacReflexToe
//
//  Created by otet_tud on 8/12/20.
//  Copyright © 2020 otet. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var tf_uname: UITextField!
    @IBOutlet weak var tf_email: UITextField!
    @IBOutlet weak var tf_pwd: UITextField!
    @IBOutlet weak var tf_cpwd: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureView()
    }
    
    func configureView() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.setToolbarHidden(true, animated: true)
        self.navigationItem.hidesBackButton = true
        
        saveBtn.layer.cornerRadius = 10
        cancelBtn.layer.cornerRadius = 10
        
        clearFields()
    }

    @objc func viewTapped() {
        tf_uname.resignFirstResponder()
        tf_email.resignFirstResponder()
        tf_pwd.resignFirstResponder()
        tf_cpwd.resignFirstResponder()
    }

    @IBAction func save_btn_pressed(_ sender: UIButton) {
        if(checkFields()) {
            // Create new user
            
        }
    }

    @IBAction func cancel_btn_pressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Cancelling Registration", message: "Are you sure?", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        let cancelAction = UIAlertAction(title: "Yes", style: .default, handler: {
                action in
            self.cancelRegistration()
        })
        
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func cancelRegistration() {
        clearFields()
        self.navigationController?.popToRootViewController(animated: true)
    }
    func clearFields() {
        tf_uname.text = ""
        tf_email.text = ""
        tf_pwd.text = ""
        tf_cpwd.text = ""
    }
    
    func checkFields() -> Bool {
        var isIncomplete : Bool = false
        if tf_uname.text!.isEmpty {
            tf_uname.layer.borderWidth = 1
            tf_uname.layer.borderColor = UIColor.red.cgColor
            isIncomplete = true
        } else {
            tf_uname.layer.borderWidth = 0
        }
        if tf_email.text!.isEmpty {
            tf_email.layer.borderWidth = 1
            tf_email.layer.borderColor = UIColor.red.cgColor
            isIncomplete = true
        } else {
            tf_email.layer.borderWidth = 0
        }
        if tf_pwd.text!.isEmpty {
            tf_pwd.layer.borderWidth = 1
            tf_pwd.layer.borderColor = UIColor.red.cgColor
            isIncomplete = true
        } else {
            tf_pwd.layer.borderWidth = 0
        }
        if tf_cpwd.text!.isEmpty {
            tf_cpwd.layer.borderWidth = 1
            tf_cpwd.layer.borderColor = UIColor.red.cgColor
            isIncomplete = true
        } else {
            tf_cpwd.layer.borderWidth = 0
        }

        if(isIncomplete == true) {
            alertErrors(msg: "Missing fields")
        } else {
            /* Check passwords */
            if isPasswordValid() == true {
                return true
            }
        }
        return false
    }
    
    func isPasswordValid() -> Bool {
        var isPwdValid : Bool = true
        /* Check if password is Strong */
        if tf_pwd.text?.count ?? 0 < 6 {
            print("DEBUG: RegisterViewController isPasswordValid() Password Weak")
            alertErrors(msg: "Password Weak")
            isPwdValid = false
        } else if tf_pwd.text! != tf_cpwd.text! {
            print("DEBUG: RegisterViewController isPasswordValid() Passwords did not match")
            alertErrors(msg: "Passwords did not match")
            isPwdValid = false
        }
        
        if isPwdValid == false {
            tf_pwd.layer.borderWidth = 1
            tf_pwd.layer.borderColor = UIColor.red.cgColor
            tf_cpwd.layer.borderWidth = 1
            tf_cpwd.layer.borderColor = UIColor.red.cgColor
        } else {
            tf_pwd.layer.borderWidth = 0
            tf_cpwd.layer.borderWidth = 0
        }
        return isPwdValid
    }
    
    func alertErrors(msg: String) {
        let alertController = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
}
