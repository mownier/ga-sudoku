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
    
    public init(organismCount: Int = 10, generationCount: Int = 100) {
        numberOfOrganisms = organismCount
        numberOfGenerations = generationCount
    }
    
    public func generateInitialOrganisms(from organism: Organism) -> [Organism] {
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
}
