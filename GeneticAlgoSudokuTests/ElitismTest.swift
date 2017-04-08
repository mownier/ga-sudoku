//
//  ElitismTest.swift
//  GeneticAlgoSudoku
//
//  Created by Mounir Ybanez on 08/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import XCTest

class ElitismTest: XCTestCase {

    func testComputScoreWithUnfitRandomOrganism() {
        var organism = randomOrganism
        organism.chromosomes[1] = organism.chromosomes[0]
        let elitism = Elitism()
        let score = elitism.computeScore(for: organism)
        XCTAssertNotEqual(score, elitism.bestScore)
    }
    
    func testComputScoreWithBestFitOrganism() {
        let organism = bestFitOrganism
        let elitism = Elitism()
        let score = elitism.computeScore(for: organism)
        XCTAssertEqual(score, elitism.bestScore)
    }
    
    var randomOrganism: Organism {
        var organism = Organism()
        organism.chromosomes = organism.chromosomes.map({
            var chromosome = $0
            chromosome.data = Int(arc4random()) % 9 + 1
            return chromosome
        })
        return organism
    }
    
    var bestFitOrganism: Organism {
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
}
