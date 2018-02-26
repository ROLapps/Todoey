//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Peter Robinson on 2018-02-26.
//  Copyright © 2018 Peter Robinson. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

     var categoryArray = [Category]()
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var aSelectedCategory = Category()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    //MARK: - TableView Datasource Methods
    
    func loadCategories(with request : NSFetchRequest<Category> = Category.fetchRequest()){
        do {
            categoryArray =  try context.fetch(request)
        }
        catch {
            print("Error fetching Categories: \(error)")
        }
        tableView.reloadData()
    }
    
    func saveContext(){
        if context.hasChanges{
            do {
                try context.save()
            }
            catch {
                print("Error saving Core Data Categories\(error)")
            }
            tableView.reloadData()
        }
    }
    
    //MARK: - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    //    itemArray[indexPath.row].done = !itemArray[indexPath.row].done
    //    saveContext()
        tableView.deselectRow(at: indexPath, animated: true)
        
        aSelectedCategory = categoryArray[indexPath.row]
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToItems" {
            let destinationController = segue.destination as! ToDoListViewController
            destinationController.theSelectedCategory = aSelectedCategory
        }
    }
    
    
    
    
    //MARK: - Data Manipulation Methods
    
   

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let aCategory = categoryArray[indexPath.row]
        cell.textLabel?.text = aCategory.name
        print(categoryArray[indexPath.row])
        return cell
    }
    
    //MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            //what will happen when the user tpas the add item button on the ui alert
            let aNewCategory = Category(context: self.context)
            aNewCategory.name = textField.text!
          //  newItem.done = false
            self.categoryArray.append(aNewCategory)
            self.saveContext()
            //  print("success!!!!!!!")
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category here"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}












/*
override func viewDidLoad() {
    super.viewDidLoad()
    loadCategories()
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem
}
*/



/*
 override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
 
 // Configure the cell...
 
 return cell
 }
 */

/*
 // Override to support conditional editing of the table view.
 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the specified item to be editable.
 return true
 }
 */

/*
 // Override to support editing the table view.
 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
 if editingStyle == .delete {
 // Delete the row from the data source
 tableView.deleteRows(at: [indexPath], with: .fade)
 } else if editingStyle == .insert {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
 
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */

//Ternary Operator
//value = condition ? valueiftrue : valueiffalse
//  cell.accessoryType = item.done == true ? .checkmark : .none
// cell.accessoryType = item.done ? .checkmark : .none
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

/*
 if cell?.accessoryType == .checkmark {
 cell?.accessoryType = .none
 
 
 } else {
 cell?.accessoryType = .checkmark
 }
 */

