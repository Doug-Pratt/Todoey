//
//  ToDoListViewController.swift
//  Todoey
//
//  Created by Douglas Pratt on 2018-05-29.
//  Copyright © 2018 Douglas Pratt. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    let itemArray = ["First thing", "Second Thing", "Third Thing"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
}

