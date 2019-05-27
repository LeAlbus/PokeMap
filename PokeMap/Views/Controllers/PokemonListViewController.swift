//
//  SecondViewController.swift
//  PokeMap
//
//  Created by Pedro Lopes on 01/05/19.
//  Copyright © 2019 Pedro Lopes. All rights reserved.
//

import UIKit

class PokemonListViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        APIManager.sharedInstance.requestRepoList(){
            response in
            if !response.isEmpty{
                GlobalPokeList = response
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GlobalPokeList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokeCell")! as! PokemonTableViewCell
        
        if !GlobalPokeList.isEmpty{
            
            let pokeForCell = GlobalPokeList[indexPath.row]
            
            let ownedNumber = UserDefaultsManager().getPokemonTotal(number: indexPath.row)
            
            cell.setCellData(name: pokeForCell.name, owned: ownedNumber)
            
        }
        return cell
    }
}

