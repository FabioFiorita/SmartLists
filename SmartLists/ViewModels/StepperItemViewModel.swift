//
//  ObjectViewModel.swift
//  SmartLists
//
//  Created by Fabio Fiorita on 08/08/22.
//

import Foundation
import CoreData

final class StepperItemViewModel: ObservableObject {
    @Published var items: [StepperItem] = []
    private var viewContext: NSManagedObjectContext
    
    public init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }
    
    func fetchItems() {
        let request = NSFetchRequest<StepperItem>(entityName: "StepperItem")
        do {
            items = try viewContext.fetch(request)
        } catch {
            print("Error Fetching. \(error)")
        }
    }
    
    func saveData() {
        do {
            try viewContext.save()
            fetchItems()
        } catch {
            print("Error saving. \(error)")
        }
    }
    
    func addItem(content: String) -> StepperItem {
        let newItem = StepperItem(context: viewContext)
        newItem.id = UUID()
        newItem.content = content
        newItem.amount = 0
        saveData()
        return newItem
    }
    
    func increaseAmount(item: StepperItem) -> StepperItem {
        if item.amount <= 100 {
            item.amount = item.amount + 1
        } else {
            item.amount = 100
        }
        saveData()
        return item
    }
    
    func decreaseAmount(item: StepperItem) -> StepperItem {
        if item.amount > 0 {
            item.amount = item.amount - 1
        } else {
            item.amount = 0
        }
        saveData()
        return item
    }
    
    func deleteItem(item: StepperItem) {
        viewContext.delete(item)
        saveData()
    }
    
    func updateItem(item: StepperItem) -> StepperItem {
        return item
    }
}
