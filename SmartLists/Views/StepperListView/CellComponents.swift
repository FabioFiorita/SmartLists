//
//  CellComponents.swift
//  SmartLists
//
//  Created by Fabio Fiorita on 17/08/22.
//

import SwiftUI

struct CellComponents: View {
    @ObservedObject var stepperVM: StepperItemViewModel
    @State var item: StepperItem
    
    var body: some View {
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

