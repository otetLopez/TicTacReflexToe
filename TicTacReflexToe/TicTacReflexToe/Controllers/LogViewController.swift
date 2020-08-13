//
//  LogViewController.swift
//  TicTacReflexToe
//
//  Created by otet_tud on 8/12/20.
//  Copyright © 2020 otet. All rights reserved.
//

import UIKit

class LogViewController: UIViewController {

    @IBOutlet weak var tf_uname: UITextField!
    @IBOutlet weak var tf_pwd: UITextField!
    
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
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.setToolbarHidden(true, animated: true)
        clearFields()
    }

    @objc func viewTapped() {
        tf_uname.resignFirstResponder()
        tf_pwd.resignFirstResponder()
    }
    
    func clearFields() {
        tf_uname.text = ""
        tf_pwd.text = ""
    }

}
