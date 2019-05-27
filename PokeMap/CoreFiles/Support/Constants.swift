//
//  Constants.swift
//  PokeMap
//
//  Created by Pedro Lopes on 05/05/19.
//  Copyright © 2019 Pedro Lopes. All rights reserved.
//

import Foundation

let PokemonMaxNumber = 151
//let PokemonSpawnNumber = 5
let PokemonMaxLatDistance = 0.004
let PokemonMaxLonDistance = 0.003
let PokemonMinLatDistance = -0.004
let PokemonMinLonDistance = -0.003
let RefreshSpawnDistance = 0.005

//var pokemonCaptureRatio = 50 //Percent

let BaseAPIUrl = "https://pokeapi.co/api/v2/pokemon?limit="
let SearchAPIUrl = "https://pokeapi.co/api/v2/"

let WinTitle = "Congratulations!"
let LossTitle = "Oh no ):"
let WinText = "You just captured a "
let LossText = "just ran away"

let pokemonSearchErrorNumber = "Could not find pokemon. You must insert a valid pokemon name or a number between 0 and 151"

let userDefaultsOwnedListString = "OwnedPokemons"
let pokemonCaptureRatioKey = "PokemonCaptureRatio"
let pokemonSpawnLimitKey = "PokemonSpawnLimit"
