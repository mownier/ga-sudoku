//
//  Fitness.swift
//  GeneticAlgoSudoku
//
//  Created by Mounir Ybanez on 07/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Foundation

public struct Elitism: FitnessProtocol {

    public var bestScore: Int = 100 // 100 %
    public var survivalRate: Int = 80 // 80 %
    
    public func computeScore(for organism: Organism) -> Int {
        var score = computeRowScores(for: organism)
        score += computeColumnScores(for: organism)
        score += computeBoxScores(for: organism)
        score /= 3
        return score
    }
    
    public func performNaturalSelection(from organisms: [Organism]) -> [Organism] {
        let numberOfSurvivedOrganisms = organisms.count * (survivalRate / 100)
        return organisms.filter({
            guard let index = organisms.index(of: $0),
                index < numberOfSurvivedOrganisms else {
                return false
            }
            
            return true
        })
    }
    
    private func computeRowScores(for organism: Organism) -> Int {
        return 100
    }
    
    private func computeColumnScores(for organism: Organism) -> Int {
        return 100
    }
    
    private func computeBoxScores(for organism: Organism) -> Int {
        return 100
    }
}
