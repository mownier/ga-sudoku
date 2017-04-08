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
        var organism = TestHelper.randomOrganism
        organism.chromosomes[1] = organism.chromosomes[0]
        organism.chromosomes[2] = organism.chromosomes[0]
        organism.chromosomes[3] = organism.chromosomes[0]
        let elitism = Elitism()
        let score = elitism.computeScore(for: organism)
        XCTAssertNotEqual(score, elitism.bestScore)
    }
    
    func testComputScoreWithBestFitOrganism() {
        let organism = TestHelper.bestFitOrganism
        let elitism = Elitism()
        let score = elitism.computeScore(for: organism)
        XCTAssertEqual(score, elitism.bestScore)
    }
}
