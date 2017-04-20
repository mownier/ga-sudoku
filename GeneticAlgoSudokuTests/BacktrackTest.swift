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
        
        let expectedRow0 = [4,6,7, 1,5,9, 8,3,2]
        let row0: [Int] = board.rows[0].map({ return $0.data })
        XCTAssertEqual(row0, expectedRow0)
    
        let expectedRow1 = [2,5,6, 4,8,3, 1,7,9]
        let row1: [Int] = board.rows[1].map({ return $0.data })
        XCTAssertEqual(row1, expectedRow1)
        
        let expectedRow2 = [9,7,1, 2,6,8, 3,5,4]
        let row2: [Int] = board.rows[2].map({ return $0.data })
        XCTAssertEqual(row2, expectedRow2)
        
        let expectedRow3 = [1,9,5, 7,3,2, 6,4,8]
        let row3: [Int] = board.rows[3].map({ return $0.data })
        XCTAssertEqual(row3, expectedRow3)
        
        let expectedRow4 = [1,2,8, 5,9,6, 7,4,3]
        let row4: [Int] = board.rows[4].map({ return $0.data })
        XCTAssertEqual(row4, expectedRow4)
        
        let expectedRow5 = [3,6,4, 8,1,7, 5,2,9]
        let row5: [Int] = board.rows[5].map({ return $0.data })
        XCTAssertEqual(row5, expectedRow5)
        
        let expectedRow6 = [6,5,2, 9,8,1, 4,3,7]
        let row6: [Int] = board.rows[6].map({ return $0.data })
        XCTAssertEqual(row6, expectedRow6)
        
        let expectedRow7 = [6,5,9, 3,7,4, 2,8,1]
        let row7: [Int] = board.rows[7].map({ return $0.data })
        XCTAssertEqual(row7, expectedRow7)
        
        let expectedRow8 = [1,4,5, 3,2,8, 7,6,9]
        let row8: [Int] = board.rows[8].map({ return $0.data })
        XCTAssertEqual(row8, expectedRow8)
        
        let expectedBoard = [
            4,6,7, 1,5,9, 8,3,2,
            2,5,6, 4,8,3, 1,7,9,
            9,7,1, 2,6,8, 3,5,4,
            
            1,9,5, 7,3,2, 6,4,8,
            1,2,8, 5,9,6, 7,4,3,
            3,6,4, 8,1,7, 5,2,9,
            
            6,5,2, 9,8,1, 4,3,7,
            6,5,9, 3,7,4, 2,8,1,
            1,4,5, 3,2,8, 7,6,9
        ]
        let chromosomes: [Chromosome] = board.rows.flatMap({ $0 })
        XCTAssertEqual(expectedBoard, chromosomes.map({ $0.data }))
    }
}
