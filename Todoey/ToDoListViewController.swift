//
//  ViewController.swift
//  Todoey
//
//  Created by Peter Robinson on 2018-02-24.
//  Copyright © 2018 Peter Robinson. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
     //   let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        
        cell.textLabel?.text = itemArray[indexPath.row]
        print(itemArray[indexPath.row])
        
        
        return cell
        
    }
    
    //MARK - Tableview Delegate Methods
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        if cell?.accessoryType == .checkmark {
            cell?.accessoryType = .none
            
            
        } else {
            cell?.accessoryType = .checkmark
        }
        
    }
    
   
    @IBAction func addButtonPredded(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen when the user tpas the add item button on the ui alert
            
          self.itemArray.append(textField.text!)
          self.tableView.reloadData()
            
            
            
            //  print("success!!!!!!!")
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item here"
            textField = alertTextField
        }
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
        
        
    }
    
    

}

