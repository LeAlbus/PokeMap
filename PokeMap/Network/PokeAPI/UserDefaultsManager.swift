//
//  UserDefaultsManager.swift
//  PokeMap
//
//  Created by Pedro Lopes on 05/05/19.
//  Copyright © 2019 Pedro Lopes. All rights reserved.
//

import Foundation

class UserDefaultsManager {
    
    init() {
        
        // This ensures the calling of initial method, avoiding null references.
        self.checkExistance()
        if UserDefaults.standard.integer(forKey: pokemonCaptureRatioKey) == 0 {
            
            self.setPokemonCaptureRatio()
        }
        
        if UserDefaults.standard.integer(forKey: pokemonSpawnLimitKey) == 0 {
            
            self.setPokemonSpawnLimit()
        }
    }
    
    //MARK: Pokemon list
    
    /// Checks if there is a list on UserDefaults. If not, adds one.
    func checkExistance () {
        
        if UserDefaults.standard.array(forKey: userDefaultsOwnedListString) == nil {
            
            var array: [Int] = []
            
            for _ in 1...PokemonMaxNumber {
                array.append(0)
            }
            
            UserDefaults.standard.set(array, forKey: userDefaultsOwnedListString)
        }
    }
    
    /// Adds one unity of the pokemon for the specified pokemon number
    ///
    /// - Parameter number: Number of the pokemon in the pokedex
    ///
    func addPokemon(number: Int) {
        
        var currentPokes = UserDefaults.standard.array(forKey: userDefaultsOwnedListString)! as! [Int]
        let ownedOfType = currentPokes[number-1]
        currentPokes[number] = ownedOfType + 1
        
        UserDefaults.standard.set(currentPokes, forKey: userDefaultsOwnedListString)
    }
    
    /// Gets the total number of captured pokemons
    /// for the specified pokemon number
    ///
    /// - Parameter number: Number of the pokemon in the pokedex
    /// - Returns: The amount of captured pokemons
    ///
    func getPokemonTotal(number: Int) -> Int{
        
        var currentPokes = UserDefaults.standard.array(forKey: userDefaultsOwnedListString)! as! [Int]
        
        return currentPokes[number]
    }
    
    /// Gets a list with total number of owned
    /// pokemons for each pokemon
    ///
    /// - Returns: Array with the values for de
    /// number of captured pokemons.
    /// Pokemon number is the index on the array.
    func getAllOwnedPokes() -> [Int] {
     
        return UserDefaults.standard.array(forKey: userDefaultsOwnedListString)! as! [Int]
    }
    
    /// Saves the full new list of pokemons
    ///
    /// - Parameter list: the new list to be saved
    ///
    func saveOwnedList(_ list: [Int]) {
        
        if list.count == PokemonMaxNumber{
            UserDefaults.standard.set(list, forKey: userDefaultsOwnedListString)
        }
    }
    
    //MARK: Capture ratio
    
    /// Gets the current capture ratio or sets a default one
    ///
    /// - Returns: The current capture ratio
    ///
    func pokemonCaptureRatio() -> Int {
     
        if UserDefaults.standard.integer(forKey: pokemonCaptureRatioKey) == 0 {
            
            self.setPokemonCaptureRatio()
        }
        
        return UserDefaults.standard.integer(forKey: pokemonCaptureRatioKey)
    }
    
    
    /// Defines capture ratio
    ///
    /// - Parameter ratio: new ratio value in percentage
    ///
    func setPokemonCaptureRatio(_ ratio: Int = 50) {
    
        UserDefaults.standard.set(ratio, forKey: pokemonCaptureRatioKey)
    }
    
    //MARK: Spawn limit
    
    /// Gets the current spawn limit or sets a default one
    ///
    /// - Returns: The current spawn limit
    ///
    func pokemonSpawnLimit() -> Int {
        
        if UserDefaults.standard.integer(forKey: pokemonSpawnLimitKey) == 0 {
            
            self.setPokemonSpawnLimit()
        }
        print (UserDefaults.standard.integer(forKey: pokemonSpawnLimitKey))
        return UserDefaults.standard.integer(forKey: pokemonSpawnLimitKey)
    }
    
    
    /// Defines spawn limit
    ///
    /// - Parameter ratio: new ratio limit
    ///
    func setPokemonSpawnLimit(_ ratio: Int = 5) {
         UserDefaults.standard.set(ratio, forKey: pokemonSpawnLimitKey)
        print (ratio)
    }
    
    func removeData(){
        
        var array: [Int] = []
        
        for _ in 1...PokemonMaxNumber {
            array.append(0)
        }
        
        UserDefaults.standard.set(array, forKey: userDefaultsOwnedListString)
    }
}
