//
//  Recipe.swift
//  FridgeFriend
//
//  Created by Michael Eissen San Antonio on 5/10/25.
//

import Foundation

struct Recipe: Identifiable {
    let id = UUID()
    let title: String
    let ingredients: [String]
    let instructions: String
}
