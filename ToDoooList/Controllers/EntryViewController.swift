//
//  ViewController.swift
//  ToDoooList
//
//  Created by Talip on 24.01.2023.
//

import UIKit

class EntryViewController: UIViewController {
    
    
    @IBOutlet weak var logoLabel: UILabel!
    @IBOutlet weak var özellik1Label: UILabel!
    @IBOutlet weak var özellik1ExLabel: UILabel!
    @IBOutlet weak var özellik2Label: UILabel!
    @IBOutlet weak var özellik2ExLabel: UILabel!
    @IBOutlet weak var özellik3Label: UILabel!
    @IBOutlet weak var özellik3ExLabel: UILabel!
    @IBOutlet weak var devamButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadingScreen()
    }
    
    
    @IBAction func devamButtonPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "goToCategory", sender: self)
    }
    

    func loadingScreen() {
        özellik1Label.text = "Yapmak istediklerinizi hızlı ve kolay şekilde oluşturun"
        özellik1ExLabel.text = "Hedeflerinizi, adımlarınızı ve rutinlerinizi girin."
        özellik2Label.text = "Hedef hatırlatıcıları"
        özellik2ExLabel.text = "Hatırlatıcılar ayarlayın ve planlarınızı kaçırmayın."
        özellik3Label.text = "Takvimleyin"
        özellik3ExLabel.text = "Takvime bakarak planlarınıza geniş bir çerçeveden bakın."
        devamButton.layer.cornerRadius = 15
        
    }

}

