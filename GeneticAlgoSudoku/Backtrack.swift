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
    
    public var maxBestScoreCount: Int = 15
    
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
        
        let board = Board(chromosomes: organisms[0].chromosomes)
        let rows: [[Chromosome]] = board.rows.map({
            let marks = [1, 2, 3, 4, 5, 6, 7, 8, 9]
            let data: [Int] = $0.map({ $0.data })
            var unique = [Int]()
            var repeated = [Int]()
            
            
            for i in 0..<marks.count {
                guard data.contains(i + 1) else { continue }
                
                if $0.filter({ $0.data == marks[i] }).count == 1 {
                    unique.append(i + 1)
                } else {
                    repeated.append(i + 1)
                }
            }
            
            var unused = Array(Set(marks).subtracting(Set(unique).union(Set(repeated)))).sorted(by: { $0 < $1 })
            
            if repeated.count == 0 {
                return $0
            
            } else {
                var newRowData = [Int]()
                for i in 0..<9 {
                    let data = $0[i].data
                    if $0[i].isGiven || unique.contains(data) || (repeated.contains(data) && !newRowData.contains(data)) {
                        newRowData.append(data)
                    
                    } else {
                        newRowData.append(unused.removeFirst())
                    }
                }
                
                var newRow = $0
                
                for i in 0..<$0.count {
                    newRow[i].data = newRowData[i]
                }
                
                return newRow
            }
        })
        
        var newOrganisms = organisms
        newOrganisms[0].chromosomes = rows.flatMap({ $0 })
        
        return newOrganisms
    }
}
