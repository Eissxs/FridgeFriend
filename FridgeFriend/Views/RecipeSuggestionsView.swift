//
//  RecipeSuggestionsView.swift
//  FridgeFriend
//
//  Created by Michael Eissen San Antonio on 5/10/25.
//

import SwiftUI
import CoreData

struct RecipeSuggestionsView: View {
    @FetchRequest(
        entity: FridgeItem.entity(),
        sortDescriptors: []
    ) var inventory: FetchedResults<FridgeItem>

    var body: some View {
        NavigationView {
            ScrollView {
                if suggestedRecipes.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "text.book.closed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(Color("MimiPink"))

                        Text("No Recipes Found")
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .foregroundColor(Color("Charcoal"))

                        Text("Try adding more items to your inventory to get recipe ideas.")
                            .font(.system(size: 14, design: .rounded))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.top, 100)
                } else {
                    LazyVStack(spacing: 16) {
                        ForEach(suggestedRecipes, id: \.id) { recipe in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(recipe.title)
                                    .font(.system(size: 22, weight: .bold, design: .rounded))
                                    .foregroundColor(Color("Charcoal"))

                                Text("Ingredients: \(recipe.ingredients.joined(separator: ", "))")
                                    .font(.system(size: 15, weight: .regular, design: .rounded))

                                Text("Instructions: \(recipe.instructions)")
                                    .font(.system(size: 15, weight: .light, design: .rounded))
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color("PaleDogwood"))
                            .cornerRadius(16)
                            .shadow(radius: 4)
                        }
                    }
                    .padding()
                }
            }
            .background(Color("Almond"))
            .navigationTitle("Recipe Ideas")
        }
    }

    private var suggestedRecipes: [Recipe] {
        let inventoryNames = inventory.map { ($0.name ?? "").lowercased() }

        return allRecipes.filter { recipe in
            recipe.ingredients.allSatisfy { ingredient in
                inventoryNames.contains(where: { $0.contains(ingredient.lowercased()) })
            }
        }
    }

    private var allRecipes: [Recipe] {
        [
            Recipe(
                title: "Tomato Omelette",
                ingredients: ["eggs", "tomato"],
                instructions: "Whisk eggs, add diced tomatoes, and cook in pan."
            ),
            Recipe(
                title: "Grilled Cheese",
                ingredients: ["bread", "cheese"],
                instructions: "Place cheese between bread slices and grill until golden."
            ),
            Recipe(
                title: "Fruit Salad",
                ingredients: ["apple", "banana", "orange"],
                instructions: "Chop all fruits and mix in a bowl."
            )
        ]
    }
}
