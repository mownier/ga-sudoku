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
        
        let overallSum: Int = 45 * 9 * 3
        let overallProduct: Int = 362880 * 9 * 3
        let overallNonDuplicate: Int = 81 * 3 * 3
        
        var product: Int = 0
        var sum: Int = 0
        var nonDuplicateCount: Int = 0
        var multiplier: Int = 1
        
        board.rows.flatMap({ $0 }).enumerated().forEach({
            score(board, $0, $1, &product, &sum, &multiplier, &nonDuplicateCount)
        })
        
        board.columns.flatMap({ $0 }).enumerated().forEach({
            score(board, $0, $1, &product, &sum, &multiplier, &nonDuplicateCount)
        })
        
        board.boxes.flatMap({ $0 }).enumerated().forEach({
            score(board, $0, $1, &product, &sum, &multiplier, &nonDuplicateCount)
        })
        
        let sumPercentage = Int((Double(sum) / Double(overallSum)) * 100)
        let productPercentage = Int((Double(product) / Double(overallProduct)) * 100)
        let nonDuplicatePercentage = Int((Double(nonDuplicateCount) / Double(overallNonDuplicate)) * 100)
        var averagePercentage = (sumPercentage + productPercentage + nonDuplicatePercentage) / 3
        averagePercentage = averagePercentage > 100 ? 0 : averagePercentage
        return nonDuplicatePercentage
    }
    
    public func performNaturalSelection(from organisms: [Organism]) -> [Organism] {
        let numberOfSurvivedOrganisms = organisms.count * (survivalRate / 100)
        var sorted = organisms.sorted(by: { $0.score > $1.score })
        sorted.removeSubrange(numberOfSurvivedOrganisms..<organisms.count)
        return sorted
    }
    
    private func score(_ board: Board, _ index: Int, _ chromosome: Chromosome, _ product: inout Int, _ sum: inout Int, _ multiplier: inout Int, _ nonDuplicateCount: inout Int) {
        sum += chromosome.data
        
        multiplier *= chromosome.data
        
        if index != 0 && index % 9 == 0 {
            product += multiplier
            multiplier = 1
        }
        
        let row = board.rows[board.row(for: index)]
        let col = board.columns[board.column(for: index)]
        let box = board.boxes[board.box(for: index)]
        
        let data = chromosome.data
        nonDuplicateCount += row.filter({ $0.data == data }).count > 1 ? 0 : 1
        nonDuplicateCount += col.filter({ $0.data == data }).count > 1 ? 0 : 1
        nonDuplicateCount += box.filter({ $0.data == data }).count > 1 ? 0 : 1
        
        if index == 80 {
            multiplier = 1
        }
    }
}
