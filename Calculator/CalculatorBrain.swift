//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Jude Molloy on 15/07/2017.
//  Copyright © 2017 Jude Molloy. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    private var accumulator: Double?
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String, Operation> = [
        "π": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "√": Operation.unaryOperation(sqrt),
        "cos": Operation.unaryOperation(cos),
        "sin": Operation.unaryOperation(sin),
        "tan": Operation.unaryOperation(tan),
        "x²": Operation.unaryOperation({$0 * $0}),
        "x³": Operation.unaryOperation({$0 * $0 * $0}),
        "×": Operation.binaryOperation({$0 * $1}),
        "-": Operation.binaryOperation({$0 - $1}),
        "+": Operation.binaryOperation({$0 + $1}),
        "÷": Operation.binaryOperation({$0 / $1}),
        "=": Operation.equals
    ]
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let f):
                if accumulator != nil {
                    accumulator = f(accumulator!)
                }
            case .binaryOperation(let f):
                if accumulator != nil {
                    pbo = PendingBinaryOperation(function: f, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            }
        }
    }
    
    private mutating func performPendingBinaryOperation() {
        if pbo != nil && accumulator != nil {
            accumulator = pbo!.perform(with: accumulator!)
            pbo = nil
        }
    }
    
    private var pbo: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
} 
