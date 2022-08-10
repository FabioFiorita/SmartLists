//
//  SmartListsApp.swift
//  SmartLists
//
//  Created by Fabio Fiorita on 08/08/22.
//

import SwiftUI

@main
struct SmartListsApp: App {
    let persistenceController = CoreDataStack.shared

    var body: some Scene {
        WindowGroup {
            ListsView(viewContext: persistenceController.container.viewContext)
        }
    }
}
