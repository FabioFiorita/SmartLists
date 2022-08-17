//
//  ListsView.swift
//  SmartLists
//
//  Created by Fabio Fiorita on 10/08/22.
//

import SwiftUI
import CoreData

struct ListsView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @ObservedObject var listVM: ListTypeViewModel
    @ObservedObject var stepperVM: StepperItemViewModel
    @State private var showingModal = false
    
    init(viewContext: NSManagedObjectContext) {
        self.listVM = ListTypeViewModel(viewContext: viewContext)
        self.stepperVM = StepperItemViewModel(viewContext: viewContext)
    }
    var body: some View {
        NavigationStack {
            List {
                ForEach(listVM.lists, id: \.self) { list in
                    ListCellComponents(listVM: listVM, stepperVM: stepperVM, list: list)
                }
            }
            .navigationTitle("SmartLists")
            .onAppear {
                let _ = listVM.fetchLists()
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Spacer()
                }
                ToolbarItem(placement: .bottomBar) {
                    NewListModal(showingModal: showingModal, listVM: listVM)
                }
            }
        }
    }
}


struct ListsView_Previews: PreviewProvider {
    static var previews: some View {
        ListsView(viewContext: CoreDataStack.shared.container.viewContext)
    }
}
