//
//  Fish.swift
//  Compatibiltiy
//
//  Created by Nirajan on 19/1/2023.
//

import Foundation

// MARK: - Fish
struct Fish: Codable {
    let name, slug: String
    let compatibility: [Compatibility]
}

// MARK: - Compatibility
struct Compatibility: Codable {
    let name, slug: String
    let score: Score
}

enum Score: String, Codable {
    case compatible = "compatible"
    case imcompatible = "imcompatible"
    case incompatible = "incompatible"
    case inincompatible = "inincompatible"
    case partialCompatible = "partial compatible"
    case partialPartialCompatible = "partial partial compatible"
}
