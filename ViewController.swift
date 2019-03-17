//
//  ViewController.swift
//  calculator
//
//  Created by mac on 2019/3/14.
//  Copyright © 2019 IDying. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    
    @IBOutlet weak var display: UILabel!
    var userIsInTheMiddleOfTyping = false

    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping{
            let textCurrentlyIndisplay = display.text!
            display.text = textCurrentlyIndisplay+digit
        }
        else{
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }
    var displayValue:Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    private var brain=CalculatorBrain()
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping{
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathP=sender.currentTitle{
            brain.performOperation(mathP)
        }
        if let result = brain.result{
            displayValue=result
        }
    }
    
}

