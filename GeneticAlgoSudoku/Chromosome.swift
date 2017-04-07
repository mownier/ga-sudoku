//
//  Chromosome.swift
//  GeneticAlgoSudoku
//
//  Created by Mounir Ybanez on 06/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

public struct Chromosome: Equatable {
    
    public var data: Int
    public var isGiven: Bool
    
    public init() {
        isGiven = false
        data = 0
    }
}

public func ==(lhs: Chromosome, rhs: Chromosome) -> Bool {
    return lhs.data == rhs.data
}
