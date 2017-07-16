//
//  ViewController.swift
//  Calculator
//
//  Created by Jude Molloy on 15/07/2017.
//  Copyright © 2017 Jude Molloy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsTyping = false
    
    private var brain = CalculatorBrain()
    
    
    @IBAction func cancelButtonTouched(_ sender: UIButton) {
        userIsTyping = false
        displayValue = 0
        brain = CalculatorBrain()
    }
    
    @IBAction func touchNumber(_ sender: UIButton) {
        let number = sender.currentTitle!
        if userIsTyping {
            let numberCurrentlyInDisplay = display.text!
            display.text! = numberCurrentlyInDisplay + number
        } else {
            if number != "0" {
                if number == "." {
                    display.text! = "0" + number
                    userIsTyping = true
                } else {
                    display.text! = number
                    userIsTyping = true
                }
            }
            
        }
        
    }
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            if floor(newValue) == newValue {
                display.text = String(Int(newValue))
            } else {
                display.text = String(newValue)
            }
            
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsTyping {
            brain.setOperand(displayValue)
            userIsTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
            display.text = display.text! + mathematicalSymbol
        }
        if let result = brain.result {
            displayValue = result
        }
    
    }
}







