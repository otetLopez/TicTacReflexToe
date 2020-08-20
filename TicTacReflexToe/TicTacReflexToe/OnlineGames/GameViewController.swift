//
//  GameViewController.swift
//  TicTacReflexToe
//
//  Created by DKU on 19.08.2020.
//  Copyright © 2020 otet. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth



open class GameViewController: UIViewController {
    
    var game: Game!
    
    @IBOutlet weak var result_lbl: UILabel!
    @IBOutlet weak var board_img: UIImageView!
    var user: User! = Auth.auth().currentUser;
    
    var gameRef: DatabaseReference!
    
    lazy var background: DispatchQueue = {
        return DispatchQueue.init(label: "games.background.queue" , attributes: .concurrent)
    }()
    
//    @IBOutlet weak var boardWrapper: UIView! {
//        didSet {
//            guard let board = self.boardWrapper else { return }
//            board.layer.borderColor = UIColor.lightGray.cgColor
//            board.layer.borderWidth = 1
//            board.backgroundColor = UIColor.lightGray
//        }
//    }
    
    @IBOutlet weak var xJoinButton: PlayerXButton! {
        didSet {
            guard let button = self.xJoinButton else { return }
            button.listen(game: self.game, userId: self.user.uid)
        }
    }
    
    @IBOutlet weak var oJoinButton: PlayerOButton!{
        didSet {
            guard let button = self.oJoinButton else { return }
            button.listen(game: self.game, userId: self.user.uid)
        }
    }
    
    @IBOutlet weak var whosMoveLabel: WhosMoveLabel!
    @IBOutlet var buttons: [GameButton]!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var gameIdlabel: UILabel!
    @IBAction func buttonTapped(_ sender: GameButton) {
        
        guard self.game.canPlay(), let marker = self.game.userMarker(id: self.user.uid) else {
            return print(Error.self)
        }
       
        if((self.game.canMove(id: user.uid))){
        
        let tag = sender.tag
        
        self.background.async {
            guard self.game.move(tile: Tile.create(rawValue: tag), userId: self.user.uid) else {
                return
            }
            DispatchQueue.main.async {
                sender.set(title: marker)
                sender.titleLabel?.isHidden=true
                if(marker == "X"){
                    sender.setImage(UIImage(named: "cross.png"), for: [])
                }
                
                else{
                    sender.setImage(UIImage(named: "nought.png"), for: [])
                }
            }
            }
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Game"
      //  self.userIdLabel.text = "UserId: \(self.user.uid)"
        self.whosMoveLabel.listen(game: self.game, userId: self.user.uid)
        board_img.layer.cornerRadius=10;
       // self.gameIdlabel.text = self.game.id
        self.validate(game: self.game)
        
        gameRef = self.game.changed { [weak self](changeGame, uint) in
            guard let f = changeGame else { return }
            self?.game = f
            self?.validate(game: f)
        }
    }
    
    func validate(game: Game) {

        game.moves?.enumerated().forEach({ (v) in
            let move = v.element
            let title = move.uid == self.user.uid ? game.marker() : game.otherMarker()
            self.buttons[move.tile.number].set(title: title)
        })
        
        self.setButtonsState(canPlay: game.canPlay())
        
    }
    
    func setButtonsState(canPlay: Bool) {
   
        self.buttons.forEach {
            i in i.update(canPlay: canPlay)
            
        }
        self.buttons.enumerated().forEach { (i) in
            guard let winner = self.game.winner , winner.uid != "DRAW" , let tiles = winner.tiles else { return }
            if tiles.contains(i.offset) {
                i.element.backgroundColor = .orange
            }
        }
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.gameRef.removeAllObservers()
    }
  
    public static func instance(game: Game , user: User) -> GameViewController {
        let sb = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let vc = sb.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        vc.game = game
        vc.user = user
        return vc
    }
    
}
