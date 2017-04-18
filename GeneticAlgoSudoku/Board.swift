//
//  Board.swift
//  GeneticAlgoSudoku
//
//  Created by Mounir Ybanez on 11/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

public struct Board {
    
    private(set) public var rows: [[Chromosome]]
    private(set) public var columns: [[Chromosome]]
    private(set) public var boxes: [[Chromosome]]
    
    public init(chromosomes: [Chromosome]) {
        rows = [[Chromosome]]()
        columns = [[Chromosome]]()
        boxes = [[Chromosome]]()
        
        for _ in 0..<9 {
            rows.append([Chromosome]())
            columns.append([Chromosome]())
            boxes.append([Chromosome]())
        }
        
        for i in 0..<81 {
            rows[row(for: i)].append(chromosomes[i])
            columns[column(for: i)].append(chromosomes[i])
            boxes[box(for: i)].append(chromosomes[i])
        }
    }
    
    public func row(for index: Int) -> Int {
        return index / 9
    }
    
    public func column(for index: Int) -> Int {
        return index % 9
    }
    
    public func box(for index: Int) -> Int {
        let rowIndex = row(for: index)
        let colIndex = column(for: index)
        
        return ((rowIndex / 3) * 3) + (colIndex / 3)
    }
}
