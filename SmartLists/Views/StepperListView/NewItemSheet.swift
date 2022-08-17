//
//  NewItemSheet.swift
//  SmartLists
//
//  Created by Fabio Fiorita on 17/08/22.
//

import SwiftUI

struct NewItemSheet: View {
    @ObservedObject var stepperVM: StepperItemViewModel
    @State private var content = ""
    @State var showingSheet: Bool
    @State var list: ListType
    
    var body: some View {
        Button {
            showingSheet.toggle()
        } label: {
            Label("New item", systemImage: "plus.circle.fill")
                .labelStyle(.titleAndIcon)
        }
        .buttonStyle(.borderedProminent)
        .sheet(isPresented: $showingSheet) {
            let _ = stepperVM.fetchItems()
        } content: {
            NavigationStack {
                GroupBox {
                    HStack {
                        TextField("Apple, banana, orange...", text: $content)
                        Button {
                            let _ = stepperVM.addItem(content: content, listType: list)
                            showingSheet.toggle()
                        } label: {
                            Text("Save")
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                .padding()
                .navigationTitle("Add new item")
            }
            .presentationDetents([.fraction(0.3)])
        }
    }
}
