//
//  Population.swift
//  GeneticAlgoSudoku
//
//  Created by Mounir Ybanez on 07/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Foundation

public struct Population: PopulationProtocol {

    public var numberOfOrganisms: Int
    public var numberOfGenerations: Int
    public var initialOrganisms: [Organism]?
    
    public init(organismCount: Int = 10, generationCount: Int = 100) {
        numberOfOrganisms = organismCount
        numberOfGenerations = generationCount
    }
    
    public func generateInitialOrganisms(from organism: Organism) -> [Organism] {
        guard initialOrganisms == nil else { return initialOrganisms! }
        
        var organisms = [Organism]()
        for _ in 0..<numberOfOrganisms {
            var newOrganism = Organism()
            newOrganism.chromosomes = organism.chromosomes.map({
                guard !$0.isGiven else { return $0 }
                
                var chromosome = $0
                chromosome.data = (Int(arc4random()) % 9) + 1
                return chromosome
            })
            organisms.append(newOrganism)
        }
        return organisms
    }
    
    public func generateRandomOrganism(from organism: Organism) -> Organism {
        var randomOrganism = Organism()
        randomOrganism.chromosomes = organism.chromosomes.map({
            guard !$0.isGiven else { return $0 }
            
            var chromosome = $0
            chromosome.data = (Int(arc4random()) % 9) + 1
            return chromosome
        })
        return randomOrganism
    }
}

extension Population: FileOutputProtocol {
    
    public var fileOutputInfo: [String : Any] {
        return [
            "organism_count": numberOfOrganisms,
            "generation_count": numberOfGenerations
        ]
    }
}
