//
//  MainController.swift
//  Multiplayer Hangman
//
//  Created by Emma Rose Wirshing on 11/27/16.
//  Copyright © 2016 Emma Rose Wirshing. All rights reserved.
//

import UIKit
var gameID = ""
var submittedWord = ""

class MainController: UIViewController {
    
    var textField = UITextField()
    var gameLabel = UILabel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Menu"
        view.backgroundColor = .white
        
        let title = UILabel(frame: CGRect(x: 0, y: 100, width: self.view.frame.width, height: 100))
        title.text = "MULTIPLAYER HANGMAN"
        title.center.x = self.view.center.x
        title.numberOfLines = 2
        title.lineBreakMode = NSLineBreakMode.byWordWrapping
        title.textAlignment = .center
        title.font = UIFont.boldSystemFont(ofSize: 35)
        view.addSubview(title)
        
        let directions = UILabel(frame: CGRect(x: 0, y: 180, width: 325, height: 200))
        directions.text = "Directions: Everyone in the group should set the same GameID. One group member should press Set Word and set up the game. After they're done, everyone else should press Play Hangman and start playing!"
        directions.center.x = self.view.center.x
        directions.numberOfLines = 6
        directions.lineBreakMode = NSLineBreakMode.byWordWrapping
        directions.textAlignment = .center
        directions.font = UIFont.boldSystemFont(ofSize: 18)
        view.addSubview(directions)
        
        textField = UITextField(frame: CGRect(x:85, y: 400, width: 150, height: 25))
        textField.placeholder = " Enter GameID"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        view.addSubview(textField)
        
        gameLabel = UILabel(frame: CGRect(x:0, y:350, width: 200, height: 50))
        gameLabel.text = "GameID: " + gameID
        gameLabel.center.x = self.view.center.x
        gameLabel.textAlignment = .center
        view.addSubview(gameLabel)
        
        let submit = UIButton(frame: CGRect(x:240, y:400, width:50, height: 25))
        submit.setTitle("Enter", for: .normal)
        submit.setTitleColor(UIColor.black, for: .normal)
        submit.layer.borderWidth = 1
        submit.layer.borderColor = UIColor.black.cgColor
        submit.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        submit.addTarget(self, action: #selector(setGameID), for: .touchUpInside)
        view.addSubview(submit)
        
        let buttonWord = UIButton(frame: CGRect(x: 100, y:475, width: 200, height: 50))
        buttonWord.center = CGPoint(x: self.view.frame.midX, y: 475)
        buttonWord.setTitle("Set Word", for: .normal)
        buttonWord.setTitleColor(UIColor.black, for: .normal)
        buttonWord.addTarget(self, action: #selector(showWordViewControllerPush), for: .touchUpInside)
        buttonWord.layer.cornerRadius = 5
        buttonWord.layer.borderWidth = 1
        buttonWord.layer.borderColor = UIColor.black.cgColor
        view.addSubview(buttonWord)
        
        let buttonPlayer = UIButton(frame: CGRect(x: view.frame.midX, y: 550, width: 200, height: 50))
        buttonPlayer.center = CGPoint(x: self.view.frame.midX, y: 550)
        buttonPlayer.setTitle("Play Hangman", for: .normal)
        buttonPlayer.setTitleColor(UIColor.black, for: .normal)
        buttonPlayer.addTarget(self, action: #selector(showPlayerViewControllerPush), for: .touchUpInside)
        buttonPlayer.layer.cornerRadius = 5
        buttonPlayer.layer.borderWidth = 1
        buttonPlayer.layer.borderColor = UIColor.black.cgColor
        view.addSubview(buttonPlayer)
    }
    
    func setGameID() {
        gameID = textField.text!
        gameLabel.text = "GameID: " + gameID
    }
    
    func showWordViewControllerPush() {
        navigationController?.pushViewController(WordViewController(), animated: true)
    }
    
    func showPlayerViewControllerPush() {
        if submittedWord != "" && gameID != ""{
            navigationController?.pushViewController(PlayerViewController(), animated: true)
        }
    }
    
}
