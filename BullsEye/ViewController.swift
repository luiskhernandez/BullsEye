//
//  ViewController.swift
//  BullsEye
//
//  Created by Luisk Hernandez on 7/13/18.
//  Copyright © 2018 Luisk Hernandez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currentValue: Int = 50
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    var score = 0
    var round = 0
    
    var targetValue: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func sliderMoved (_ slider: UISlider) {
        print("The value of slider is now: \(slider.value)")
        currentValue = lroundf(slider.value)
    }
    
    func startNewRound() {
        round+=1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    
    func updateLabels () {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    @IBAction func startNewGame () {
        score = 0
        round = 0
        startNewRound()
    }
    
    @IBAction func showAlert() {
        let difference : Int = abs(currentValue - targetValue)
        var points = 100 - difference
        
        let title: String
        if difference == 0 {
            title = "Perfect"
            points += 100
        } else if difference < 5 {
             title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        
        score += points
        let message = "You score \(points)"
        let alert  = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Awesome" , style: .default, handler: {
            action in
              self.startNewRound()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

