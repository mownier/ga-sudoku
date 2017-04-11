//
//  BoardTest.swift
//  GeneticAlgoSudoku
//
//  Created by Mounir Ybanez on 10/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import XCTest

class BoardTest: XCTestCase {

    func testGetRows() {
        let organism = TestHelper.bestFitOrganism
        let board = Board(chromosomes: organism.chromosomes)
        
        let row0: [Int] = board.rows[0].map({ return $0.data })
        XCTAssertEqual(row0, [6,2,5, 1,3,4, 9,8,7])
        
        let row1: [Int] = board.rows[1].map({ return $0.data })
        XCTAssertEqual(row1, [1,7,9, 2,8,5, 6,3,4])
    }
    
    func testGetColumns() {
        let organism = TestHelper.bestFitOrganism
        let board = Board(chromosomes: organism.chromosomes)
        
        let col0: [Int] = board.columns[0].map({ return $0.data })
        XCTAssertEqual(col0, [6,1,4, 8,5,9, 7,2,3])
        
        let col1: [Int] = board.columns[1].map({ return $0.data })
        XCTAssertEqual(col1, [2,7,8, 4,3,6, 1,9,5])
    }
    
    func testGetBoxes() {
        let organism = TestHelper.bestFitOrganism
        let board = Board(chromosomes: organism.chromosomes)
        
        let box0: [Int] = board.boxes[0].map({ return $0.data })
        XCTAssertEqual(box0, [6,2,5, 1,7,9, 4,8,3])
        
        let box1: [Int] = board.boxes[1].map({ return $0.data })
        XCTAssertEqual(box1, [1,3,4, 2,8,5, 9,7,6])
    }
    
    func testGetRowIndex() {
        let organism = TestHelper.bestFitOrganism
        let board = Board(chromosomes: organism.chromosomes)
        let index = board.row(for: 19)
        XCTAssertEqual(index, 19 / 9)
    }
    
    func testGetColumnIndex() {
        let organism = TestHelper.bestFitOrganism
        let board = Board(chromosomes: organism.chromosomes)
        let index = board.column(for: 19)
        XCTAssertEqual(index, 19 % 9)
    }
    
    func testGetBoxIndex() {
        let organism = TestHelper.bestFitOrganism
        let board = Board(chromosomes: organism.chromosomes)
        let index = board.box(for: 19)
        XCTAssertEqual(index, 0)
    }
}
