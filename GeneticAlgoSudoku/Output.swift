//
//  Output.swift
//  GeneticAlgoSudoku
//
//  Created by Mounir Ybanez on 10/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

public struct TerminalOutput: GeneticAlgorithmOutputProtocol {

    public func didComplete(_ result: GeneticAlgorithmResult) {
        switch result {
        case .fittestFound(let generation, let organisms):
            print("Solution found")
            print("On generation:", generation)
            organisms.forEach({ print($0) })
            
        case .generationFinished(let organisms):
            print("Solution not found")
            organisms.sorted(by: { $0.score < $1.score }).forEach({
                print("\nScore:", $0.score)
                print($0)
            })
        }
    }
    
    public func didUpdatePopulation(_ generation: Int, bestOrganisms: [Organism]) {
        print("Generation: \(generation),", "Best:", bestOrganisms[0].score)
        bestOrganisms.forEach({ print($0) })
    }
}
