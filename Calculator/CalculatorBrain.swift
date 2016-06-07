//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Richard E Millet on 6/4/16.
//  Copyright © 2016 remillet. All rights reserved.
//

import Foundation

func multiply(op1: Double, op2: Double) -> Double {
	return op1 * op2
}

func add(op1: Double, op2: Double) -> Double {
	return op1 + op2
}

func subtract(op1: Double, op2: Double) -> Double {
	return op1 - op2
}

func divide(op1: Double, op2: Double) -> Double {
	return op1 / op2
}

class CalculatorBrain
{
	private var accumulator: Double = 0.0
	
	func setOperand(operand: Double) {
		accumulator = operand
	}
	
	private var operations: Dictionary<String, Operation> = [
		"π" : Operation.Constant(M_PI),
		"e" : Operation.Constant(M_E),
		"√" : Operation.UnaryOperation(sqrt),
		"cos" : Operation.UnaryOperation(cos),
		"×" : Operation.BinaryOperation(multiply),
		"+" : Operation.BinaryOperation(add),
		"-" : Operation.BinaryOperation(subtract),
		"÷" : Operation.BinaryOperation(divide),
		"=" : Operation.Equals
	]
	
	enum Operation {
		case Constant(Double)
		case UnaryOperation((Double) -> Double)
		case BinaryOperation((Double, Double) -> Double)
		case Equals
	}
	
	func peformOperation(symbol: String) {
		if let operation = operations[symbol] {
			switch operation {
			case Operation.Constant(let value):
				accumulator = value
			case Operation.UnaryOperation(let unaryFunc):
				accumulator = unaryFunc(accumulator)
			case Operation.BinaryOperation(let binaryFunc):
				pending = PendingBinaryOperationInfo(binaryFunction: binaryFunc, op1: accumulator)
			case Operation.Equals:
				if pending != nil {
					accumulator = pending!.binaryFunction(pending!.op1, accumulator)
				}
			}
		}
	}
	
	private var pending: PendingBinaryOperationInfo?
	
	// struct instances are passed-by-value
	struct PendingBinaryOperationInfo {
		var binaryFunction: (Double, Double) -> Double
		var op1: Double
	}
	
	var result: Double {
		get {
			return accumulator
		}
	}
}