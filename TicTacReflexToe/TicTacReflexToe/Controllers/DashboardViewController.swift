//
//  DashboardViewController.swift
//  TicTacReflexToe
//
//  Created by otet_tud on 8/12/20.
//  Copyright © 2020 otet. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var btn_online: UIButton!
    @IBOutlet weak var btn_offline: UIButton!
    @IBOutlet weak var btn_profile: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DashboardViewController: viewDidLoad")
        configureView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("DashboardViewController: viewWillAppear")
        configureView()
    }
    func configureView() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.hidesBackButton = true
        
        btn_online.layer.cornerRadius = 10
        btn_offline.layer.cornerRadius = 10
        btn_profile.layer.cornerRadius = 10
        
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
