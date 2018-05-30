//
//  ToDoListViewController.swift
//  Todoey
//
//  Created by Douglas Pratt on 2018-05-29.
//  Copyright © 2018 Douglas Pratt. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = ["First thing", "Second Thing", "Third Thing"]
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [String] { // checks if item can be retrieved and then assigns
            itemArray = items
        }
        
    }

   
    //MARK: - Tableview methods here
    
    // How many rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    // puts contents in cells
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
        
    }
    
    //MARK: - Table view delegate method to identify which row was selected
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        
        // Put a check mark or remove it if user touches on cell again
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
             tableView.cellForRow(at: indexPath)?.accessoryType = .none // removes accessory to the cell of a checkmark
        } else {
             tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark // adds accessory to the cell of a checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true) // row is grey when selected. This deselects it and returns it to white
        
    }
    
    //MARK: - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField() // initialize blank text field
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen when the user clicks on "Add Item" alert
            
            if textField.text != "" {
                    self.itemArray.append(textField.text!)
                    self.tableView.reloadData() // reloads tableview
                self.defaults.set(self.itemArray, forKey: "ToDoListArray") // stores list in persistent storage
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item" // shows in field
            textField = alertTextField
            
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
}

