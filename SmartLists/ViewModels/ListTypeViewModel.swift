//
//  ListTypeViewModel.swift
//  SmartLists
//
//  Created by Fabio Fiorita on 10/08/22.
//

import Foundation
import CoreData

final class ListTypeViewModel: ObservableObject {
    @Published var lists: [ListType] = []
    private var viewContext: NSManagedObjectContext
    
    public init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }
    
    func fetchLists() -> [ListType] {
        let request = NSFetchRequest<ListType>(entityName: "ListType")
        do {
            lists = try viewContext.fetch(request)
            return lists
        } catch {
            print("Error Fetching. \(error)")
            return []
        }
    }
    
    func saveData() {
        do {
            try viewContext.save()
            let _ = fetchLists()
        } catch {
            print("Error saving. \(error)")
        }
    }
    
    func addList(title: String, type: String) -> ListType {
        let newList = ListType(context: viewContext)
        newList.id = UUID()
        newList.title = title
        newList.type = type
        saveData()
        return newList
    }
    
    func deleteList(list: ListType) {
        viewContext.delete(list)
        saveData()
    }
    
    func updateList(list: ListType) -> ListType {
        return list
    }
}
