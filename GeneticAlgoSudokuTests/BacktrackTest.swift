//
//  BacktrackTest.swift
//  GeneticAlgoSudoku
//
//  Created by Mounir Ybanez on 18/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import XCTest

class BacktrackTest: XCTestCase {

    func testIsEnabled() {
        var backtrack = Backtrack(fitness: Elitism())
        backtrack.maxBestScoreCount = 1
        
        XCTAssertFalse(backtrack.isEnabled(1))
        XCTAssertEqual(backtrack.bestScoreCount, 1)
        XCTAssertEqual(backtrack.currentBestScore, 1)
        
        XCTAssertTrue(backtrack.isEnabled(1))
        XCTAssertEqual(backtrack.bestScoreCount, 2)
        XCTAssertEqual(backtrack.currentBestScore, 1)
        
        XCTAssertFalse(backtrack.isEnabled(1))
        XCTAssertEqual(backtrack.bestScoreCount, 1)
        XCTAssertEqual(backtrack.currentBestScore, 1)
    }
    
    func testReinitialize() {
        let backtrack = Backtrack(fitness: Elitism())
        let (organism, indices) = TestHelper.unfitOrganism
        
        var expectedGivenIndices = [Int]()
        for i in 0..<organism.chromosomes.count {
            if organism.chromosomes[i].isGiven {
                expectedGivenIndices.append(i)
            }
        }
        XCTAssertEqual(indices, expectedGivenIndices)
        
        let organisms = backtrack.reinitialize(from: [organism])
        XCTAssertEqual(organisms.count, 1)
        
        let board = Board(chromosomes: organisms[0].chromosomes)
        
        let expectedRow0 = [4,3,2, 1,5,6, 8,7,9]
        let row0: [Int] = board.rows[0].map({ return $0.data })
        XCTAssertEqual(row0, expectedRow0)
    
        let expectedRow2 = [9,7,1, 2,6,8, 3,5,4]
        let row2: [Int] = board.rows[2].map({ return $0.data })
        XCTAssertEqual(row2, expectedRow2)
    }
}
