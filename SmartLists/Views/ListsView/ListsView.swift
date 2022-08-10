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
    @State private var showingTitleSheet = false
    @State private var showingTypeSheet = false
    @State private var title = ""
    @State private var listTypes: [ListTypeModel] = [.init(name: "Stepper List", image: "plusminus.circle.fill"), .init(name: "Checkbox List", image: "checkmark.circle.fill"), .init(name: "Plain List", image: "line.3.horizontal.circle.fill")]
    @State private var selectedType = 0
    init(viewContext: NSManagedObjectContext) {
        self.listVM = ListTypeViewModel(viewContext: viewContext)
        self.stepperVM = StepperItemViewModel(viewContext: viewContext)
    }
    var body: some View {
        NavigationStack {
            List {
                ForEach(listVM.lists, id: \.self) { list in
                    NavigationLink {
                        StepperListView(stepperVM: stepperVM, list: list)
                    } label: {
                        Text(list.title ?? "list")
                    }
                }
            }
            .navigationTitle("SmartLists")
            .onAppear {
                listVM.fetchLists()
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        showingTitleSheet.toggle()
                    } label: {
                        Label("Add list", systemImage: "plus")
                    }.sheet(isPresented: $showingTitleSheet) {
                        listVM.fetchLists()
                    } content: {
                        titleSheet
                    }
                    
                }
            }
        }
    }
    
    private var titleSheet: some View {
        VStack {
            Image(systemName: "list.bullet.circle")
                .font(.largeTitle)
            Text("Add New List")
                .font(.largeTitle)
            GroupBox {
                TextField("Shopping, reminders, bills...", text: $title)
            }
            GroupBox {
                Picker("Select List Type", selection: $selectedType) {
                    ForEach(0 ..< 3) {
                        Label(self.listTypes[$0].name, systemImage: self.listTypes[$0].image)
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity)
            }
            Button {
                let _ = listVM.addList(title: title, type: listTypes[selectedType].name)
                showingTitleSheet.toggle()
            } label: {
                Text("Continue")
                    .foregroundColor(.white)
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }
        .foregroundColor(.accentColor)
        .padding()
        .presentationDetents([.fraction(0.5)])
    }
}


struct ListsView_Previews: PreviewProvider {
    static var previews: some View {
        ListsView(viewContext: CoreDataStack.shared.container.viewContext)
    }
}
