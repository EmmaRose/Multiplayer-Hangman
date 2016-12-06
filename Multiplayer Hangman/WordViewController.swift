//
//  WordViewController.swift
//  Multiplayer Hangman
//
//  Created by Emma Rose Wirshing on 11/27/16.
//  Copyright © 2016 Emma Rose Wirshing. All rights reserved.
//

import UIKit

class WordViewController: UIViewController {
    
    var wordLabel = UILabel()
    var enterWord = UITextField()
    
    override func viewDidLoad() {
        
        view.backgroundColor = .white
        self.title = "Set Word"
        super.viewDidLoad()
        
        let directions = UILabel(frame: CGRect(x: 0, y: 100, width: 300, height: 150))
        directions.text = "Submit a word (max 20 letters) for the group to guess. Don't tell anyone else the word, or you'll spoil the game!"
        directions.center.x = self.view.center.x
        directions.numberOfLines = 4
        directions.lineBreakMode = NSLineBreakMode.byWordWrapping
        directions.textAlignment = .center
        directions.font = UIFont.boldSystemFont(ofSize: 18)
        view.addSubview(directions)
        
        wordLabel = UILabel(frame: CGRect(x:0, y:250, width: 400, height: 50))
        wordLabel.center.x = self.view.center.x
        wordLabel.text = "Submitted Word: " + submittedWord
        wordLabel.textAlignment = .center
        view.addSubview(wordLabel)
        
        enterWord = UITextField(frame: CGRect(x:85, y: 300, width: 150, height: 25))
        enterWord.placeholder = " Enter Word"
        enterWord.layer.borderWidth = 1
        enterWord.layer.borderColor = UIColor.black.cgColor
        view.addSubview(enterWord)
        
        let setWord = UIButton(frame: CGRect(x:240, y:300, width:50, height: 25))
        setWord.setTitle("Enter", for: .normal)
        setWord.setTitleColor(UIColor.black, for: .normal)
        setWord.layer.borderWidth = 1
        setWord.layer.borderColor = UIColor.black.cgColor
        setWord.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        setWord.addTarget(self, action: #selector(sendWord), for: .touchUpInside)
        view.addSubview(setWord)
    }
    
    func sendWord() {
        submittedWord = enterWord.text!
        wordLabel.text = "Submitted Word: " + submittedWord
    }
    
    
}


