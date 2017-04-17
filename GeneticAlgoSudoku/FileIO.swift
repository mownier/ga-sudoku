//
//  FileIO.swift
//  GeneticAlgoSudoku
//
//  Created by Mounir Ybanez on 17/04/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Foundation

public protocol FileOutputProtocol {
    
    var fileOutputInfo: [String: Any] { get }
}

public protocol FileWriterProtocol {
    
    func write(_ info: [String: Any], file: String)
}

public protocol FileReaderProtocol {
    
    func read(from filePath: String) -> [String: Any]?
}

public struct FileWriter: FileWriterProtocol {
    
    public func write(_ info: [String : Any], file: String) {
        let fileManager = FileManager.default
        var isDirectory: ObjCBool = false
        do {
            if !fileManager.fileExists(atPath: "output", isDirectory: &isDirectory) && !isDirectory.boolValue {
                try fileManager.createDirectory(atPath: "output", withIntermediateDirectories: false, attributes: nil)
            }
            let data = try JSONSerialization.data(withJSONObject: info, options: .prettyPrinted)
            if !fileManager.createFile(atPath: "output/\(file)", contents: data, attributes: nil) {
                print("Could not create file")
            }
            
        } catch {
            print("Failed to write")
        }
    }
}

public struct FileReader: FileReaderProtocol {
    
    public func read(from filePath: String) -> [String : Any]? {
        let fileManager = FileManager.default
        
        guard fileManager.fileExists(atPath: filePath),
            let data = fileManager.contents(atPath: filePath) else {
            return nil
        }
        
        do {
            return try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
        } catch {
            return nil
        }
    }
}
