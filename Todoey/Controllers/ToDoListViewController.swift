//
//  ToDoListViewController.swift
//  Todoey
//
//  Created by Douglas Pratt on 2018-05-29.
//  Copyright © 2018 Douglas Pratt. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [ToDoItem]()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = ToDoItem()
        newItem.title = "First Item"
        itemArray.append(newItem)
        
        let newItem2 = ToDoItem()
        newItem2.title = "Second Item"
        itemArray.append(newItem2)
        
        let newItem3 = ToDoItem()
        newItem3.title = "Third Item"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [ToDoItem] { // checks if item can be retrieved and then assigns if yes
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
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        // Ternary operator
        // value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        
        return cell
        
    }
    
    //MARK: - Table view delegate method to identify which row was selected
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        
        // Put a check mark or remove it if user touches on cell again

        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        
        tableView.deselectRow(at: indexPath, animated: true) // row is grey when selected. This deselects it and returns it to white
        
    }
    
    //MARK: - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField() // initialize blank text field
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen when the user clicks on "Add Item" alert
            
            if textField.text != "" {
                let newItem = ToDoItem()
                newItem.title = textField.text!
                
                self.itemArray.append(newItem)
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

