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
    
    public init(data: Int = 0, isGiven: Bool = false) {
        self.data = data
        self.isGiven = isGiven
    }
}

public func ==(lhs: Chromosome, rhs: Chromosome) -> Bool {
    return lhs.data == rhs.data
}
