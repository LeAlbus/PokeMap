//
//  AboutScreenViewController.swift
//  PokeMap
//
//  Created by Pedro Lopes on 26/05/19.
//  Copyright © 2019 Pedro Lopes. All rights reserved.
//

import Foundation
import UIKit

class AboutScreenViewController: UIViewController {
    
    @IBOutlet weak var appVersionLabel: UILabel!
    var version = "0.0"
    
    override func viewDidLoad() {
        
        version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String

        appVersionLabel.text = "Version: \(version)"
    }
}
