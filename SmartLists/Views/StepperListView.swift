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
            ZStack {
                List {
                    ForEach(stepperVM.items, id: \.self) { item in
                        HStack {
                            Text(item.content ?? "")
                                .font(.title3)
                            Spacer()
                            Image(systemName: "minus.circle.fill")
                                .font(.title3)
                                .foregroundColor(.accentColor)
                                .onTapGesture {
                                    let _ = stepperVM.decreaseAmount(item: item)
                                }
                            Text("\(item.amount)")
                                .font(.title3)
                            Image(systemName: "plus.circle.fill")
                                .font(.title3)
                                .foregroundColor(.accentColor)
                                .onTapGesture {
                                    let _ = stepperVM.increaseAmount(item: item)
                                }
                            
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                let _ = stepperVM.deleteItem(item: item)
                            } label: {
                                Text("Delete")
                            }
                        }
                    }
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            showingSheet.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .font(.largeTitle)
                        }
                        .sheet(isPresented: $showingSheet) {
                            let _ = stepperVM.fetchItems(forList: list)
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
                .padding()
            }
            .navigationTitle(list.title ?? "List")
            .onAppear {
                let _ = stepperVM.fetchItems(forList: list)
            }
        }
    }
}

struct StepperListView_Previews: PreviewProvider {
    static var previews: some View {
        StepperListView(stepperVM: StepperItemViewModel(viewContext: CoreDataStack.shared.container.viewContext), list: ListType())
    }
}
