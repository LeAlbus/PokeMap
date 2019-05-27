//
//  AdjustsViewController.swift
//  PokeMap
//
//  Created by Pedro Lopes on 26/05/19.
//  Copyright © 2019 Pedro Lopes. All rights reserved.
//

import Foundation
import UIKit

class AdjustsViewController: UIViewController {
    
    @IBOutlet weak var captureRatioSlider: UISlider!
    @IBOutlet weak var spawnLimitSlider: UISlider!
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        captureRatioSlider.value = Float(UserDefaultsManager().pokemonCaptureRatio())
        spawnLimitSlider.value = Float(UserDefaultsManager().pokemonSpawnLimit())
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        
        FirebaseAuthManager().logoutUser()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
       
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: false, completion: {
            if UIApplication.shared.keyWindow != nil
            {
                UIApplication.shared.keyWindow!.rootViewController = rootController
            }
        })
        
    }
    
    @IBAction func defineCaptureRatio(_ sender: UISlider) {
     
        let captureRatio = Int(sender.value)
        UserDefaultsManager().setPokemonCaptureRatio(captureRatio)
    }
    
    @IBAction func defineSpawnLimit(_ sender: UISlider) {
        
        let pokemonSpawns = Int(sender.value)
        UserDefaultsManager().setPokemonSpawnLimit(pokemonSpawns)
        print (pokemonSpawns)
    }
}
