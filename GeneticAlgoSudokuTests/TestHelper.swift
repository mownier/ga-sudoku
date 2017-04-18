//
//  TestHelper.swift
//  GeneticAlgoSudoku
//
//  Created by Mounir Ybanez on 08/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Foundation

class TestHelper {

    static var randomOrganism: Organism {
        var organism = Organism()
        organism.chromosomes = organism.chromosomes.map({
            var chromosome = $0
            chromosome.data = Int(arc4random()) % 9 + 1
            return chromosome
        })
        return organism
    }
    
    static var bestFitOrganism: Organism {
        let data = [
            6,2,5, 1,3,4, 9,8,7,
            1,7,9, 2,8,5, 6,3,4,
            4,8,3, 9,7,6, 1,2,5,
            
            8,4,1, 5,2,9, 7,6,3,
            5,3,7, 6,1,8, 4,9,2,
            9,6,2, 3,4,7, 8,5,1,
            
            7,1,6, 8,5,2, 3,4,9,
            2,9,4, 7,6,3, 5,1,8,
            3,5,8, 4,9,1, 2,7,6
        ]
        return Organism(score: 0, chromosomes: data.map { Chromosome(data: $0, isGiven: true) })
    }
    
    static var unfitOrganism: (Organism, [Int]) {
        let data = [
            4,3,2, 1,5,5, 8,3,2,
            2,7,6, 4,7,3, 1,7,9,
            9,7,1, 2,6,8, 3,5,3,
            
            3,9,5, 7,3,9, 6,4,8,
            1,5,8, 5,9,6, 7,1,3,
            5,6,4, 8,1,2, 5,2,6,
            
            1,5,2, 9,8,1, 4,3,7,
            1,5,9, 3,4,4, 2,2,1,
            9,8,5, 3,2,8, 7,6,9
        ]
        
        let indices = [
            4, 11, 12, 14, 15,
            19, 20, 21, 22, 23,
            24, 25, 28, 29, 31,
            33, 34, 36, 38, 39,
            41, 42, 44, 46, 47,
            49, 51, 52, 55, 56,
            57, 58, 59, 60, 61,
            65, 66, 68, 69, 76
        ]
        
        let chromosomes: [Chromosome] = data.enumerated().map { (element : (index: Int, data: Int)) -> Chromosome in
            return Chromosome(data: element.data, isGiven: indices.contains(element.index))
        }
        
        let organism = Organism(score: 0, chromosomes: chromosomes)
        
        return (organism, indices)
    }
}
