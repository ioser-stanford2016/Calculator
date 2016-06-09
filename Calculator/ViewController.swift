//
//  ViewController.swift
//  Calculator
//
//  Created by Richard E Millet on 4/24/16.
//  Copyright © 2016 remillet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	//
	// First demo code
	//
	private var userEditingDisplay = false
	private var brain = CalculatorBrain()
	
	//
	// Computed variable example
	//
	private var displayValue: Double {
		get {
			return Double(display.text!)!
		}
		
		set {
			display.text = String(newValue)
		}
	}

	@IBOutlet private weak var display: UILabel!
	
	@IBAction func clear(sender: UIButton) {
		brain.clear()
		userEditingDisplay = false
		displayValue = brain.result
	}

	@IBAction func touchDot(sender: UIButton) {
		if userEditingDisplay {
			if display.text!.rangeOfString(".") != nil {
				return // We found an existing dot, so do nothing an exit
			}
		} else {
			display.text = "0"
			userEditingDisplay = true
		}
		touchDigit(sender)
	}
	
	@IBAction private func touchDigit(sender: UIButton) {
		let digit = sender.currentTitle!
		if userEditingDisplay {
			let currentTextInDisplay = display.text!
			display.text = currentTextInDisplay + digit
		} else {
			display.text = digit
			userEditingDisplay = true
		}
		
		print("touchDigit on button: \(digit)")
	}

	@IBAction private func pi(sender: UIButton) {
		if (userEditingDisplay == true) {
			brain.setOperand(displayValue)
			userEditingDisplay = false
		}
		
		if let op = sender.currentTitle {
			brain.peformOperation(op)
		}
		
		displayValue = brain.result
	}
}

