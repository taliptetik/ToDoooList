//
//  CategoryViewController.swift
//  ToDoooList
//
//  Created by Talip on 20.02.2023.
//

import UIKit
import CoreData
import SwipeCellKit

class CategoryViewController: UITableViewController {

    var categoryListArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadCategory()
        tableView.rowHeight = 80.0
    }
    
    //MARK: - Category Add Button Methods

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Yeni başlık ekle", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Öğe ekle", style: .default) { action in
            
            let newCatagory = Category(context: self.context)
            newCatagory.name = textField.text!
            
            self.categoryListArray.append(newCatagory)
            self.saveCategory()
        }
        
        alert.addAction(action)
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Yeni kategori oluştur "
            textField = alertTextField
        }
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Category TableView Datasource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryListArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! SwipeTableViewCell
        let category = categoryListArray[indexPath.row]
        cell.textLabel?.text = category.name
        cell.delegate = self
        
        return cell
    }
    
    

    
//MARK: - Category TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destionationVC = segue.destination as! SecondViewController
        
        if let indextPath = tableView.indexPathForSelectedRow {
            destionationVC.selectedCategory = categoryListArray[indextPath.row]
        }
    }
    
//MARK: - Category Model Manipulation Methods
    
    func saveCategory() {
        
        do {
            try context.save()
        } catch {
            print("Error encoding category array \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategory() {
        
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            categoryListArray = try context.fetch(request)
        } catch {
            print("Error fatching data from context \(error)")
        }
        tableView.reloadData()
    }
    
}

//MARK: - SwipeTableView Cell Methods

extension CategoryViewController: SwipeTableViewCellDelegate {
    
        func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
            
            guard orientation == .right else { return nil }
    
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
    
                self.context.delete(self.categoryListArray[indexPath.row])
                self.categoryListArray.remove(at: indexPath.row)
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


