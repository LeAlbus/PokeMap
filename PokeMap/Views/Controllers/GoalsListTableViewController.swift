//
//  GoalsListTableViewController.swift
//  PokeMap
//
//  Created by Pedro Lopes on 27/05/19.
//  Copyright © 2019 Pedro Lopes. All rights reserved.
//

import UIKit

class GoalsListTableViewController: UITableViewController {
    
    var list: [(poke: PokeInfo, quantity: Int)]?
    var segueData: (poke: PokeInfo, quantity: Int, position: Int)?
    
    override func viewWillAppear(_ animated: Bool) {
        
       self.retrieveUpdatedValues()
    }
    
    func retrieveUpdatedValues() {
        FirebaseDatabaseManager().retrieveGoals { (currentList) in
            
            self.list = currentList
            self.tableView.reloadData()
        }
        self.segueData = nil
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoalCell")! as! GoalTableViewCell
        
        guard let list = self.list else {
            return UITableViewCell()
        }
        
        if !list.isEmpty{
                
            let poke = self.list![indexPath.row].poke
             let ownedNumber = UserDefaultsManager().getPokemonTotal(number: poke.number)
            
            cell.setCellData(poke: poke, quantity: self.list![indexPath.row].quantity, owned: ownedNumber)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 126
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let list = self.list else {
            return
        }
        
        if !list.isEmpty{
            let seguePoke = self.list![indexPath.row].poke
            let segueQuantity = self.list![indexPath.row].quantity
            let seguePosition = indexPath.row
            
            self.segueData = (poke: seguePoke, quantity: segueQuantity, position: seguePosition)
        }
        
        self.performSegue(withIdentifier: "EditGoal", sender: self.tableView.cellForRow(at: indexPath))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "EditGoal" {
            
            let dest = segue.destination as! AddPokemonViewController
            dest.editingPoke = self.segueData
            
            NotificationCenter().addObserver(self, selector:("retrieveUpdatedValues"), name: NSNotification.Name(rawValue: "updatedWishList"), object: nil)
        }
    }
}
