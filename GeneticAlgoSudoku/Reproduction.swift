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
        return fitness.performNaturalSelection(from: organisms)
    }
    
    public func selectParents(from organisms: [Organism]) -> (Organism, Organism) {
        guard organisms.count > 0 else { return (Organism(), Organism()) }
        guard organisms.count > 1 else { return (organisms[0], organisms[0]) }
        guard organisms.count > 2 else { return (organisms[0], organisms[1]) }
        
        let sorted = organisms.sorted(by: { $0.score > $1.score })
        let parent1 = 0
        let parent2 = (Int(arc4random()) % (sorted.count - 1)) + 1
        return (sorted[parent1], sorted[parent2])
    }
    
    public func mate(firstParent: Organism, secondParent: Organism) -> [Organism] {
        let chromosomes1 = firstParent.chromosomes.filter({ !$0.isGiven })
        let chromosomes2 = secondParent.chromosomes.filter({ !$0.isGiven })
        
        guard chromosomes1.count > 0, chromosomes2.count > 0, chromosomes1.count == chromosomes2.count else { return [Organism]() }
        
        let numberOfCandidates = 4
        
        var crossoverPointCandidates1 = [[Chromosome]]()
        for (index, chromosome) in chromosomes1.enumerated() {
            let candidateIndex = index % numberOfCandidates
            if candidateIndex >= crossoverPointCandidates1.count {
                crossoverPointCandidates1.append([Chromosome]())
            }
            crossoverPointCandidates1[candidateIndex].append(chromosome)
        }
        
        var crossoverPointCandidates2 = [[Chromosome]]()
        for (index, chromosome) in chromosomes2.enumerated() {
            let candidateIndex = index % numberOfCandidates
            if candidateIndex >= crossoverPointCandidates2.count {
                crossoverPointCandidates2.append([Chromosome]())
            }
            crossoverPointCandidates2[candidateIndex].append(chromosome)
        }
        
        var children = [Organism]()
        
        if crossoverPointCandidates1.count < numberOfCandidates || crossoverPointCandidates2.count < numberOfCandidates {
            let randomIndex1 = Int(arc4random()) % crossoverPointCandidates1.count
            let randomIndex2 = Int(arc4random()) % crossoverPointCandidates2.count
            
            var candidates1 = crossoverPointCandidates1
            var candidates2 = crossoverPointCandidates2
            
            candidates1[randomIndex1] = crossoverPointCandidates2[randomIndex2]
            candidates2[randomIndex2] = crossoverPointCandidates1[randomIndex1]
            
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
        
        } else {
            if crossoverPointCandidates1.count == numberOfCandidates &&
                crossoverPointCandidates2.count == numberOfCandidates &&
                crossoverPointCandidates1.count == crossoverPointCandidates2.count {
                var candidates1 = crossoverPointCandidates1
                var candidates2 = crossoverPointCandidates2
                
                candidates1[0] = crossoverPointCandidates2[1]
                candidates1[2] = crossoverPointCandidates2[3]
                
                candidates2[0] = crossoverPointCandidates1[1]
                candidates2[2] = crossoverPointCandidates1[3]
                
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
            }
        }
        
        return children
    }
}
