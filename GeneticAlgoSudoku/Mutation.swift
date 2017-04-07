//
//  Mutation.swift
//  GeneticAlgoSudoku
//
//  Created by Mounir Ybanez on 07/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Foundation

public struct RandomMutation: MutationProtocol {

    public var rate: UInt8 = 2 // 2 %
    public var isAllowed: Bool {
        return UInt32(rate) <= arc4random() % 100 + 1
    }
    
    
    public func mutate(_ organism: Organism) -> Organism {
        guard isAllowed else { return organism }
        
        var newOrganism = Organism()
        let randomIndex = Int(arc4random()) % organism.chromosomes.count
        newOrganism.chromosomes = organism.chromosomes.map({
            guard let index = organism.chromosomes.index(of: $0),
                randomIndex == index, !$0.isGiven else {
                return $0
            }
            
            var chromosome = $0
            let data = Int(arc4random()) % 9
            chromosome.data = UInt8(data + 1)
            return chromosome
        })
        
        return newOrganism
    }
}
