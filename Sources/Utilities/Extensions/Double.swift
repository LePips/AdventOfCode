//
//  File.swift
//  AdventOfCode
//
//  Created by Ethan Pippin on 12/13/24.
//

import Foundation

public extension Double {
    
    func isWholeNumber(epsilon: Double = 0.0000000001) -> Bool {
        truncatingRemainder(dividingBy: 1) < epsilon
//        floor(self) == self
    }
}
