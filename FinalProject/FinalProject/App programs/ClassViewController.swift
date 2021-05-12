//
//  ClassViewController.swift
//  FinalProject
//
//  Created by William Figueroa on 5/5/21.
//

import UIKit

class ClassViewController: UITableViewController
{
    var cSchedule: ClassSched?
    var isPickerHidden = true
    let dateLabelIndexPath = IndexPath(row: 0, section: 1)
    let datePickerIndexPath = IndexPath(row: 1, section: 1)
    let notesTextViewIndexPath = IndexPath(row: 0, section: 2)
    
    let normalCellHeight: CGFloat = 44
    let largeCellHeight: CGFloat = 200
    
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var dueDateLabel: UILabel!
    
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    
    @IBOutlet weak var notesTextView: UITextView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func textEditingChanged(_ sender: UITextField)
    {
        updateSaveButtonState()
    }
    
    @IBAction func returnPressed(_ sender: UITextField)
    {
        titleTextField.resignFirstResponder()
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker)
    {
        updateDueDateLabel(date: dueDatePickerView.date)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let cSchedule = cSchedule
        {
            navigationItem.title = "My Class Schedule"
            titleTextField.text = cSchedule.title
            dueDatePickerView.date = cSchedule.dueDate
            notesTextView.text = cSchedule.notes
        }
        
        else
        {
        dueDatePickerView.date = Date().addingTimeInterval(24*60*60)
        }
        
        updateDueDateLabel(date: dueDatePickerView.date)
        updateSaveButtonState()
    }
    
    func updateDueDateLabel(date: Date)
    {
        dueDateLabel.text = ClassSched.dueDateFormatter.string(from: date)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        switch indexPath
        {
            case datePickerIndexPath:
                return isPickerHidden ? 0:
                    dueDatePickerView.frame.height
        
            case notesTextViewIndexPath:
                return largeCellHeight
                
            default:
                return normalCellHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath == dateLabelIndexPath
        {
            isPickerHidden = !isPickerHidden
            dueDateLabel.textColor = isPickerHidden ? .black:
                tableView.tintColor
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    func updateSaveButtonState()
    {
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else {return}
        
        let title = titleTextField.text!
        let dueDate = dueDatePickerView.date
        let notes = notesTextView.text
        
        cSchedule = ClassSched(title: title, dueDate: dueDate, notes: notes)
    }
}
