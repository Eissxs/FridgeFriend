//
//  GroceryListView.swift
//  FridgeFriend
//
//  Created by Michael Eissen San Antonio on 5/11/25.
//

import SwiftUI
import CoreData

struct GroceryListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: GroceryItem.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \GroceryItem.name, ascending: true)]
    ) private var groceryItems: FetchedResults<GroceryItem>

    @State private var newItemName: String = ""
    @State private var itemToMove: GroceryItem?
    @State private var showDatePicker = false
    @State private var selectedAddedDate = Date()
    @State private var showMoveConfirmation = false

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        TextField("Add grocery item...", text: $newItemName)
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            .background(Color.white)
                            .cornerRadius(10)
                            .font(.system(size: 16, design: .rounded))

                        Button(action: addItem) {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color("Periwinkle"))
                                .clipShape(Circle())
                                .shadow(radius: 3)
                        }
                        .disabled(newItemName.trimmingCharacters(in: .whitespaces).isEmpty)
                    }
                    .padding(.horizontal)

                    if groceryItems.isEmpty {
                        VStack(spacing: 16) {
                            Image(systemName: "cart")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .foregroundColor(Color("MimiPink"))

                            Text("Your grocery list is empty")
                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                                .foregroundColor(Color("Charcoal"))

                            Text("Add items above and start shopping smarter.")
                                .font(.system(size: 14, design: .rounded))
                                .foregroundColor(Color.gray)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color("Almond"))
                    } else {
                        List {
                            ForEach(groceryItems, id: \.self) { item in
                                HStack {
                                    Text(item.name ?? "")
                                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                                        .foregroundColor(Color("Charcoal"))

                                    Spacer()

                                    Button(action: {
                                        itemToMove = item
                                        selectedAddedDate = Date()
                                        showDatePicker = true
                                    }) {
                                        Label("Purchased", systemImage: "cart.fill.badge.plus")
                                            .font(.caption)
                                            .padding(6)
                                            .background(Color("MimiPink"))
                                            .foregroundColor(.white)
                                            .clipShape(Capsule())
                                            .shadow(radius: 2)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                                .padding(.vertical, 6)
                                .listRowBackground(Color("PaleDogwood"))
                            }
                            .onDelete(perform: deleteItems)
                        }
                        .listStyle(PlainListStyle())
                        .background(Color("Almond"))
                    }
                }
                .navigationTitle("Grocery List")
                .toolbar {
                    EditButton()
                }
                .sheet(isPresented: $showDatePicker) {
                    VStack {
                        Text("Select Date (Expiration Date)")
                            .font(.headline)
                            .padding()

                        DatePicker(
                            "Expiration Date",
                            selection: $selectedAddedDate,
                            displayedComponents: [.date]
                        )
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()

                        HStack {
                            Button("Cancel") {
                                itemToMove = nil
                                showDatePicker = false
                            }
                            .padding()

                            Spacer()

                            Button("Confirm") {
                                if let item = itemToMove {
                                    withAnimation {
                                        moveToInventory(item: item)
                                        showDatePicker = false
                                        showMoveConfirmation = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                            showMoveConfirmation = false
                                        }
                                    }
                                }
                            }
                            .padding()
                            .background(Color("Periwinkle"))
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                        }
                        .padding()
                    }
                    .background(Color("Almond"))
                    .cornerRadius(20)
                    .padding()
                }

                if showMoveConfirmation {
                    VStack {
                        Spacer()
                        Text("Item moved to inventory")
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .padding()
                            .background(Color.black.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .padding(.bottom, 30)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                    .animation(.easeInOut, value: showMoveConfirmation)
                }
            }
        }
    }

    // MARK: - Actions

    private func addItem() {
        let newItem = GroceryItem(context: viewContext)
        newItem.name = newItemName.trimmingCharacters(in: .whitespaces)
        do {
            try viewContext.save()
            newItemName = ""
        } catch {
            print("Failed to add grocery item: \(error.localizedDescription)")
        }
    }

    private func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            viewContext.delete(groceryItems[index])
        }
        do {
            try viewContext.save()
        } catch {
            print("Failed to delete grocery item: \(error.localizedDescription)")
        }
    }

    private func moveToInventory(item: GroceryItem) {
        let fridgeItem = FridgeItem(context: viewContext)
        fridgeItem.name = item.name
        fridgeItem.expiryDate = selectedAddedDate
        fridgeItem.addedDate = selectedAddedDate
        fridgeItem.isLeftover = false

        viewContext.delete(item)

        do {
            try viewContext.save()
        } catch {
            print("Failed to move item to inventory: \(error.localizedDescription)")
        }

        itemToMove = nil
    }
}
