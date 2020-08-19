//
//  ProfileViewController.swift
//  TicTacReflexToe
//
//  Created by otet_tud on 8/19/20.
//  Copyright © 2020 otet. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var uname: UIButton!
    @IBOutlet weak var eadd: UIButton!
    @IBOutlet weak var score: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signout_btn_pressed(_ sender: UIButton) {
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
