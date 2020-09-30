//
//  ViewController.swift
//  Project 2
//
//  Created by Tomislav Jurić-Arambašić on 08/05/2020.
//  Copyright © 2020 Tomislav Jurić-Arambašić. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showScore))
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        
        
        askQuestion(action: nil)
        // Do any additional setup after loading the view.
    }
    
    func askQuestion(action: UIAlertAction!) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased() + "  score:\(score)"
        
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        var tittle: String
        if sender.tag == correctAnswer {
            tittle = "correct"
            score += 1
        }
        else {
            tittle = "wrong"
            score -= 1
        }
        counter += 1
        
        if tittle == "correct" {
        }
        else {
            tittle = "incorecct! thats the flag of \(countries[sender.tag])"
        }
        
        if counter != 10 {
            
        let ac = UIAlertController(title: tittle, message: "your score is \(score)", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        present(ac, animated: true)
        }
        else
        {
            let end = UIAlertController(title: tittle, message: "your score is \(score)/10", preferredStyle: .alert)
            score = 0
            counter = 0
            
            end.addAction(UIAlertAction(title: "New game", style: .default, handler: askQuestion))
            
            present(end, animated: true)
        }
    }
    
    @objc func showScore(){
        
        let vc = UIActivityViewController(activityItems: ["your score is: \(score)"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(vc,animated: true)
    }
    


}

