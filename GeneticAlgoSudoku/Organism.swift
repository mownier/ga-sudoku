//
//  Organism.swift
//  GeneticAlgoSudoku
//
//  Created by Mounir Ybanez on 06/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

public struct Organism: Equatable {
    
    public var score: UInt8
    public var chromosomes: [Chromosome]
    
    public init(score: UInt8, chromosomes: [Chromosome]) {
        self.chromosomes = chromosomes
        self.score = score
    }
    
    public init() {
        self.init(score: 0, chromosomes: [Chromosome]())
    }
}

public func ==(lhs: Organism, rhs: Organism) -> Bool {
    return lhs.score == rhs.score && lhs.chromosomes == rhs.chromosomes
}

