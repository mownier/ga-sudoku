//
//  Board.swift
//  GeneticAlgoSudoku
//
//  Created by Mounir Ybanez on 11/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

public struct Board {
    
    private var chromosomes: [Chromosome]
    
    public init(chromosomes: [Chromosome]) {
        self.chromosomes = chromosomes
    }
    
    public var rows: [[Chromosome]] {
        var rows = [[Chromosome]]()
        
        for _ in 0..<9 {
            rows.append([Chromosome]())
        }
        
        for i in 0..<81 {
            let index = row(for: i)
            rows[index].append(chromosomes[i])
        }
        
        return rows
    }
    
    public var columns: [[Chromosome]] {
        var columns = [[Chromosome]]()
        
        for _ in 0..<9 {
            columns.append([Chromosome]())
        }
        
        for i in 0..<81 {
            let index = column(for: i)
            columns[index].append(chromosomes[i])
        }
        
        return columns
    }
    
    public var boxes: [[Chromosome]] {
        var boxes = [[Chromosome]]()
        
        for _ in 0..<9 {
            boxes.append([Chromosome]())
        }
        
        for i in 0..<81 {
            let index = box(for: i)
            boxes[index].append(chromosomes[i])
        }
        
        return boxes
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
