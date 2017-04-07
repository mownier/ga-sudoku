//
//  main.swift
//  GeneticAlgoSudoku
//
//  Created by Mounir Ybanez on 06/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Foundation

let organism = Organism()
let population = Population()
let fitness = Elitism()
let mutation = RandomMutation()
let reproduction = Reproduction()
var algo = GeneticAlgorithm(
    organism: organism,
    population: population,
    fitness: fitness,
    mutation: mutation,
    reproduction: reproduction
)
algo.solve()
