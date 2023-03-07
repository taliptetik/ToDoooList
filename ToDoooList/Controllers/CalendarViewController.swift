//
//  ViewController.swift
//  ToDoooList
//
//  Created by Talip on 6.03.2023.
//

import UIKit

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var reminderButton: UIButton!
    @IBOutlet weak var listButton: UIButton!
    
    
    
    var selectedDate = Date()
    var totalSquares = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reminderButton.layer.cornerRadius = 20
        listButton.layer.cornerRadius = 20
        
        collectionView.dataSource = self
        
        setCellView()
        setMonthView()
        
    }
    
    func setCellView() {
        
        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.height - 2) / 8
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
        
    }
    
    func setMonthView() {
        
        totalSquares.removeAll()
        
        let daysInMonth = CalendarSupport().daysOfMonth(date: selectedDate)
        let firstDayOfMonth = CalendarSupport().firstOfMonth(date: selectedDate)
        let startingSpaces = CalendarSupport().weekDay(date: firstDayOfMonth)
        
        var count: Int = 1
        
        while(count <= 42) {
            if (count <= startingSpaces || count - startingSpaces > daysInMonth) {
                
                totalSquares.append("")
            } else {
                totalSquares.append(String(count - startingSpaces))
            }
            count += 1
        }
        
        monthLabel.text = CalendarSupport().monthString(date: selectedDate) + " " + CalendarSupport().yearString(date: selectedDate)
        collectionView.reloadData()
    }
    
    
    
    
    @IBAction func previousMonthButton(_ sender: Any) {
        
        selectedDate = CalendarSupport().minusMonth(date: selectedDate)
        setMonthView()
    }
    
    @IBAction func nextMonthButton(_ sender: Any) {
        
        selectedDate = CalendarSupport().plusMonth(date: selectedDate)
        setMonthView()
    }
    
    @IBAction func goReminderButton(_ sender: Any) {
        
        performSegue(withIdentifier: "calenToRemind", sender: self)
    }
    
    @IBAction func goListButton(_ sender: Any) {
        
        performSegue(withIdentifier: "calenToList", sender: self)
    }
    
    
    override var shouldAutorotate: Bool {
        
        return false
    }
    

}

extension CalendarViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        totalSquares.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as! CalendarCell
        
        cell.dayOfMonth.text = totalSquares[indexPath.row]
        return cell
    }
}
