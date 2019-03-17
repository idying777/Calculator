//
//  CalculatorBrain.swift
//  calculator
//
//  Created by mac on 2019/3/15.
//  Copyright © 2019 IDying. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    private var accumulator:Double?
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double)->Double)
        case binaryOperation((Double,Double)->Double)
        case equals
        case returnBack
    }
    private var operations:Dictionary<String,Operation>=[
        "π":Operation.constant(Double.pi),
        "e":Operation.constant(M_E),
        "√":Operation.unaryOperation(sqrt),
        "cos":Operation.unaryOperation(cos),
        "±":Operation.unaryOperation({-$0}),
        "+":Operation.binaryOperation({$0+$1}),
        "−":Operation.binaryOperation({$0-$1}),
        "×":Operation.binaryOperation({$0*$1}),
        "÷":Operation.binaryOperation({$0/$1}),
        "=":Operation.equals,
        "AC":Operation.returnBack
    ]
    mutating func performOperation(_ symbol:String)  {
        if let operation = operations[symbol]{
            switch operation{
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil{
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil{
                    pbo = PendingBinaryOperation(function: function,firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingOperation()
            case .returnBack:
                backZero()
            }
        }
       
    }
    private mutating func backZero(){
        accumulator = 0
    }
    private mutating func performPendingOperation(){
        if pbo != nil && accumulator != nil{
            accumulator = pbo!.perform(with: accumulator!)
            pbo = nil
        }
    }
    private var pbo:PendingBinaryOperation?
    private struct PendingBinaryOperation{
        let function:(Double,Double)->Double
        let firstOperand:Double
        func perform(with secondOperand:Double)->Double{
            return function(firstOperand,secondOperand)
        }
    }
    mutating func setOperand(_ operand:Double) {
        accumulator = operand
    }
    var result:Double?{
        get{
            return accumulator
        }
    }
    
}
