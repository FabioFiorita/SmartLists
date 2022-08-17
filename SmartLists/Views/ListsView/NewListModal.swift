//
//  NewListModal.swift
//  SmartLists
//
//  Created by Fabio Fiorita on 17/08/22.
//

import SwiftUI

struct NewListModal: View {
    @State private var listTypes: [ListTypeModel] = [
        .init(name: "Stepper List", image: "plusminus.circle.fill"),
        .init(name: "Checkbox List", image: "checkmark.circle.fill"),
        .init(name: "Plain List", image: "line.3.horizontal.circle.fill")
    ]
    @State private var selectedType = 0
    @State private var title = ""
    @State var showingModal: Bool
    @ObservedObject var listVM: ListTypeViewModel
    var body: some View {
        Button {
            showingModal.toggle()
        } label: {
            Label("New list", systemImage: "plus.circle.fill")
                .labelStyle(.titleAndIcon)
        }
        .buttonStyle(.borderedProminent)
        .sheet(isPresented: $showingModal) {
            let _ = listVM.fetchLists()
        } content: {
            NavigationStack {
                Form {
                    Section {
                        TextField("Shopping, reminders, bills...", text: $title)
                    }
                    Section {
                        Picker("Select List Type", selection: $selectedType) {
                            ForEach(0 ..< 3) {
                                Label(self.listTypes[$0].name, systemImage: self.listTypes[$0].image)
                            }
                        }
                        switch selectedType {
                        case 0:
                            Text("Stepper list is a list that contains buttons to increase and decrease a value")
                        case 1:
                            Text("Checkbox list is a list that contains a checkbox")
                        case 2:
                            Text("Plain list is a list that is plain")
                        default:
                            Text("")
                        }
                    }
                }
                .navigationTitle("New list")
                .onAppear {
                    title = ""
                }
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            let _ = listVM.addList(title: title, type: listTypes[selectedType].name)
                            showingModal.toggle()
                        } label: {
                            Text("Save")
                                .foregroundColor(.white)
                                .frame(minWidth: 0, maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
        }
    }
}

