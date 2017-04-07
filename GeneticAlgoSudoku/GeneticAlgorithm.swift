//
//  GeneticAlgorithm.swift
//  GeneticAlgoSudoku
//
//  Created by Mounir Ybanez on 06/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

public struct GeneticAlgorithm {
    
    public let organism: Organism
    public let fitness: FitnessProtocol
    public let mutation: MutationProtocol
    public let population: PopulationProtocol
    public let reproduction: ReproductionProtocol
    
    private var solutions: [Organism]
    
    public init(organism: Organism, population: PopulationProtocol, fitness: FitnessProtocol, mutation: MutationProtocol, reproduction: ReproductionProtocol) {
        self.population = population
        self.organism = organism
        self.fitness = fitness
        self.mutation = mutation
        self.reproduction = reproduction
        self.solutions = [Organism]()
    }
    
    public mutating func solve() {
        var solutionBestScore: UInt8 = 0
        
        generateInitialSolutions()
        
        print("===============================================")
        for i in 0..<population.numberOfGenerations {
            print("Generation", i + 1)
            
            print("---- Computing solution scores")
            computeSolutionScores()
            
            print("---- Sorting solutions")
            sortSolutions()
            
            let generationBestScore = solutions[0].score
            solutionBestScore = generationBestScore > solutionBestScore ? generationBestScore : solutionBestScore
            
            if solutionBestScore == fitness.bestScore {
                print("---- Solution found")
                let bestSolutions = solutions.filter({ $0.score == fitness.bestScore })
                print(bestSolutions)
                print("===============================================")
                return
            }
            
            print("---- Selecting parent candidates")
            let candidates = reproduction.selectParentCandidates(from: solutions)
            
            print("---- Performing natural selection")
            solutions = fitness.performNaturalSelection(from: solutions)

            print("---- Mating parents for new organisms")
            while solutions.count < population.numberOfOrganisms {
                let (parent1, parent2) = reproduction.selectParents(from: candidates)
                var children = reproduction.mate(firstParent: parent1, secondParent: parent2)
                children = children.map({ mutation.mutate($0) })
                solutions.append(contentsOf: children)
            }
        }
        
        print("---- Solution not found")
        print("---- Best score:", solutionBestScore)
        print(solutions.filter({ $0.score == solutionBestScore }))
        print("===============================================")
    }
    
    private mutating func generateInitialSolutions() {
        solutions.removeAll()
        solutions.append(contentsOf: population.generateInitialOrganisms(from: organism))
    }
    
    private mutating func sortSolutions() {
        solutions = solutions.sorted(by: { $0.score > $1.score })
    }
    
    private mutating func computeSolutionScores() {
        solutions = solutions.map({
            var organism = $0
            organism.score = fitness.computeScore(for: $0)
            return organism
        })
    }
}

public protocol PopulationProtocol {
    
    var numberOfOrganisms: Int { get }
    var numberOfGenerations: Int { get }
    
    func generateInitialOrganisms(from organism: Organism) -> [Organism]
}

public protocol FitnessProtocol {

    var bestScore: UInt8 { get }
    
    func computeScore(for organism: Organism) -> UInt8
    func performNaturalSelection(from organisms: [Organism]) -> [Organism]
}

public protocol MutationProtocol {
    
    var rate: UInt8 { get }
    var isAllowed: Bool { get }
    
    func mutate(_ organism: Organism) -> Organism
}

public protocol ReproductionProtocol {
    
    func selectParentCandidates(from organisms: [Organism]) -> [Organism]
    func selectParents(from organisms: [Organism]) -> (Organism, Organism)
    func mate(firstParent: Organism, secondParent: Organism) -> [Organism]
}
