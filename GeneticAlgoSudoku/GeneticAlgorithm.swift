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
    public var output: GeneticAlgorithmOutputProtocol?
    
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
        generateInitialSolutions()
        computeSolutionScores()
        sortSolutions()
        
        var bestScore: Int = 0
        var bestScoreCount: Int = 0
        
        for i in 0..<population.numberOfGenerations {
            let candidates = reproduction.selectParentCandidates(from: solutions)
            output?.didSelectParentCandidates(candidates)
            
            solutions = fitness.performNaturalSelection(from: solutions)
            output?.didPerformNaturalSelection(solutions)
            
            while solutions.count < population.numberOfOrganisms {
                let (parent1, parent2) = reproduction.selectParents(from: candidates)
                output?.didSelectParents(parent1, parent2)
                
                var children = reproduction.mate(firstParent: parent1, secondParent: parent2)
                output?.didMate(children)
                
                children = children.map({
                    let child = mutation.mutate($0)
                    if child == $0 {
                        output?.didChildMutate($0)
                    }
                    return child
                })
                
                var i = 0
                while solutions.count < population.numberOfOrganisms && i < children.count {
                    solutions.append(children[i])
                    i += 1
                }
            }
            
            computeSolutionScores()
            sortSolutions()
            
            if solutions[0].score > bestScore {
                bestScore = solutions[0].score
                bestScoreCount = 0
                
                if bestScore == fitness.bestScore {
                    let bestSolutions = solutions.filter({ $0.score == fitness.bestScore })
                    var fittest = [Organism]()
                    for solution in bestSolutions {
                        if !fittest.contains(solution) {
                            fittest.append(solution)
                        }
                    }
                    output?.didComplete(.fittestFound(i + 1, fittest))
                    return
                }
            
            } else {
                bestScoreCount += 1
            }
            
            output?.didUpdatePopulation(i + 1, bestOrganisms: solutions.filter({ $0.score == bestScore }))
            
            var uniqueSolutions = [Organism]()
            for solution in solutions {
                if !uniqueSolutions.contains(solution) {
                    uniqueSolutions.append(solution)
                }
            }
            
            solutions = uniqueSolutions
        }
        
        var uniqueSolutions = [Organism]()
        for solution in solutions {
            if !uniqueSolutions.contains(solution) {
                uniqueSolutions.append(solution)
            }
        }
        uniqueSolutions = uniqueSolutions.sorted(by: { $0.score > $1.score })
        output?.didComplete(.generationFinished(uniqueSolutions))
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
            output?.didComputeScore(for: organism)
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

    var bestScore: Int { get }
    
    func computeScore(for organism: Organism) -> Int
    func performNaturalSelection(from organisms: [Organism]) -> [Organism]
}

public protocol MutationProtocol {
    
    var rate: Int { get }
    var isAllowed: Bool { get }
    
    func mutate(_ organism: Organism) -> Organism
}

public protocol ReproductionProtocol {
    
    func selectParentCandidates(from organisms: [Organism]) -> [Organism]
    func selectParents(from organisms: [Organism]) -> (Organism, Organism)
    func mate(firstParent: Organism, secondParent: Organism) -> [Organism]
}

public protocol GeneticAlgorithmOutputProtocol {
    
    func didComplete(_ result: GeneticAlgorithmResult)
    func didUpdatePopulation(_ generation: Int, bestOrganisms: [Organism])
    func didComputeScore(for organism: Organism)
    func didPerformNaturalSelection(_ survivedOrganisms: [Organism])
    func didSelectParentCandidates(_ candidates: [Organism])
    func didSelectParents(_ parent1: Organism, _ parent2: Organism)
    func didMate(_ children: [Organism])
    func didChildMutate(_ child: Organism)
}

public enum GeneticAlgorithmResult {
    
    case fittestFound(Int, [Organism])
    case generationFinished([Organism])
}
