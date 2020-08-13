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
        clearFields()
    }

    @objc func viewTapped() {
        tf_uname.resignFirstResponder()
        tf_email.resignFirstResponder()
        tf_pwd.resignFirstResponder()
        tf_cpwd.resignFirstResponder()
    }

    @IBAction func save_btn_pressed(_ sender: UIButton) {
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
}
