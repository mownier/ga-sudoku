//
//  Backtrack.swift
//  GeneticAlgoSudoku
//
//  Created by Mounir Ybanez on 18/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Foundation

public struct Backtrack: BacktrackProtocol {
    
    private(set) public var currentBestScore: Int = 0
    private(set) public var bestScoreCount: Int = 0
    private(set) public var fitness: FitnessProtocol
    
    public var maxBestScoreCount: Int = 15
    
    public init(fitness: FitnessProtocol) {
        self.fitness = fitness
    }
    
    public mutating func isEnabled(_ bestScore: Int) -> Bool {
        if bestScoreCount > maxBestScoreCount {
            currentBestScore = 0
        }
        
        if bestScore == currentBestScore {
            bestScoreCount += 1
        
        } else {
            currentBestScore = bestScore
            bestScoreCount = 1
        }
        
        return bestScoreCount > maxBestScoreCount
    }
    
    public func reinitialize(from organisms: [Organism]) -> [Organism] {
        guard organisms.count > 0 else { return [Organism]() }
        
        let index = Int(arc4random()) % organisms.count
        let board = Board(chromosomes: organisms[index].chromosomes)
        let chromosomes = newChromosomes(board.rows)
        var organism = Organism(score: 0, chromosomes: chromosomes)
        var topOrganism = organisms.sorted(by: { $0.score > $1.score })[0]
        
        organism.score = fitness.computeScore(for: organism)
        topOrganism.score = fitness.computeScore(for: topOrganism)
        
        var newOrganisms: [Organism]
        
        if topOrganism.score > organism.score {
            newOrganisms = [topOrganism]
            
        } else {
            newOrganisms = [organism]
        }
        
        if organisms.count > 1 {
            for _ in 0..<organisms.count - 1 {
                var newOrganism = Organism()
                newOrganism.chromosomes = organism.chromosomes.map({
                    guard !$0.isGiven else { return $0 }
                    
                    var chromosome = $0
                    chromosome.data = (Int(arc4random()) % 9) + 1
                    return chromosome
                })
                newOrganisms.append(newOrganism)
            }
            
        }
        
        return newOrganisms
    }
    
    private func newChromosomes(_ array: [[Chromosome]]) -> [Chromosome] {
        let newChromosomes: [[Chromosome]] = array.map({
            let marks = [1, 2, 3, 4, 5, 6, 7, 8, 9]
            let data: [Int] = $0.map({ $0.data })
            var unique = [Int]()
            var repeated = [Int]()
            
            for i in 0..<marks.count {
                guard data.contains(marks[i]) else { continue }
                
                if $0.filter({ $0.data == marks[i] }).count == 1 {
                    unique.append(marks[i])
                } else {
                    repeated.append(marks[i])
                }
            }
            
            var unused = Array(Set(marks).subtracting(Set(unique).union(Set(repeated)))).sorted(by: { $0 < $1 })
            
            if repeated.count == 0 {
                return $0
                
            } else {
                var newData = [Int]()
                for i in 0..<9 {
                    let data = $0[i].data
                    if $0[i].isGiven || unique.contains(data) || (repeated.contains(data) && !newData.contains(data)) {
                        newData.append(data)
                        
                    } else {
                        if unused.count > 0 {
                            newData.append(unused.removeFirst())
                        }
                    }
                }
                
                var newArrayData = $0
                
                for i in 0..<$0.count {
                    newArrayData[i].data = newData[i]
                }
                
                return newArrayData
            }
        })
        
        return newChromosomes.flatMap({ $0 })
    }
}
