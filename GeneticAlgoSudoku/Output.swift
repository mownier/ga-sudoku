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
    
    public func didComputeScore(for organism: Organism) {
        print("computed score:", organism.score)
    }
    
    public func didPerformNaturalSelection(_ survivedOrganisms: [Organism]) {
        print("number of survived organisms:", survivedOrganisms.count)
    }
    
    public func didSelectParentCandidates(_ candidates: [Organism]) {
        print("number of parent candidates:", candidates.count)
    }
    
    public func didSelectParents(_ parent1: Organism, _ parent2: Organism) {
        print("parent1:", parent1.score, ", parent2:", parent2.score)
    }
    
    public func didMate(_ children: [Organism]) {
        print("number of children:", children.count)
        children.sorted(by: { $0.score > $1.score }).enumerated().forEach({
            print("child \($0 + 1):", $1.score)
        })
    }
    
    public func didChildMutate(_ child: Organism) {
        print("child is mutated:", child.score)
    }
}
