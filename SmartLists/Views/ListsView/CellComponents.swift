//
//  CellComponents.swift
//  SmartLists
//
//  Created by Fabio Fiorita on 17/08/22.
//

import SwiftUI

struct ListCellComponents: View {
    @ObservedObject var stepperVM: StepperItemViewModel
    @State var list: ListType
    @State private var newFunc = false
    
    var body: some View {
        NavigationLink {
            if newFunc {
                switch list.type {
                case "Stepper List":
                    StepperListView(stepperVM: stepperVM, list: list)
                default:
                    EmptyView()
                }
            }
            
            
        } label: {
            Text(list.title ?? "list")
        }
    }
}
