//
//  CheckBoxView.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 31/01/24.
//

import SwiftUI

struct CheckBoxView: View {
    @Binding var checked: Bool
    
    
    var body: some View {
        
        Image(systemName: checked ? "checkmark.square.fill" : "square")
            .foregroundColor(checked ? Color(UIColor.azulMedio) : Color.secondary)
                   .onTapGesture {
                       self.checked.toggle()
                   }
    }
}

struct CheckBoxView_Previews: PreviewProvider {
    struct CheckBoxViewHolder: View {
        @State var checked = false

        var body: some View {
            CheckBoxView(checked: $checked)
        }
    }
    
    static var previews: some View {
         CheckBoxViewHolder()
     }
 }
