//
//  Output.swift
//  GeneticAlgoSudoku
//
//  Created by Mounir Ybanez on 10/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Foundation

public struct TerminalOutput: GeneticAlgorithmOutputProtocol {

    var writer: FileWriterProtocol = FileWriter()
    
    public func didComplete(_ algo: GeneticAlgorithm, _ result: GeneticAlgorithmResult) {
        switch result {
        case .fittestFound(let generation, let organisms):
            print("Solution found")
            print("On generation:", generation)
            organisms.forEach({ print($0) })
            
        case .generationFinished(let organisms):
            print("Solution not found")
            
            var organismsInfo = [[String: Any]]()
            organisms.sorted(by: { $0.score < $1.score }).forEach({
                print("\nScore:", $0.score)
                print($0)
                
                organismsInfo.append($0.fileOutputInfo)
            })
            
            var info = [String: Any]()
            
            info["organisms"] = organismsInfo
            
            if let outputProtocol = algo.population as? FileOutputProtocol {
                info["population"] = outputProtocol.fileOutputInfo
            }
            
            if let outputProtocol = algo.mutation as? FileOutputProtocol {
                info["mutation"] = outputProtocol.fileOutputInfo
            }
            
            if let outputProtocol = algo.fitness as? FileOutputProtocol {
                info["fitness"] = outputProtocol.fileOutputInfo
            }
            
            if let organism = organisms.max(by: { $0.score >= $1.score }) {
                info["current_best_score"] = organism.score
            
            } else {
                info["current_best_score"] = 0
            }
            
            writer.write(info)
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
