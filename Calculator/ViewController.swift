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

	@IBAction func touchDigit(sender: UIButton) {
		print("touchDigit on button: \(sender.currentTitle!)")
	}

}

