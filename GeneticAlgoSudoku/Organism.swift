//
//  Organism.swift
//  GeneticAlgoSudoku
//
//  Created by Mounir Ybanez on 06/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

public struct Organism: Equatable {
    
    public var score: Int
    public var chromosomes: [Chromosome]
    
    public init(score: Int, chromosomes: [Chromosome]) {
        self.chromosomes = chromosomes
        self.score = score
    }
    
    public init() {
        var chromosomes = [Chromosome]()
        for _ in 0..<81 {
            chromosomes.append(Chromosome())
        }
        self.init(score: 0, chromosomes: chromosomes)
    }
}

public func ==(lhs: Organism, rhs: Organism) -> Bool {
    return lhs.score == rhs.score && lhs.chromosomes == rhs.chromosomes
}

