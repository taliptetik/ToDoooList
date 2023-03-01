//
//  ReminderViewController.swift
//  ToDoooList
//
//  Created by Talip on 24.02.2023.
//

import UserNotifications
import UIKit
import CoreData
import SwipeCellKit

class ReminderViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    

    var models = [Reminder]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80.0
        
        reminderLoad()
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
       
        guard let vc = storyboard?.instantiateViewController(identifier: "add") as? AddReminderViewController else {
            return
        }

        vc.title = "Ekle"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = { title, body, date in
            DispatchQueue.main.async {
                if let ReminderViewController = self.navigationController?.viewControllers[1] {
                self.navigationController?.popToViewController(ReminderViewController, animated: true)
                }
                
                let new = Reminder(context: self.context)
                new.title = title
                new.date = date
                new.identifier = "id_\(title)"
                self.models.append(new)
                self.reminderSaving()

                let content = UNMutableNotificationContent()
                content.title = title
                content.sound = .default
                content.body = body

                let targetDate = date
                let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second],
                                                                                                          from: targetDate),
                                                            repeats: false)

                let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                    if error != nil {
                        print("something went wrong")
                    }
                })
                    
            }
        }
        navigationController?.pushViewController(vc, animated: true)

}
    
    @IBAction func testButtonPressed(_ sender: UIBarButtonItem) {
        
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { success, error in
            if success {
                // schedule test
                self.scheduleTest()
            }
            else if error != nil {
                print("error occurred")
            }
        })
    }


    func scheduleTest() {
        let content = UNMutableNotificationContent()
        content.title = "Hatırlatıcı Deneme"
        content.sound = .default
        content.body = "Bildirim denemesi için gerekli içerik. "

        let targetDate = Date().addingTimeInterval(10)
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second],
                                                                                                  from: targetDate),
                                                    repeats: false)

        let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
                print("something went wrong")
            }
        })
    }

//MARK: - Save and Load Methods
    
    func reminderSaving() {
        
        do {
            try context.save()
        } catch {
            print("Error while saving reminder")
        }
        tableView.reloadData()
    }

    func reminderLoad() {
        
        let request: NSFetchRequest<Reminder> = Reminder.fetchRequest()
        
        do {
            models = try context.fetch(request)
        } catch {
            print("Error while loading reminder \(error)")
        }
        tableView.reloadData()
    }
}

extension ReminderViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}


extension ReminderViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reminderCell", for: indexPath) as! SwipeTableViewCell
        cell.textLabel?.text = models[indexPath.row].title
        let date = models[indexPath.row].date
        cell.delegate = self
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM, dd, YYYY"
        cell.detailTextLabel?.text = formatter.string(from: date!)

        cell.textLabel?.font = UIFont(name: "Arial", size: 25)
        cell.detailTextLabel?.font = UIFont(name: "Arial", size: 22)
        return cell
    }

}

//MARK: - SwipeTableView Cell Methods

extension ReminderViewController: SwipeTableViewCellDelegate {
    
        func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
            
            guard orientation == .right else { return nil }
    
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
    
                self.context.delete(self.models[indexPath.row])
                self.models.remove(at: indexPath.row)
            }
    
            deleteAction.image = UIImage(named: "delete-icon")
    
            return [deleteAction]
        }
    
        func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
            var options = SwipeOptions()
            options.expansionStyle = .destructive
            return options
        }
}



