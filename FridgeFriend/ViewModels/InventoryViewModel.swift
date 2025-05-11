//
//  InventoryViewModel.swift
//  FridgeFriend
//
//  Created by Michael Eissen San Antonio on 5/10/25.
//

import Foundation
import CoreData
import SwiftUI

class InventoryViewModel: ObservableObject {
    @Published var items: [FridgeItem] = []

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
        fetchItems()
    }

    func fetchItems() {
        let request: NSFetchRequest<FridgeItem> = FridgeItem.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \FridgeItem.expiryDate, ascending: true)]
        do {
            items = try context.fetch(request)
        } catch {
            print("Error fetching items: \(error)")
        }
    }

    func deleteItem(_ item: FridgeItem) {
        context.delete(item)
        saveContext()
        fetchItems()
    }

    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
