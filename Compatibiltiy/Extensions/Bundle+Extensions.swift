//
//  Bundle+Extensions.swift
//  Compatibiltiy
//
//  Created by Nirajan on 19/1/2023.
//

import Foundation

enum ResoucesFile: String {
    case compatibility = "compatibility.json"
}

extension Bundle {
    /// to decode from the files
    /// - Parameter fileName: stored in the ResourceFile
    /// - Returns: returns decoded model
    func decode<T: Codable>(_ fileName: ResoucesFile) -> T {
        let fileName = fileName.rawValue
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            fatalError("Failed to locate \(fileName) in the bundle.")
        }
        
        guard let data = try? Data(contentsOf: fileURL) else {
            fatalError("Failed to load \(fileName) from the bundle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let decoded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(fileName) from the bundle.")
        }
        
        return decoded
    }
}
