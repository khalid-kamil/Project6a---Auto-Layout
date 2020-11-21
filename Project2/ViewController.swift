//
//  ViewController.swift
//  Project2
//
//  Created by Khalid Kamil on 11/10/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        // Set border width for buttons
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        // Set border color for buttons
        //button1.layer.borderColor = UIColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0).cgColor
        button1.layer.borderColor=UIColor.lightGray.cgColor
        button2.layer.borderColor=UIColor.lightGray.cgColor
        button3.layer.borderColor=UIColor.lightGray.cgColor
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil){
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        title = countries[correctAnswer].uppercased()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Check Score", style: .plain, target: self, action: #selector(scoreTapped))
        // Keep track of numnber of questions asked
        questionCount += 1
        
    }
    
    @objc func scoreTapped() {
        let ac = UIAlertController(title: "Score:", message: "Your current score is \(score)!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Resume", style: .default))
            present(ac, animated: true)
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        // Check whether the answer was correct
        // Adjust the player's score up or down
        // Show a message telling them what their new score is
        var title: String
        var message: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            message = "Your score is \(score)."
        } else {
            title = "Wrong"
            score -= 1
            message = "That's the flag of \(countries[sender.tag].uppercased()).\nYour score is \(score)."
        }
        // Show an alert with the final score after 10 questions have been answered
        if questionCount == 10 {
            let ac = UIAlertController(title: "Congratulations!", message: "Your final score is \(score)!", preferredStyle: .alert)
            questionCount = 0
            score = 0
            ac.addAction(UIAlertAction(title: "Play Again", style: .default, handler: askQuestion))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }
        
        
    }
}

