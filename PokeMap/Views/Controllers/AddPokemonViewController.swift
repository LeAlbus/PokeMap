//
//  AddPokemonViewController.swift
//  PokeMap
//
//  Created by Pedro Lopes on 26/05/19.
//  Copyright © 2019 Pedro Lopes. All rights reserved.
//

import Foundation
import UIKit

class AddPokemonViewController : UIViewController {
    
    var editingPoke: (poke: PokeInfo, quantity: Int, position: Int)?
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var pokeNumberLabel: UILabel!
    @IBOutlet weak var pokeHeightLabel: UILabel!
    @IBOutlet weak var pokeWeightLabel: UILabel!
    @IBOutlet weak var pokeErrorLabel: UILabel!
    @IBOutlet weak var pokeSearchField: UITextField!
    @IBOutlet weak var pokeQuantityField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    var pokeSearched: PokeInfo?
    
    override func viewDidLoad() {
        if self.editingPoke != nil {
            self.showPokeInfo(self.editingPoke!.poke)
            self.pokeQuantityField.text = String(self.editingPoke!.quantity)
            self.pokeSearchField.text = self.editingPoke?.poke.name
        }
    }
    
    @IBAction func searchPokeAction(_ sender: Any) {
        
        self.pokeNameLabel.isHidden = true
        self.pokeNumberLabel.isHidden = true
        self.pokeHeightLabel.isHidden = true
        self.pokeWeightLabel.isHidden = true
        self.pokeErrorLabel.isHidden = true
        
        if let input = pokeSearchField.text{
            if let number = Int(input) {
                if number > 0 && number <= PokemonMaxNumber {
                    
                    APIManager().getPokeInfo(searchNmbr: number, resultHandler: { poke in
                        
                        self.showPokeInfo(poke)
                        
                    }, errorHandler: { requested in
                        
                        if requested {
                            
                            self.showError(pokemonSearchErrorNumber)
                        }
                    })
                }
            }
                
            else {
                
                APIManager().getPokeInfo(searchStr: input, resultHandler: { poke in
                    
                    self.showPokeInfo(poke)
                }, errorHandler: { requested in
                    
                    if requested {
                        
                        self.showError(pokemonSearchErrorNumber)
                    }
                })
            }
        }
        
    }
    
    @IBAction func addPokeAction(_ sender: Any) {
        
        let replacingValue = self.editingPoke?.position ?? -1
        
        if let poke = self.pokeSearched {
            if let totalTxt = pokeQuantityField.text{
                if let totalNmbr = Int(totalTxt) {
                    if totalNmbr > 0{
                        
                        FirebaseDatabaseManager().saveGoalFor(poke: poke, quantity: totalNmbr, replacing: replacingValue, completion: {
                            let notification: Notification = Notification(name: Notification.Name(rawValue: "updatedWishList"))
                            NotificationCenter().post(notification)
                            self.navigationController?.popViewController(animated: true)
                        })
                    }
                }
            }
        }
    }
    
    func showError(_ message: String) {
        
        self.pokeErrorLabel.text = message
        
        self.pokeErrorLabel.isHidden = true
        
        
        self.pokeNameLabel.isHidden = true
        self.pokeNumberLabel.isHidden = true
        self.pokeHeightLabel.isHidden = true
        self.pokeWeightLabel.isHidden = true
        
        self.pokeQuantityField.isHidden = true
        self.addButton.isHidden = true
        
    }
    
    func showPokeInfo(_ pokeInfo: PokeInfo) {
        
        self.pokeSearched = pokeInfo
        
        self.pokeErrorLabel.isHidden = true
        
        self.pokeNameLabel.text = pokeInfo.name
        self.pokeNameLabel.isHidden = false
        
        self.pokeNumberLabel.text = String(pokeInfo.number)
        self.pokeNumberLabel.isHidden = false
        
        self.pokeHeightLabel.text = String(pokeInfo.height)
        self.pokeHeightLabel.isHidden = false
        
        self.pokeWeightLabel.text = String(pokeInfo.weight)
        self.pokeWeightLabel.isHidden = false
        
        self.pokeQuantityField.isHidden = false
        
        self.addButton.isHidden = false
    }
}
