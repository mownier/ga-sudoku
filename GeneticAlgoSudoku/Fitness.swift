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
        let overallProduct: Int = 3265920
        let overallSum: Int = 405
        let overallNonDuplicate: Int = 81
        
        var product: Int = 0
        var sum: Int = 0
        var multiplier: Int = 1
        var nonDuplicateCount: Int = 0
        var nonDuplicates = [Int]()
        
        for (index, chromosome) in organism.chromosomes.enumerated() {
            multiplier *= chromosome.data
            sum += chromosome.data
            product += multiplier
            
            if index % 9 == 0 {
                multiplier = 1
                nonDuplicates.removeAll()
            }
            
            if !nonDuplicates.contains(chromosome.data) {
                nonDuplicateCount += 1
                nonDuplicates.append(chromosome.data)
            }
        }
        
        let productPercentage = (product / overallProduct) * 100
        let sumPercentage = (sum / overallSum) * 100
        let nonDuplicatePercentage = (nonDuplicateCount / overallNonDuplicate) * 100
        let rowScore = (productPercentage + sumPercentage + nonDuplicatePercentage) / 3
        
        return rowScore
    }
    
    private func computeColumnScores(for organism: Organism) -> Int {
        let overallProduct: Int = 3265920
        let overallSum: Int = 405
        let overallNonDuplicate: Int = 81
        
        var product: Int = 0
        var sum: Int = 0
        var multiplier: Int = 1
        var nonDuplicateCount: Int = 0
        var nonDuplicates = [Int]()
        
        var columnIndex: Int = 0
        var rowIndex: Int = 0
        
        while columnIndex < 9 {
            let chromsomeIndex = rowIndex * 9 + columnIndex
            let chromosome = organism.chromosomes[chromsomeIndex]
            
            multiplier *= chromosome.data
            sum += chromosome.data
            product += multiplier
            
            if !nonDuplicates.contains(chromosome.data) {
                nonDuplicateCount += 1
                nonDuplicates.append(chromosome.data)
            }
            
            if rowIndex < 8 {
                rowIndex += 1
                
            } else {
                multiplier = 1
                columnIndex += 1
                rowIndex = 0
                nonDuplicates.removeAll()
            }
        }
        
        let productPercentage = (product / overallProduct) * 100
        let sumPercentage = (sum / overallSum) * 100
        let nonDuplicatePercentage = (nonDuplicateCount / overallNonDuplicate) * 100
        let columnScore = (productPercentage + sumPercentage + nonDuplicatePercentage) / 3
        
        return columnScore
    }
    
    private func computeBoxScores(for organism: Organism) -> Int {
        let overallProduct: Int = 3265920
        let overallSum: Int = 405
        let overallNonDuplicate: Int = 81
        
        var product: Int = 0
        var sum: Int = 0
        var multiplier: Int = 1
        var nonDuplicateCount: Int = 0
        var nonDuplicates = [Int]()
        
        var columnIndex: Int = 0
        var rowIndex: Int = 0
        var boxIndex: Int = 0
        
        while boxIndex < 9 {
            let chromosomeIndex = rowIndex * 9 + columnIndex
            let chromosome = organism.chromosomes[chromosomeIndex]
            
            multiplier *= chromosome.data
            sum += chromosome.data
            product += multiplier
            
            if !nonDuplicates.contains(chromosome.data) {
                nonDuplicateCount += 1
                nonDuplicates.append(chromosome.data)
            }
            
            if rowIndex < (boxIndex / 3) * 3 + 2 {
                rowIndex += 1
                
            } else {
                columnIndex += 1
                
                if columnIndex % 3 == 0 {
                    boxIndex += 1
                    multiplier = 1
                    nonDuplicates.removeAll()
                }
                
                if columnIndex % 9 == 0 {
                    columnIndex = 0
                }
                
                rowIndex = (boxIndex / 3) * 3
            }
        }
        
        let productPercentage = (product / overallProduct) * 100
        let sumPercentage = (sum / overallSum) * 100
        let nonDuplicatePercentage = (nonDuplicateCount / overallNonDuplicate) * 100
        let boxScore = (productPercentage + sumPercentage + nonDuplicatePercentage) / 3
        
        return boxScore
    }
}
