//
//  ListView.swift
//  SmartLists
//
//  Created by Fabio Fiorita on 08/08/22.
//

import SwiftUI

struct ListView: View {
    @StateObject var vm = ObjectViewModel()
    @State private var showingSheet = false
    @State private var content = ""
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.objects, id: \.self) { object in
                    HStack {
                        Text(object.content ?? "")
                        Spacer()
                        Button {
                            vm.increaseAmount(object: object)
                        } label: {
                            Image(systemName: "minus")
                        }
                        Text("\(object.amount)")
                        Button {
                            vm.decreaseAmount(object: object)
                        } label: {
                            Image(systemName: "plus")
                        }
                        
                    }
                }
            }
            .navigationTitle("Lista")
            .toolbar {
                ToolbarItem {
                    Button {
                        showingSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $showingSheet) {
                        NavigationStack {
                            VStack {
                                GroupBox {
                                    TextField("Shirt, Jacket, Sweater...", text: $content)
                                        .font(.title)
                                }
                            }
                            .padding()
                            .navigationTitle("Add New Item")
                            .toolbar {
                                ToolbarItem {
                                    Button {
                                        vm.addObject(content: content)
                                        vm.fetchObjects()
                                        showingSheet.toggle()
                                    } label: {
                                        Text("Save")
                                            .font(.title3)
                                    }
                                }
                            }
                            
                        }
                        .onAppear {
                            content = ""
                        }
                        .presentationDetents([.fraction(0.35)])
                    }
                    
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
