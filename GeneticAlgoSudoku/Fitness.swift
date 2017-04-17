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
    public var survivalRate: Int
    
    public init(survivalRate: Int = 80) {
        self.survivalRate = survivalRate
    }
    
    public func computeScore(for organism: Organism) -> Int {
        let board = Board(chromosomes: organism.chromosomes)
        let overallNonDuplicate: Int = 81 * 3 * 3
        var nonDuplicateCount: Int = 0
        
        board.rows.flatMap({ $0 }).enumerated().forEach({
            computeNonDuplicateScore(board, $0, $1.data, &nonDuplicateCount)
        })
        
        board.columns.flatMap({ $0 }).enumerated().forEach({
            computeNonDuplicateScore(board, $0, $1.data, &nonDuplicateCount)
        })
        
        board.boxes.flatMap({ $0 }).enumerated().forEach({
            computeNonDuplicateScore(board, $0, $1.data, &nonDuplicateCount)
        })
        
        let score = Int((Double(nonDuplicateCount) / Double(overallNonDuplicate)) * 100)
        return score
    }
    
    public func performNaturalSelection(from organisms: [Organism]) -> [Organism] {
        let numberOfSurvivedOrganisms = Int(Double(organisms.count) * (Double(survivalRate) / 100))
        var sorted = organisms.sorted(by: { $0.score > $1.score })
        sorted.removeSubrange(numberOfSurvivedOrganisms..<organisms.count)
        return sorted
    }
    
    private func computeNonDuplicateScore(_ board: Board, _ index: Int, _ data: Int, _ nonDuplicateCount: inout Int) {
        let row = board.rows[board.row(for: index)]
        let col = board.columns[board.column(for: index)]
        let box = board.boxes[board.box(for: index)]
        
        nonDuplicateCount += row.filter({ $0.data == data }).count > 1 ? 0 : 1
        nonDuplicateCount += col.filter({ $0.data == data }).count > 1 ? 0 : 1
        nonDuplicateCount += box.filter({ $0.data == data }).count > 1 ? 0 : 1
    }
}

extension Elitism: FileOutputProtocol {
    
    public var fileOutputInfo: [String : Any] {
        return [
            "survival_rate": survivalRate,
            "best_score": bestScore
        ]
    }
}
