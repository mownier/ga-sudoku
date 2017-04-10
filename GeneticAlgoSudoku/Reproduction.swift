//
//  Reproduction.swift
//  GeneticAlgoSudoku
//
//  Created by Mounir Ybanez on 07/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Foundation

public struct Reproduction: ReproductionProtocol {

    private var fitness: FitnessProtocol
    
    public init(fitness: FitnessProtocol) {
        self.fitness = fitness
    }
    
    public func selectParentCandidates(from organisms: [Organism]) -> [Organism] {
        let survivedOrganisms = fitness.performNaturalSelection(from: organisms)
        return organisms.filter({ !survivedOrganisms.contains($0) })
    }
    
    public func selectParents(from organisms: [Organism]) -> (Organism, Organism) {
        guard organisms.count > 0 else {
            return (Organism(), Organism())
        }
        
        guard organisms.count > 1 else {
            return (organisms[0], organisms[0])
        }
        
        guard organisms.count > 2 else {
            return (organisms[0], organisms[1])
        }
        
        let parent1Index = Int(arc4random()) % organisms.count
        let parent2Index = Int(arc4random()) % organisms.count
        return (organisms[parent1Index], organisms[parent2Index])
    }
    
    public func mate(firstParent: Organism, secondParent: Organism) -> [Organism] {
        let chromosomes1 = firstParent.chromosomes.filter({ !$0.isGiven })
        let chromosomes2 = secondParent.chromosomes.filter({ !$0.isGiven })
        
        guard chromosomes1.count > 0, chromosomes2.count > 0 else {
            return [firstParent, secondParent]
        }
        
        let crossoverPointIndex = Int(arc4random()) % min(chromosomes1.count, chromosomes2.count)
        
        var firstParentChromosome1 = [Chromosome]()
        var secondParentChromsome1 = [Chromosome]()
        
        for i in 0..<crossoverPointIndex {
            firstParentChromosome1.append(chromosomes1[i])
            secondParentChromsome1.append(chromosomes2[i])
        }
        
        var firstParentChromosome2 = [Chromosome]()
        var secondParentChromsome2 = [Chromosome]()
        
        for i in crossoverPointIndex..<max(chromosomes1.count, chromosomes2.count) {
            if i < chromosomes1.count {
                firstParentChromosome2.append(chromosomes1[i])
            }
            
            if i < chromosomes2.count {
                secondParentChromsome2.append(chromosomes2[i])
            }
        }
        
        let chromosomeResult1 = Array([firstParentChromosome1, secondParentChromsome2].joined())
        let chromosomeResult2 = Array([firstParentChromosome2, secondParentChromsome1].joined())
        
        var firstChild = Organism()
        var index: Int = -1
        firstChild.chromosomes = firstParent.chromosomes.map({
            guard !$0.isGiven else { return $0 }
            index += 1
            return chromosomeResult1[index]
        })
        firstChild.score = fitness.computeScore(for: firstChild)
        
        var secondChild = Organism()
        index = -1
        secondChild.chromosomes = secondParent.chromosomes.map({
            guard !$0.isGiven else { return $0 }
            index += 1
            return chromosomeResult2[index]
        })
        secondChild.score = fitness.computeScore(for: secondChild)
        
        return secondChild.score > firstChild.score ? [secondChild] : [firstChild]
    }
}
