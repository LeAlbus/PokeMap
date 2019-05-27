//
//  GoalTableViewCell.swift
//  PokeMap
//
//  Created by Pedro Lopes on 27/05/19.
//  Copyright © 2019 Pedro Lopes. All rights reserved.
//

import Foundation
import UIKit

class GoalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var pokeWidthLabel: UILabel!
    @IBOutlet weak var pokeHeightLabel: UILabel!
    @IBOutlet weak var pokeWishedTotal: UILabel!
    @IBOutlet weak var pokeOwnedTotal: UILabel!
    
    func setCellData(poke: PokeInfo, quantity: Int, owned: Int) {
        
        self.pokeNameLabel.text = poke.name.uppercased()
        self.pokeHeightLabel.text = "Height: " + String(poke.height) + ".0"
        self.pokeWidthLabel.text = "Weight: " + String(poke.weight) + ".0"
        
        self.pokeWishedTotal.text = "Wished: " + String(quantity)
        self.pokeOwnedTotal.text = "Owned: " + String(owned)
    }
}
