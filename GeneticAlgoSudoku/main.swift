//
//  main.swift
//  GeneticAlgoSudoku
//
//  Created by Mounir Ybanez on 06/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Foundation

//let data = [
//    0,0,0, 0,0,0, 9,8,0,
//    0,7,0, 0,0,0, 6,0,0,
//    4,0,0, 0,7,0, 0,0,0,
//    
//    0,0,1, 5,0,0, 0,6,0,
//    0,0,0, 0,0,8, 0,9,0,
//    9,0,0, 3,0,7, 0,0,0,
//    
//    0,0,6, 8,0,0, 0,4,0,
//    0,0,0, 0,6,0, 0,1,8,
//    0,5,0, 0,0,1, 2,0,0
//]

//let data = [
//    5,3,0, 0,7,0, 0,0,0,
//    6,0,0, 1,9,5, 0,0,0,
//    0,9,8, 0,0,0, 0,6,0,
//    
//    8,0,0, 0,6,0, 0,0,3,
//    4,0,0, 8,0,3, 0,0,1,
//    7,0,0, 0,2,0, 0,0,6,
//    
//    0,6,0, 0,0,0, 2,8,0,
//    0,0,0, 4,1,9, 0,0,5,
//    0,0,0, 0,8,0, 0,7,9
//]

//let data = [
//    0,0,0, 0,5,0, 0,0,0,
//    0,0,6, 4,0,3, 1,0,0,
//    0,7,1, 2,6,8, 3,5,0,
//    
//    0,9,5, 0,3,0, 6,4,0,
//    1,0,8, 5,0,6, 7,0,3,
//    0,6,4, 0,1,0, 5,2,0,
//    
//    0,5,2, 9,8,1, 4,3,0,
//    0,0,9, 3,0,4, 2,0,0,
//    0,0,0, 0,2,0, 0,0,0
//]

let data = [
    0,0,5, 1,3,4, 9,8,7,
    0,7,9, 2,8,5, 6,3,4,
    4,8,3, 9,7,6, 1,2,5,
    
    8,4,1, 5,2,9, 7,6,3,
    5,3,7, 6,1,8, 4,9,2,
    9,6,2, 3,4,7, 8,5,1,
    
    7,1,6, 8,5,2, 3,4,9,
    2,9,4, 7,6,3, 5,1,8,
    3,5,8, 4,9,1, 2,7,6
]

var chromosomes: [Chromosome] {
    var chromosomes = [Chromosome]()
    for value in data {
        var chromosome = Chromosome()
        if value > 0 && value < 10 {
            chromosome.data = value
            chromosome.isGiven = true
        }
        chromosomes.append(chromosome)
    }
    return chromosomes
}

var fitness = Elitism(survivalRate: 5)
var population = Population()
var organism = Organism()

let mutation = RandomMutation()
let reproduction = Reproduction(fitness: fitness)

organism.chromosomes = chromosomes
population.numberOfGenerations = 10
population.numberOfOrganisms = 50

var algo = GeneticAlgorithm(
    organism: organism,
    population: population,
    fitness: fitness,
    mutation: mutation,
    reproduction: reproduction
)
algo.output = TerminalOutput()
algo.solve()

