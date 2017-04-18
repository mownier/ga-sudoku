//
//  Reproduction.swift
//  GeneticAlgoSudoku
//
//  Created by Mounir Ybanez on 07/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Foundation

public struct Reproduction: ReproductionProtocol {
    
    var fitness: FitnessProtocol
    
    public init(fitness: FitnessProtocol) {
        self.fitness = fitness
    }
    
    public func selectParentCandidates(from organisms: [Organism]) -> [Organism] {
        let survived = fitness.performNaturalSelection(from: organisms)
        return organisms.filter({ !survived.contains($0) })
    }
    
    public func selectParents(from organisms: [Organism]) -> (Organism, Organism) {
        guard organisms.count > 0 else { return (Organism(), Organism()) }
        guard organisms.count > 1 else { return (organisms[0], organisms[0]) }
        guard organisms.count > 2 else { return (organisms[0], organisms[1]) }
        
        let parent1 = Int(arc4random()) % organisms.count
        let parent2 = Int(arc4random()) % organisms.count
        return (organisms[parent1], organisms[parent2])
    }
    
    public func mate(firstParent: Organism, secondParent: Organism) -> [Organism] {
        let chromosomes1 = firstParent.chromosomes.filter({ !$0.isGiven })
        let chromosomes2 = secondParent.chromosomes.filter({ !$0.isGiven })
        
        guard chromosomes1.count > 0, chromosomes2.count > 0, chromosomes1.count == chromosomes2.count else { return [Organism]() }
        
        let numberOfCandidates = 4
        
        var crossoverPointCandidates1 = [[Chromosome]]()
        var crossoverPointCandidates2 = [[Chromosome]]()
        
        for index in 0..<chromosomes1.count {
            let candidateIndex = index % numberOfCandidates
            if candidateIndex >= crossoverPointCandidates1.count {
                crossoverPointCandidates1.append([Chromosome]())
                crossoverPointCandidates2.append([Chromosome]())
            }
            crossoverPointCandidates1[candidateIndex].append(chromosomes1[index])
            crossoverPointCandidates2[candidateIndex].append(chromosomes2[index])
        }
        
        var children = [Organism]()
        
        var candidates1 = crossoverPointCandidates1
        var candidates2 = crossoverPointCandidates2
        
        let swapIndex1 = Int(arc4random()) % numberOfCandidates
        let swapIndex2 = Int(arc4random()) % numberOfCandidates
        let swapIndex3 = Int(arc4random()) % numberOfCandidates
        let swapIndex4 = Int(arc4random()) % numberOfCandidates
        
        candidates1[swapIndex3] = crossoverPointCandidates2[swapIndex1]
        candidates1[swapIndex4] = crossoverPointCandidates2[swapIndex2]
        
        candidates2[swapIndex3] = crossoverPointCandidates1[swapIndex1]
        candidates2[swapIndex4] = crossoverPointCandidates1[swapIndex2]
        
        var child = Organism()
        
        var chromosomes: [Chromosome] = candidates1.flatMap({ $0 })
        var index = 0
        child.chromosomes = firstParent.chromosomes.map({
            guard !$0.isGiven, index < chromosomes.count else { return $0 }
            let chromosome = chromosomes[index]
            index += 1
            return chromosome
        })
        children.append(child)
        
        chromosomes = candidates2.flatMap({ $0 })
        index = 0
        child.chromosomes = secondParent.chromosomes.map({
            guard !$0.isGiven, index < chromosomes.count else { return $0 }
            let chromosome = chromosomes[index]
            index += 1
            return chromosome
        })
        children.append(child)
    
        return children
    }
}
