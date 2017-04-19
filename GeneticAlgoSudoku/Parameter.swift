//
//  Parameter.swift
//  GeneticAlgoSudoku
//
//  Created by Mounir Ybanez on 17/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Foundation

public struct Parameter {

    public var survivalRate: Int
    public var mutationRate: Int
    public var initialOrganism: Organism
    public var initialOrganisms: [Organism]?
    public var generationCount: Int
    public var organismCount: Int
    public var executions: [CFAbsoluteTime]
    public var maxBestScoreCount: Int
    public var reader: FileReaderProtocol
    
    public init(reader: FileReaderProtocol = FileReader()) {
        self.survivalRate = 30
        self.mutationRate = 5
        self.generationCount = 50
        self.organismCount = 100
        self.maxBestScoreCount = Int(ceilf(Float(generationCount) * 0.15))
        self.initialOrganism = Organism()
        self.initialOrganisms = nil
        self.reader = reader
        self.executions = [CFAbsoluteTime]()
    }
    
    public mutating func process(from file: String = "output/unsolved.json") -> Bool {
        guard let info = reader.read(from: file) else { return false }
        
        var populationInfo = info["population"] as! [String: Any]
        var mutationInfo = info["mutation"] as! [String: Any]
        var fitnessInfo = info["fitness"] as! [String: Any]
        var givenInfo = info["given"] as! [String: Any]
        
        let organisms = info["organisms"] as! [[String: Any]]
        let indices = givenInfo["indices"] as! [Int]
        let data = givenInfo["data"] as! [Int]
        
        survivalRate = fitnessInfo["survival_rate"] as! Int
        mutationRate = mutationInfo["rate"] as! Int
        generationCount = populationInfo["generation_count"] as! Int
        organismCount = populationInfo["organism_count"] as! Int
        executions = info["executions"] as! [CFAbsoluteTime]
        
        var organism = Organism()
        
        for i in 0..<indices.count {
            let index = indices[i]
            let chromosomeData = data[i]
            organism.chromosomes[index].data = chromosomeData
        }
        
        initialOrganism = organism
        
        initialOrganisms = organisms.flatMap({ element -> Organism? in
            var organism = Organism()
            let marks = element["chromosomes"] as! [Int]
            organism.chromosomes = marks.enumerated().map({ index, mark in
                var chromosome = Chromosome()
                chromosome.data = mark
                chromosome.isGiven = indices.contains(index)
                return chromosome
            })
            organism.score = element["score"] as! Int
            return organism
        })
        
        return true
    }
}
