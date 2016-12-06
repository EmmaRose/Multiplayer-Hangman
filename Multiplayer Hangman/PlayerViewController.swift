//
//  PlayerViewController.swift
//  Multiplayer Hangman
//
//  Created by Emma Rose Wirshing on 11/27/16.
//  Copyright © 2016 Emma Rose Wirshing. All rights reserved.
//

import UIKit
import PubNub

class PlayerViewController: UIViewController, PNObjectEventListener {
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var submittedLetter = ""
    var livesNum = ""
    var enterLetter = UITextField()
    var guesses = UILabel()
    var lives = UILabel()
    var dashes = UILabel()
    var sendLetter = UIButton()
    var winning = UILabel()
    var losing = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Play Hangman"
        view.backgroundColor = .white
        
        appDelegate.client.addListener(self)
        appDelegate.client.subscribeToChannels([gameID], withPresence: false)
        appDelegate.client.publish(["word":submittedWord, "channel": gameID, "letter": "1", "lives":"5"], toChannel: "hangman-game-after-publish",
                                    compressed: false, withCompletion:{(status)->Void in
                                        if !status.isError {
                                        }
                                        else{
                                            print("Publishing Error (initial publish)")
                                        }
        })
        
        enterLetter = UITextField(frame: CGRect(x:85, y: 300, width: 150, height: 25))
        enterLetter.placeholder = " Enter Letter"
        enterLetter.layer.borderWidth = 1
        enterLetter.layer.borderColor = UIColor.black.cgColor
        view.addSubview(enterLetter)
        
        sendLetter = UIButton(frame: CGRect(x:240, y:300, width:50, height: 25))
        sendLetter.setTitle("Enter", for: .normal)
        sendLetter.setTitleColor(UIColor.black, for: .normal)
        sendLetter.layer.borderWidth = 1
        sendLetter.layer.borderColor = UIColor.black.cgColor
        sendLetter.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        sendLetter.addTarget(self, action: #selector(publishLetter), for: .touchUpInside)
        view.addSubview(sendLetter)
        
        guesses = UILabel(frame: CGRect(x:0, y:200, width: 200, height: 50))
        guesses.center.x = self.view.center.x
        guesses.textAlignment = .center
        guesses.numberOfLines = 4
        view.addSubview(guesses)
        
        lives = UILabel(frame: CGRect(x:0, y:450, width: 200, height: 50))
        lives.center.x = self.view.center.x
        lives.textAlignment = .center
        view.addSubview(lives)
        
        dashes = UILabel(frame: CGRect(x:0, y:150, width: 200, height: 50))
        dashes.center.x = self.view.center.x
        dashes.textAlignment = .center
        view.addSubview(dashes)
        
        winning = UILabel(frame: CGRect(x:85, y: 300, width: 150, height: 25))
        winning.text = "YOU WON!"
        winning.center.x = self.view.center.x
        winning.textAlignment = .center
        
        losing = UILabel(frame: CGRect(x:85, y: 300, width: 150, height: 25))
        losing.text = "YOU LOST...."
        losing.center.x = self.view.center.x
        losing.textAlignment = .center
    }
    
    func client(_ client: PubNub, didReceiveMessage message: PNMessageResult) {
        
        if let data = message.data.message as? [String: String] {
            guesses.text = "Guesses: " +  data["guesses"]!
            lives.text = "Lives: " + data["lives"]!
            dashes.text = data["word"]
            livesNum = data["lives"]!
            
            if data["won"] == "true" {
                lives.isHidden = true
                guesses.isHidden = true
                sendLetter.isHidden = true
                enterLetter.isHidden = true
                dashes.isHidden = true
                view.addSubview(winning)
            }
            
            if data["lost"] == "true" {
                lives.isHidden = true
                guesses.isHidden = true
                sendLetter.isHidden = true
                enterLetter.isHidden = true
                dashes.isHidden = true
                view.addSubview(losing)
            }
        }
    }
    
    func publishLetter() {
        submittedLetter = enterLetter.text!
        enterLetter.text = ""
        appDelegate.client.publish(["word":submittedWord, "channel": gameID, "letter": submittedLetter, "lives": livesNum], toChannel: "hangman-game-after-publish",
                                   compressed: false, withCompletion:{(status)->Void in
                                    if !status.isError {
                                    }
                                    else{
                                        print("Publishing Error (initial publish)")
                                    }
        })
    }
}

