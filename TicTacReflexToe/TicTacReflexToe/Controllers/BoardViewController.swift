//
//  BoardViewController.swift
//  TicTacReflexToe
//
//  Created by otet_tud on 8/12/20.
//  Copyright © 2020 otet. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {
    var activePlayer = 1
    var activeGame = true
    var gameState = [0,0,0,0,0,0,0,0,0]
    let winnigCombinations = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    
    var height = 0
    var width = 0
    
    var crossReflexTime : Double = 0;
    var noughtReflexTime : Double = 0;
    var timePassed : Double = 0;
 
    var isCrossReflexMeasureActive = false
    var isNoughtReflexMeasureActive = false

    var shouldCancelReflex = false;
    
    var timer = Timer()


    
    @IBOutlet var reflexView: UIView!
    
    @IBOutlet weak var reset_btn: UIButton!
    @IBOutlet weak var result_lbl: UILabel!
    @IBOutlet weak var board_img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        height = Int(self.view.bounds.height);
        width = Int(self.view.bounds.width);
        
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureView()
    }
    
    func configureView() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.setToolbarHidden(true, animated: true)
        result_lbl.isHidden = true
        board_img.layer.cornerRadius = 10
    }
    
    @IBAction func btn_move(_ sender: UIButton) {
        print("Button is pressed")
       
        //dont let to trigger btn_move if there is no empty slot
        if(gameState.contains(0)){
        let activePosition = sender.tag - 1
        if gameState[activePosition] == 0 && activeGame {
            gameState[activePosition] = activePlayer
            if activePlayer == 1 {
                sender.setImage(UIImage(named: "nought.png"), for: [])
                activePlayer = 2
            } else {
                sender.setImage(UIImage(named: "cross.png"), for: [])
                activePlayer = 1
            }
        }
        
        for combination in winnigCombinations {

            if gameState[combination[0]] != 0 && gameState[combination[1]] == gameState[combination[2]] && gameState[combination[2]] == gameState[combination[0]] {
                
                // winner
                activeGame = false
                reset_btn.titleLabel?.text = " Play Again?"
                result_lbl.isHidden = false
                
                if gameState[combination[0]] == 1 {
                    print("winner is nought")
                    result_lbl.text = "Winner: Nought!"
                    
                } else {
                    print("winner is cross")
                    result_lbl.text = "Winner: Cross!"
                }
                
                break
            }
            
            //draw
            if(!gameState.contains(0)){
                
                if(!isCrossReflexMeasureActive && !isNoughtReflexMeasureActive){
                    isCrossReflexMeasureActive = true ;
                    reset_btn.isHidden=true;
                    notifyUserToPrepareForReflex(player: "Cross")
                }
                break
            }
            
        }
        
       
    }
}
    
    @IBAction func new_game_req(_ sender: UIButton) {
        timer.invalidate()
        isNoughtReflexMeasureActive=false
        isCrossReflexMeasureActive=false
        crossReflexTime=0
        noughtReflexTime=0
        timePassed=0
        
        reset_btn.titleLabel?.text = " Reset Game"
        result_lbl.isHidden = true
        gameState = [0,0,0,0,0,0,0,0,0]
        activeGame = true
        for i in 1..<10 {
            if let button = view.viewWithTag(i) as? UIButton {
                button.setImage(nil, for: [])
            }
        }
    }
        
    func showDotToMeasureReflexFor(){
        
        let randomXPoint = Int.random(in:0...width-100);
        let randomYPoint = Int.random(in:0...height-100);
        let showDotTime :Double = Double(Int.random(in: 3...12))
       
        self.reflexView.frame = CGRect(x: randomXPoint, y: randomYPoint, width: 100, height: 100);
        
        self.reflexView.layer.cornerRadius = self.reflexView.bounds.height/2;
        self.reflexView.layer.masksToBounds = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + showDotTime) { [unowned self] in
            if(!self.shouldCancelReflex){
            self.view.addSubview(self.reflexView);
            self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
            }
           }
     
    }
    
    @objc func updateTimer() {
        print("timergirdi");
        if(timePassed < 5){
            timePassed += 0.1
        }
        
            //if there's no response from user/s
        else{
            timer.invalidate()
            
            if(isCrossReflexMeasureActive){
                crossReflexTime = 10
                isCrossReflexMeasureActive = false
                self.reflexView.removeFromSuperview()
                notifyUserToPrepareForReflex(player: "Nought")
                timePassed=0
            }
            
            else{
                noughtReflexTime = 10
                isNoughtReflexMeasureActive = false
                self.reflexView.removeFromSuperview()
                //if both not respond to relex dot
                if(crossReflexTime == 10 && noughtReflexTime == 10){
                    print("buraadagirdi")
                result_lbl.isHidden = false
                self.result_lbl.text = "Both Lost The Game"
                reset_btn.isHidden=false;
                timePassed=0
                    
            
                }
            }
 
        }
    }
    
    
    @IBAction func subViewReflexButton(_ sender: UIButton) {
        
        if(isCrossReflexMeasureActive){
            crossReflexTime = timePassed
            isCrossReflexMeasureActive = false
            self.reflexView.removeFromSuperview()
            isNoughtReflexMeasureActive = true
            notifyUserToPrepareForReflex(player: "Nought")
       
        }
        
        else{
            self.reflexView.removeFromSuperview()
            noughtReflexTime = timePassed
            isNoughtReflexMeasureActive = false
        }
        
        timer.invalidate()
        
        if(!isCrossReflexMeasureActive && !isNoughtReflexMeasureActive){
            //define the winner
            print("kazanan")
            result_lbl.isHidden = false
            if (crossReflexTime < noughtReflexTime) {
                result_lbl.text = "Winner: Cross!"
                             
            } else {
           
            result_lbl.text = "Winner: Nought!"
                
            }
        }
        timePassed=0
        reset_btn.isHidden=false;
    }
    
    
    
    func notifyUserToPrepareForReflex(player: String) -> Void {
    
        let alert = UIAlertController(title: "", message: "\(player) Be Ready To Push Blue Point As Fast As You Can To Beat Your Opponent\nYou Have 5 Seconds", preferredStyle: UIAlertController.Style.alert)

        present(alert, animated: true) {
            self.showDotToMeasureReflexFor()
        }
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [unowned self] in
            self.dismiss(animated: true)
    
        }
    }
   
}


