//
//  DashboardView.swift
//  FridgeFriend
//
//  Created by Michael Eissen San Antonio on 5/10/25.
//

import SwiftUI
import CoreData

struct DashboardView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: FridgeItem.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FridgeItem.addedDate, ascending: false)]
    ) private var items: FetchedResults<FridgeItem>

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Welcome to FridgeFriend")
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundColor(Color("Charcoal"))

                        Text("Keep track of your food and reduce waste.")
                            .font(.system(size: 17, weight: .regular, design: .rounded))
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color("PaleDogwood"))
                    .cornerRadius(16)
                    .shadow(radius: 2)

                    VStack(spacing: 16) {
                        Text("Inventory Overview")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(Color("Charcoal"))

                        HStack {
                            VStack {
                                Text("Total Items")
                                    .font(.system(size: 16, weight: .regular, design: .rounded))
                                    .foregroundColor(.gray)
                                Text("\(items.count)")
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .foregroundColor(Color("Charcoal"))
                            }

                            Spacer()

                            VStack {
                                Text("Expired")
                                    .font(.system(size: 16, weight: .regular, design: .rounded))
                                    .foregroundColor(.gray)
                                Text("\(expiredItemsCount())")
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .foregroundColor(Color("Charcoal"))
                            }

                            Spacer()

                            VStack {
                                Text("Leftovers")
                                    .font(.system(size: 16, weight: .regular, design: .rounded))
                                    .foregroundColor(.gray)
                                Text("\(leftoversItemsCount())")
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .foregroundColor(Color("Charcoal"))
                            }
                        }
                        .padding()
                        .background(Color("Almond"))
                        .cornerRadius(16)
                        .shadow(radius: 2)
                    }

                    VStack(spacing: 12) {
                        NavigationLink(destination: AddItemView()) {
                            Text("Add Item")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color("Periwinkle"))
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .font(.system(size: 17, weight: .bold, design: .rounded))
                        }

                        NavigationLink(destination: InventoryView()) {
                            Text("View Inventory")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color("MimiPink"))
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .font(.system(size: 17, weight: .bold, design: .rounded))
                        }

                        NavigationLink(destination: RecipeSuggestionsView()) {
                            Text("Recipe Suggestions")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color("LightBlue"))
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .font(.system(size: 17, weight: .bold, design: .rounded))
                        }

                        NavigationLink(destination: GroceryListView()) {
                            Text("Grocery List")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color("PaleDogwood"))
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .font(.system(size: 17, weight: .bold, design: .rounded))
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("FridgeFriend")
            .background(Color("Almond"))
        }
    }

    private func expiredItemsCount() -> Int {
        let now = Date()
        return items.filter { $0.expiryDate ?? now < now }.count
    }

    private func leftoversItemsCount() -> Int {
        return items.filter { $0.isLeftover }.count
    }
}
