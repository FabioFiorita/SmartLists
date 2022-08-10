//
//  ListView.swift
//  SmartLists
//
//  Created by Fabio Fiorita on 08/08/22.
//

import SwiftUI

struct StepperListView: View {
    @StateObject var vm = StepperItemViewModel(viewContext: CoreDataStack.shared.container.viewContext)
    @State private var showingSheet = false
    @State private var content = ""
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(vm.items, id: \.self) { item in
                        HStack {
                            Text(item.content ?? "")
                                .font(.title3)
                            Spacer()
                            Image(systemName: "minus.circle.fill")
                                .font(.title3)
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    let _ = vm.decreaseAmount(item: item)
                                }
                            Text("\(item.amount)")
                                .font(.title3)
                            Image(systemName: "plus.circle.fill")
                                .font(.title3)
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    let _ = vm.increaseAmount(item: item)
                                }
                            
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                let _ = vm.deleteItem(item: item)
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
                            vm.fetchItems()
                        } content: {
                            NavigationStack {
                                GroupBox {
                                    HStack {
                                        TextField("Apple, banana, orange...", text: $content)
                                        Button {
                                            let _ = vm.addItem(content: content)
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
            .navigationTitle("List")
            .onAppear {
                vm.fetchItems()
            }
        }
    }
}

struct StepperListView_Previews: PreviewProvider {
    static var previews: some View {
        StepperListView()
    }
}
