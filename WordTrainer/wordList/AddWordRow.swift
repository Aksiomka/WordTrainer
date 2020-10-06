//
//  AddWordRow.swift
//  WordTrainer
//
//  Created by Svetlana Gladysheva on 26.06.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation
import SwiftUI

struct AddWordRow : View {
    
    var addWordButtonTappedCallback: () -> Void = {}
    
    var body: some View {
        Button(action: {
            self.addWordButtonTappedCallback()
        }) {
            HStack {
                Image("plus")
                .foregroundColor(.blue)
                Text("Add Word")
                    .foregroundColor(.blue)
            }.padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
        }
    }
}

struct AddWordRow_Previews: PreviewProvider {
    static var previews: some View {
        AddWordRow()
    }
}
