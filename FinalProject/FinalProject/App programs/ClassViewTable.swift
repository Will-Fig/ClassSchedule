//
//  ClassViewTable.swift
//  FinalProject
//
//  Created by William Figueroa on 5/5/21.
//

import UIKit

class ClassViewTable: UITableViewController
{
    var classes = [ClassSched]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let savedClasses = ClassSched.loadClassSched()
        {
            classes = savedClasses
        }
        
        else
        {
            classes = ClassSched.loadSampleClassSched()
        }
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return classes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClassCellIdentifier", for: indexPath)
        
        let cSchedule = classes[indexPath.row]
        cell.textLabel?.text = cSchedule.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            classes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            ClassSched.saveClasses(classes)
        }
    }
    
    @IBAction func unwindClassList(segue: UIStoryboardSegue)
    {
        guard segue.identifier == "saveUnwind" else {return}
        
        let sourceViewController = segue.source as! ClassViewController
        
        if let cSchedule = sourceViewController.cSchedule
        {
            if let selectedIndexPath = tableView.indexPathForSelectedRow
            {
                classes[selectedIndexPath.row] = cSchedule
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            
            else
            {
            let newIndexPath = IndexPath(row: classes.count, section: 0)
            
            classes.append(cSchedule)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        
        ClassSched.saveClasses(classes)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "EditClass",
        let navController = segue.destination as? UINavigationController,
        let ClassViewController = navController.topViewController as? ClassViewController
        {
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedClass = classes[indexPath.row]
            
            ClassViewController.cSchedule = selectedClass
        }
           
    }
}
