//
//  ListView.swift
//  SmartLists
//
//  Created by Fabio Fiorita on 08/08/22.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        NavigationStack {
            List {
                Text("A")
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
