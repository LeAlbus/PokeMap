////
////  FirebaseDatabaseManager.swift
////  PokeMap
////
////  Created by Pedro Lopes on 26/05/19.
////  Copyright © 2019 Pedro Lopes. All rights reserved.
////
//
//import Foundation
//import Firebase
//
//class FirebaseDatabaseManager {
//
//    func saveGoal(_ poke: PokeInfo) {
//
//        Database.database().reference().child("wishlist").setValue([["name": "bolinha", "peso": 3, "altura" : 5, "id": 34, "quantity": 49], ["name": "aassaasas", "peso": 31, "altura" : 25, "id": 314, "quantity": 492]])
//        print (Database.database().reference().child("wishlist"))
//    }
//
//
//}

//
//  FirebaseDatabaseManager.swift
//  PokeMap
//
//  Created by Pedro Lopes on 26/05/19.
//  Copyright © 2019 Pedro Lopes. All rights reserved.
//

import Foundation
import Firebase

class FirebaseDatabaseManager {
    
    
    func saveGoalFor(poke: PokeInfo, quantity: Int, replacing: Int = -1, completion: @escaping () -> ()) {
        
        var currentData: [(poke: PokeInfo, quantity: Int)] = []
            
        self.retrieveGoals(finishHandler: { pokes in
            
            currentData = pokes

            if replacing == -1 {
                currentData.append((poke: poke, quantity: quantity))
            }
            
            var updatedWishlist: [[String: Any]] = []
            
            for (index, pokemon) in currentData.enumerated() {
                
                var pokeToDict: [String: Any]
                
                if index != replacing{
                    pokeToDict = ["name": pokemon.poke.name,
                                  "id": pokemon.poke.number,
                                  "weight": pokemon.poke.weight,
                                  "height": pokemon.poke.height,
                                  "quantity": pokemon.quantity]
                    updatedWishlist.append(pokeToDict)

                } else {
                    pokeToDict = ["name": poke.name,
                                  "id": poke.number,
                                  "weight": poke.weight,
                                  "height": poke.height,
                                  "quantity": quantity]
                    updatedWishlist.append(pokeToDict)
                }
            }
            
            Database.database().reference().child("wishlist").setValue(updatedWishlist)
            completion()
        })
    }
    
    func retrieveGoals(finishHandler: @escaping ([(poke: PokeInfo, quantity: Int)]) -> ()) {
        
        var goals: [(poke: PokeInfo, quantity: Int)] = []
        Database.database().reference().child("wishlist").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists(){
                
                let snapArray = snapshot.value as! [NSDictionary]
                
                for poke in snapArray {
                    
                    
                    let name = poke["name"] as! String
                    let number = poke["id"] as! Int
                    let height = poke["height"] as! Int
                    let weight = poke["weight"] as! Int
                    let quantity = poke["quantity"] as! Int
                    let newPoke = PokeInfo(name: name, number: number, weight: weight, height: height)
                    
                    let pokeData = (poke: newPoke, quantity: quantity)
                    goals.append(pokeData)
                }
            }
            finishHandler(goals)
        })
    }
    
    func removeData() {
        Database.database().reference().child("wishlist").setValue(nil)
    }
}
