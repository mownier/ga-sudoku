//
//  Sudoku.swift
//  GeneticAlgoSudoku
//
//  Created by Mounir Ybanez on 17/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

public struct Sudoku {
    
    public var puzzle: Puzzle
    
    public init(puzzle: Puzzle = .one) {
        self.puzzle = puzzle
    }
    
    public var chromosomes: [Chromosome] {
        var chromosomes = [Chromosome]()
        for value in puzzle.data {
            var chromosome = Chromosome()
            if value > 0 && value < 10 {
                chromosome.data = value
                chromosome.isGiven = true
            }
            chromosomes.append(chromosome)
        }
        return chromosomes
    }
}

public enum Puzzle {
    
    case one, two, three, four
    
    public var data: [Int] {
        switch self {
        case .one:
            return [
                0,0,0, 0,0,0, 9,8,0,
                0,7,0, 0,0,0, 6,0,0,
                4,0,0, 0,7,0, 0,0,0,
                
                0,0,1, 5,0,0, 0,6,0,
                0,0,0, 0,0,8, 0,9,0,
                9,0,0, 3,0,7, 0,0,0,
                
                0,0,6, 8,0,0, 0,4,0,
                0,0,0, 0,6,0, 0,1,8,
                0,5,0, 0,0,1, 2,0,0
            ]
            
        case .two:
            return [
                5,3,0, 0,7,0, 0,0,0,
                6,0,0, 1,9,5, 0,0,0,
                0,9,8, 0,0,0, 0,6,0,
                
                8,0,0, 0,6,0, 0,0,3,
                4,0,0, 8,0,3, 0,0,1,
                7,0,0, 0,2,0, 0,0,6,
                
                0,6,0, 0,0,0, 2,8,0,
                0,0,0, 4,1,9, 0,0,5,
                0,0,0, 0,8,0, 0,7,9
            ]
            
        case .three:
            return [
                0,0,0, 0,5,0, 0,0,0,
                0,0,6, 4,0,3, 1,0,0,
                0,7,1, 2,6,8, 3,5,0,
                
                0,9,5, 0,3,0, 6,4,0,
                1,0,8, 5,0,6, 7,0,3,
                0,6,4, 0,1,0, 5,2,0,
                
                0,5,2, 9,8,1, 4,3,0,
                0,0,9, 3,0,4, 2,0,0,
                0,0,0, 0,2,0, 0,0,0
            ]
            
        case .four:
            return [
                0,0,5, 1,3,4, 9,8,7,
                0,7,9, 2,8,5, 6,3,4,
                4,8,3, 9,7,6, 1,2,5,
                
                8,4,1, 5,2,9, 7,6,3,
                5,3,7, 6,1,8, 4,9,2,
                9,6,2, 3,4,7, 8,5,1,
                
                7,1,6, 8,5,2, 3,4,9,
                2,9,4, 7,6,3, 5,1,8,
                3,5,8, 4,9,1, 2,7,6
            ]
        }
    }
}
