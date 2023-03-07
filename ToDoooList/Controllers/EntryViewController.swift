//
//  ViewController.swift
//  ToDoooList
//
//  Created by Talip on 24.01.2023.
//

import UIKit

class EntryViewController: UIViewController {
    
    
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var reminderButton: UIButton!
    @IBOutlet weak var calendarButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadingScreen()
    }
    
    @IBAction func listButtonPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "goToCategory", sender: self)
    }
    
    @IBAction func reminderButtonPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "goToReminder", sender: self)
    }
    
    @IBAction func calendarButtonPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "goToCalendar", sender: self)
    }


    func loadingScreen() {
        listButton.titleLabel?.text = "Yapmak istediklerinizi hızlı ve kolay şekilde oluşturun"
        listButton.subtitleLabel?.text = "Hedeflerinizi, adımlarınızı ve rutinlerinizi girin."
        reminderButton.titleLabel?.text = "Hedef hatırlatıcıları"
        reminderButton.subtitleLabel?.text = "Hatırlatıcılar ayarlayın ve planlarınızı kaçırmayın."
        calendarButton.titleLabel?.text = "Takvimleyin"
        calendarButton.subtitleLabel?.text = "Takvime bakarak planlarınıza geniş bir çerçeveden bakın."
        
        listButton.layer.cornerRadius = 20
        reminderButton.layer.cornerRadius = 20
        calendarButton.layer.cornerRadius = 20
    }

}

