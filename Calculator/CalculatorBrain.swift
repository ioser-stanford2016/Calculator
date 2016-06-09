//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Richard E Millet on 6/4/16.
//  Copyright © 2016 remillet. All rights reserved.
//

import Foundation

class CalculatorBrain
{
	private var accumulator: Double = 0.0
	private var pending: PendingBinaryOperationInfo?
	
	func setOperand(operand: Double) {
		accumulator = operand
	}
	
	private var operations: Dictionary<String, Operation> = [
		"π" : Operation.Constant(M_PI),
		"e" : Operation.Constant(M_E),
		"±" : Operation.UnaryOperation({ -$0 }),
		"√" : Operation.UnaryOperation(sqrt),
		"cos" : Operation.UnaryOperation(cos),
		"×" : Operation.BinaryOperation({ $0 * $1 }),
		"+" : Operation.BinaryOperation({ $0 + $1 }),
		"-" : Operation.BinaryOperation({ $0 - $1 }),
		"÷" : Operation.BinaryOperation({ $0 / $1 }),
		"=" : Operation.Equals
	]
	
	private enum Operation {
		case Constant(Double)
		case UnaryOperation((Double) -> Double)
		case BinaryOperation((Double, Double) -> Double)
		case Equals
	}
	
	func clear() {
		pending = nil
		accumulator = 0
	}
	
	func peformOperation(symbol: String) {
		if let operation = operations[symbol] {
			switch operation {
			case Operation.Constant(let value):
				accumulator = value
			case Operation.UnaryOperation(let unaryFunc):
				accumulator = unaryFunc(accumulator)
			case Operation.BinaryOperation(let binaryFunc):
				executePendingBinaryOperation()
				pending = PendingBinaryOperationInfo(binaryFunction: binaryFunc, op1: accumulator)
			case Operation.Equals:
				executePendingBinaryOperation()
			}
		}
	}
	
	private func executePendingBinaryOperation() {
		if pending != nil {
			accumulator = pending!.binaryFunction(pending!.op1, accumulator)
			pending = nil
		}
	}
	
	// struct instances are passed-by-value
	private struct PendingBinaryOperationInfo {
		var binaryFunction: (Double, Double) -> Double
		var op1: Double
	}
	
	var result: Double {
		get {
			return accumulator
		}
	}
}