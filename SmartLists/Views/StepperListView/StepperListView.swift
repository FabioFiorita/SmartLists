//
//  ListView.swift
//  SmartLists
//
//  Created by Fabio Fiorita on 08/08/22.
//

import SwiftUI

struct StepperListView: View {
    @ObservedObject var stepperVM: StepperItemViewModel
    @State private var showingSheet = false
    @State private var content = ""
    @State var list: ListType
    var body: some View {
        NavigationStack {
            List {
                ForEach(stepperVM.items, id: \.self) { item in
                    if item.listType == list {
                        CellComponents(stepperVM: stepperVM, item: item)
                    }
                }
            }
            .navigationTitle(list.title ?? "List")
            .onAppear {
                let _ = stepperVM.fetchItems()
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Spacer()
                }
                ToolbarItem(placement: .bottomBar) {
                    NewItemSheet(stepperVM: stepperVM, content: content, showingSheet: showingSheet, list: list)
                }
            }
        }
        
    }
}

struct StepperListView_Previews: PreviewProvider {
    static var previews: some View {
        StepperListView(stepperVM: StepperItemViewModel(viewContext: CoreDataStack.shared.container.viewContext), list: ListType())
    }
}
