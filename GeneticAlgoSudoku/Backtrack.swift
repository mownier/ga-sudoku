//
//  Backtrack.swift
//  GeneticAlgoSudoku
//
//  Created by Mounir Ybanez on 18/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Foundation

public struct Backtrack: BacktrackProtocol {
    
    private enum BoardPart {
        
        case rows, columns, boxes
    }
    
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
        var board = Board(chromosomes: organisms[index].chromosomes)
        var newOrganism = createOrganism(board.rows, relativeTo: .rows)
        var topOrganism = organisms.sorted(by: { $0.score > $1.score })[0]
        
        newOrganism.score = fitness.computeScore(for: newOrganism)
        topOrganism.score = fitness.computeScore(for: topOrganism)
        
        var newOrganisms = [Organism]()
        
        if newOrganism.score >= topOrganism.score {
            newOrganisms.append(newOrganism)
        
        } else {
            newOrganism = createOrganism(board.columns, relativeTo: .columns)
            newOrganism.score = fitness.computeScore(for: newOrganism)
            
            if newOrganism.score >= topOrganism.score {
                newOrganisms.append(newOrganism)
            
            } else {
                newOrganism = createOrganism(board.boxes, relativeTo: .boxes)
                newOrganism.score = fitness.computeScore(for: newOrganism)
                
                if newOrganism.score >= topOrganism.score {
                    newOrganisms.append(newOrganism)
                }
            }
        }
        
        if newOrganisms.count == 0 {
            board = Board(chromosomes: organisms[organisms.count - 1].chromosomes)
            newOrganism = createOrganism(board.rows, relativeTo: .rows)
            
            board = Board(chromosomes: newOrganism.chromosomes)
            newOrganism = createOrganism(board.columns, relativeTo: .columns)
            
            board = Board(chromosomes: newOrganism.chromosomes)
            newOrganism = createOrganism(board.boxes, relativeTo: .boxes)
            
            newOrganism.score = fitness.computeScore(for: newOrganism)
            newOrganisms.append(newOrganism)
        }
        
        if organisms.count > 1 {
            for _ in 0..<organisms.count - 1 {
                let chromosomes = topOrganism.chromosomes.map({ element -> Chromosome in
                    guard !element.isGiven else { return element }
                    
                    var chromosome = Chromosome()
                    chromosome.data = (Int(arc4random()) % 9) + 1
                    return chromosome
                })
                
                switch arc4random() % 2 {
                case 1:
                    board = Board(chromosomes: chromosomes)
                    newOrganism = createOrganism(board.rows, relativeTo: .rows)
                    
                    board = Board(chromosomes: newOrganism.chromosomes)
                    newOrganism = createOrganism(board.columns, relativeTo: .columns)
                    
                    board = Board(chromosomes: newOrganism.chromosomes)
                    newOrganism = createOrganism(board.boxes, relativeTo: .boxes)
                    
                    newOrganisms.append(newOrganism)
                
                default:
                    newOrganisms.append(Organism(score: 0, chromosomes: chromosomes))
                }
                
            }
        }
        
        return newOrganisms
    }
    
    private func createOrganism(_ array: [[Chromosome]], relativeTo part: BoardPart) -> Organism {
        var newChromosomes: [[Chromosome]] = array.map({
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
            
            var unused = Array(Set(marks).subtracting(Set(unique).union(Set(repeated)))).sorted(by: { $0 <= $1 })
            
            if repeated.count == 0 {
                return $0
                
            } else {
                var newData = [Int]()
                for i in 0..<9 {
                    let data = $0[i].data
                    if repeated.contains(data) && unused.count > 0 && !$0[i].isGiven {
                        newData.append(unused.removeFirst())
                    
                    } else {
                        newData.append(data)
                    }
                }
                
                var newArrayData = $0
                
                for i in 0..<$0.count {
                    newArrayData[i].data = newData[i]
                }
                
                return newArrayData
            }
        })
        
        let board = Board(chromosomes: newChromosomes.flatMap({ $0 }))
        
        switch part {
        case .columns: newChromosomes = board.columns
        case .boxes: newChromosomes = board.boxes
        case .rows: break
        }
        
        return Organism(score: 0, chromosomes: newChromosomes.flatMap({ $0 }))
    }
}
