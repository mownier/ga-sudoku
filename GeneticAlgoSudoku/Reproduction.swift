//
//  Reproduction.swift
//  GeneticAlgoSudoku
//
//  Created by Mounir Ybanez on 07/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

struct Reproduction: ReproductionProtocol {

    func selectParentCandidates(from organisms: [Organism]) -> [Organism] {
        return organisms
    }
    
    func selectParents(from organisms: [Organism]) -> (Organism, Organism) {
        guard organisms.count > 0 else {
            return (Organism(), Organism())
        }
        
        guard organisms.count > 1 else {
            return (organisms[0], organisms[0])
        }
        
        return (organisms[0], organisms[1])
    }
    
    func mate(firstParent: Organism, secondParent: Organism) -> [Organism] {
        return [firstParent, secondParent]
    }
}
