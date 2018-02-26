//
//  ViewController.swift
//  Todoey
//
//  Created by Peter Robinson on 2018-02-24.
//  Copyright © 2018 Peter Robinson. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {

    var itemArray = [Item]()
    var theSelectedCategory : Category?{
        didSet{
           loadItems()
        }
    }
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        //Ternary Operator
        //value = condition ? valueiftrue : valueiffalse
      //  cell.accessoryType = item.done == true ? .checkmark : .none
        cell.accessoryType = item.done ? .checkmark : .none
        print(itemArray[indexPath.row])
        return cell
    }
    //MARK - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveContext()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPredded(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen when the user tpas the add item button on the ui alert
          let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.theSelectedCategory
          self.itemArray.append(newItem)
          self.saveContext()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item here"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveContext(){
        if context.hasChanges{
        do {
           try context.save()
        }
        catch {
            print("Error saving Core Data \(error)")
        }
        tableView.reloadData()
        }
    }
    
    func loadItems(with request : NSFetchRequest<Item> = Item.fetchRequest(), predicate : NSPredicate? = nil){

        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", theSelectedCategory!.name!)
        if let additionalPRedicate = predicate{
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [additionalPRedicate, categoryPredicate])
        } else {
            request.predicate = categoryPredicate
        }
         do {
       itemArray =  try context.fetch(request)
        }
        catch {
         print("Error fetchinng \(error)")
        }
        tableView.reloadData()
    }
}

//MARK: - Search Bar Methods
extension ToDoListViewController : UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        loadItems(with: request, predicate: predicate)
    }
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
          }
        }
    }
    
    
//}
//   let defaults = UserDefaults.standard

//   let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")


//      self.defaults.set(self.itemArray, forKey: "TodoListArray")


//  print(dataFilePath)

//  searchBar.delegate = self

//    loadItems()
/*
 if let items = defaults.array(forKey: "TodoListArray") as? [String]{
 
 itemArray = items
 
 }
 */

// Do any additional setup after loading the view, typically from a nib.



/*
 if item.done == false {
 cell.accessoryType = .none
 } else {
 cell.accessoryType = .checkmark
 
 }
 
 
 if itemArray[indexPath.row].done == false {
 cell.accessoryType = .none
 
 } else {
 cell.accessoryType = .checkmark
 
 }
 */





//    context.delete(itemArray[indexPath.row])
//     itemArray.remove(at: indexPath.row)

//   saveContext()


//    itemArray[indexPath.row].setValue("Completed", forKey: "title")


/*
 if cell?.accessoryType == .checkmark {
 cell?.accessoryType = .none
 
 
 } else {
 cell?.accessoryType = .checkmark
 }
 */
