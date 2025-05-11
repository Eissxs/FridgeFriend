//
//  InventoryView.swift
//  FridgeFriend
//
//  Created by Michael Eissen San Antonio on 5/10/25.
//

import SwiftUI
import CoreData

struct InventoryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: FridgeItem.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FridgeItem.expiryDate, ascending: true)]
    ) private var items: FetchedResults<FridgeItem>

    @State private var lastDeletedItem: FridgeItem?
    @State private var showUndoSnackbar = false

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()

    var body: some View {
        ZStack {
            NavigationView {
                if items.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "shippingbox")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(Color("MimiPink"))

                        Text("No Items in Inventory")
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .foregroundColor(Color("Charcoal"))

                        Text("Add items from your grocery list or scan them to get started.")
                            .font(.system(size: 14, design: .rounded))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color("Almond"))
                } else {
                    List {
                        ForEach(items, id: \.self) { item in
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.name ?? "Unnamed")
                                        .font(.system(size: 17, weight: .bold, design: .rounded))
                                        .foregroundColor(Color("Charcoal"))

                                    Text("Expires: \(item.expiryDate ?? Date(), formatter: dateFormatter)")
                                        .font(.system(size: 15, weight: .light, design: .rounded))
                                        .foregroundColor(.gray)

                                    if item.isLeftover {
                                        Text("Leftover")
                                            .font(.system(size: 14, weight: .regular, design: .rounded))
                                            .foregroundColor(Color("Charcoal"))
                                            .padding(6)
                                            .background(Color("Almond"))
                                            .cornerRadius(8)
                                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color("LightBlue"), lineWidth: 1))
                                    }
                                }
                                Spacer()
                                ExpiryStatusView(date: item.expiryDate)
                            }
                            .padding(.vertical, 8)
                            .listRowBackground(Color("PaleDogwood"))
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .navigationTitle("Inventory")
                    .toolbar {
                        EditButton()
                    }
                    .background(Color("Almond"))
                }
            }

            if showUndoSnackbar {
                VStack {
                    Spacer()
                    HStack {
                        Text("Item deleted")
                        Spacer()
                        Button("Undo") {
                            undoDelete()
                        }
                        .padding(.horizontal)
                    }
                    .padding()
                    .background(Color.black.opacity(0.85))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut, value: showUndoSnackbar)
                }
            }
        }
    }

    // MARK: - Helper Views & Methods

    private func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let item = items[index]
            lastDeletedItem = item
            viewContext.delete(item)
        }

        do {
            try viewContext.save()
            withAnimation {
                showUndoSnackbar = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                withAnimation {
                    showUndoSnackbar = false
                }
            }
        } catch {
            print("Failed to delete item: \(error.localizedDescription)")
        }
    }

    private func undoDelete() {
        if let item = lastDeletedItem {
            viewContext.insert(item)
            do {
                try viewContext.save()
            } catch {
                print("Failed to undo delete: \(error.localizedDescription)")
            }
            showUndoSnackbar = false
        }
    }
}

// MARK: - Expiry Status View

struct ExpiryStatusView: View {
    let date: Date?

    var body: some View {
        Group {
            if let status = statusInfo {
                HStack(spacing: 6) {
                    Image(systemName: status.icon)
                    Text(status.label)
                }
                .font(.caption)
                .padding(6)
                .background(Color(status.color))
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
        }
    }

    private var statusInfo: (label: String, icon: String, color: String)? {
        guard let expiryDate = date else { return nil }
        let now = Date()
        let calendar = Calendar.current

        if expiryDate < now {
            return ("Expired", "xmark.octagon.fill", "MimiPink")
        } else if let soon = calendar.date(byAdding: .day, value: 2, to: now),
                  expiryDate <= soon {
            return ("Expiring Soon", "exclamationmark.triangle.fill", "Periwinkle")
        } else {
            return ("Safe", "checkmark.seal.fill", "LightBlue")
        }
    }
}
