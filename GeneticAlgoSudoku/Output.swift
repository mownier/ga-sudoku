//
//  Output.swift
//  GeneticAlgoSudoku
//
//  Created by Mounir Ybanez on 10/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

public struct Output: GeneticAlgorithmOutputProtocol {

    public func didComplete(_ result: GeneticAlgorithmResult) {
        switch result {
        case .fittestFound(let generation, let organisms):
            print("Solution found")
            print("On generation:", generation)
            for organism in organisms {
                print(organism)
            }
            
        case .generationFinished(let organisms):
            print("Solution not found")
            for organism in organisms {
                print("\nScore:", organism.score)
                print(organism)
            }
        }
    }
}
