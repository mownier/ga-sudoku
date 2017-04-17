//
//  main.swift
//  GeneticAlgoSudoku
//
//  Created by Mounir Ybanez on 06/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

var param = Parameter()
if param.process() {
    let sudoku = Sudoku(puzzle: .three)
    param.initialOrganism.chromosomes = sudoku.chromosomes
}

var fitness = Elitism(survivalRate: param.survivalRate)
var population = Population()
var organism = Organism()
var mutation = RandomMutation()

let reproduction = Reproduction(fitness: fitness)

mutation.rate = param.mutationRate
population.numberOfGenerations = param.generationCount
population.numberOfOrganisms = param.organismCount
population.initialOrganisms = param.initialOrganisms

var algo = GeneticAlgorithm(
    organism: param.initialOrganism,
    population: population,
    fitness: fitness,
    mutation: mutation,
    reproduction: reproduction
)
algo.output = TerminalOutput()
algo.solve()
