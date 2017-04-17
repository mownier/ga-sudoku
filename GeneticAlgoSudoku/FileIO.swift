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
    
    func write(_ info: [String: Any])
}

public protocol FileReaderProtocol {
    
    func read(from filePath: String, completion: ([String: Any]) -> Void)
}

public struct FileWriter: FileWriterProtocol {
    
    public func write(_ info: [String : Any]) {
        let fileManager = FileManager.default
        var isDirectory: ObjCBool = false
        do {
            if !fileManager.fileExists(atPath: "output", isDirectory: &isDirectory) && !isDirectory.boolValue {
                try fileManager.createDirectory(atPath: "output", withIntermediateDirectories: false, attributes: nil)
            }
            let timestamp = Date().timeIntervalSince1970
            let data = try JSONSerialization.data(withJSONObject: info, options: .prettyPrinted)
            if !fileManager.createFile(atPath: "output/\(timestamp).json", contents: data, attributes: nil) {
                print("Could not create JSON file")
            }
            
        } catch {
            print("Failed to write")
        }
    }
}
