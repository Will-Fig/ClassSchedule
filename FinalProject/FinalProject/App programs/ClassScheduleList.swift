//
//  ClassScheduleList.swift
//  FinalProject
//
//  Created by William Figueroa on 5/4/21.
//

import Foundation

struct ClassSched: Codable
{
    var title: String
    var dueDate: Date
    var notes: String?
    
    static func loadClassSched() -> [ClassSched]?
    {
        guard let codedClasses = try? Data(contentsOf: ArchiveURL)
        else {return nil}
        
        let propertyListDecoder = PropertyListDecoder()
        
        return try? propertyListDecoder.decode(Array<ClassSched>.self, from: codedClasses)
    }
    
    static func loadSampleClassSched() -> [ClassSched]
    {
        let class1 = ClassSched(title: "Class 1", dueDate: Date(), notes: "Notes 1")
        let class2 = ClassSched(title: "Class 2", dueDate: Date(), notes: "Notes 2")
        let class3 = ClassSched(title: "Class 3", dueDate: Date(), notes: "Notes 3")
        
        return[class1, class2, class3]
    }
    
    static func saveClasses(_ classes: [ClassSched])
    {
        let propertyListEncoder = PropertyListEncoder()
        let codedClasses = try? propertyListEncoder.encode(classes)
        try? codedClasses?.write(to: ArchiveURL, options: .noFileProtection)
    }
    
    static let dueDateFormatter: DateFormatter =
        {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .short
            return formatter
        }()
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("classes").appendingPathExtension("plist")
    
}
