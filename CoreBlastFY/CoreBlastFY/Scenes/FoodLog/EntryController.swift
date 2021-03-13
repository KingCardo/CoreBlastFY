//
//  EntryController.swift
//  Journal
//
//  Created by Riccardo Washington on 5/22/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import Foundation

class EntryController {
    
    static let shared = EntryController()
    
    var entries: [Entry] = [] {
        didSet {
           entries = sortEntries(entries: entries)
        }
    }

    func sortEntries(entries: [Entry]) -> [Entry]{
        return entries.sorted(by: { (a, b) -> Bool in
            return a.timeStamp > b.timeStamp
        })
    }
    
    var entriesUpdateHandler: (() -> ())?
    
    func createEntry(title: String, bodyText: String, entryType: Entry.EntryType) {
        let entry = Entry(title: title, body: bodyText, timeStamp: Date(), entryType: entryType)
        self.entries.append(entry)
        saveToFile()
    }
    
    func updateEntry(entry: Entry, title: String?, bodyText: String?, entryType: Entry.EntryType) {
        if let title = title, let bodyText = bodyText {
            if let index = entries.firstIndex(of: entry) {
                self.entries[index].title = title
                self.entries[index].body = bodyText
                self.entries[index].timeStamp = Date()
                self.entries[index].entryType = entryType
                saveToFile()
            }
        }
    }
    
    func deleteEntry(entry: Entry) {
        if let index = entries.firstIndex(of: entry) {
            self.entries.remove(at: index)
            saveToFile()
        }
        
    }
    
    //TO DO: - Refactor - Persistence
    
    func saveToFile() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("Entries").appendingPathExtension("json")
        
        let jsonEncoder = JSONEncoder()
        
        do {
            let encodedData = try jsonEncoder.encode(entries)
            try encodedData.write(to: archiveURL)
        } catch let error {
            print(error)
        }
        
    }
    
    func loadFromFile() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("Entries").appendingPathExtension("json")
        
        let jsonDecoder = JSONDecoder()
        guard let decodedData = try? Data(contentsOf: archiveURL) else { return }
       
        do {
            self.entries = try jsonDecoder.decode([Entry].self, from: decodedData)
           
        } catch let error {
            print(error)
        }
    }
}

