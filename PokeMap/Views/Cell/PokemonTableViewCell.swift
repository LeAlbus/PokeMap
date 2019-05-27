//
//  PokemonTableViewCell.swift
//  PokeMap
//
//  Created by Pedro Lopes on 05/05/19.
//  Copyright © 2019 Pedro Lopes. All rights reserved.
//

import Foundation
import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var capturedTotalLabel: UILabel!
    
    func setCellData(name: String, owned: Int) {
        
        self.pokemonNameLabel.text = name
        self.capturedTotalLabel.text = String(owned)
        
        self.containerView.backgroundColor = UIColor(named: "Owned")
        if owned == 0 {
            self.containerView.backgroundColor = UIColor(named: "NotOwned")
        }
    }
}
