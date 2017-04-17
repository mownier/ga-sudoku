//
//  Mutation.swift
//  GeneticAlgoSudoku
//
//  Created by Mounir Ybanez on 07/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Foundation

public struct RandomMutation: MutationProtocol {

    public var rate: Int = 2 // 2 %
    public var isAllowed: Bool {
        return  (arc4random() % 100 + 1) <= UInt32(rate)
    }
    
    public func mutate(_ organism: Organism) -> Organism {
        var newOrganism = Organism()
        let randomIndex = Int(arc4random()) % organism.chromosomes.count
        newOrganism.chromosomes = organism.chromosomes.map({
            guard let index = organism.chromosomes.index(of: $0),
                randomIndex == index, !$0.isGiven else {
                return $0
            }
            
            var chromosome = $0
            chromosome.data = (Int(arc4random()) % 9) + 1
            return chromosome
        })
        
        return newOrganism
    }
}

extension RandomMutation: FileOutputProtocol {
    
    public var fileOutputInfo: [String : Any] {
        return [
            "rate": rate
        ]
    }
}
