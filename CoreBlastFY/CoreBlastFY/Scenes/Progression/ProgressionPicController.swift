//
//  ProgressionPicController.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 12/8/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import Foundation

class ProgressionPicController {
    
    static let shared = ProgressionPicController()
    
    var progressionPics: [ProgressionPic] = [] {
        didSet {
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name("ProgressPicNotification"), object: self)
            }
        }
    }
    
    var noProgressionPics: Bool {
        return progressionPics.count == 0 ? true : false
    }
    
    var sortedPics: [ProgressionPic] {
        return self.progressionPics.sorted(by: { (a, b) -> Bool in
            return a.timestamp > b.timestamp
        })
    }
    
    func deletePic(progressionPic: ProgressionPic) {
        
        if let index = progressionPics.firstIndex(of: progressionPic) {
            progressionPics.remove(at: index)
            saveToFile()
        }
    }
    
    //MARK: Local Persistence for Progression Pics
    
    func saveToFile() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("ProgressionPics").appendingPathExtension("json")
        
        let jsonEncoder = JSONEncoder()
        
        do {
            let encodedData = try jsonEncoder.encode(progressionPics)
            try encodedData.write(to: archiveURL)
        } catch let error {
            print(error)
        }
        
    }
    
    func loadFromFile() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("ProgressionPics").appendingPathExtension("json")
        
        let jsonDecoder = JSONDecoder()
        guard let decodedData = try? Data(contentsOf: archiveURL) else { return }
        print(decodedData)
        do {
            self.progressionPics = try jsonDecoder.decode([ProgressionPic].self, from: decodedData)
            print(progressionPics.count)
        } catch let error {
            print(error)
        }
    }
}
