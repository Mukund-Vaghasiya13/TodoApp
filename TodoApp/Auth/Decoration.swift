//
//  Decoration.swift
//  TodoApp
//
//  Created by Mukund vaghasiya  on 06/01/24.
//

import SwiftUI


struct DesignButton:View{
    var text:String
    var body: some View{
        VStack{
            Text(text)
                .foregroundStyle(.white)
                .font(.system(size: 25))
                .fontWeight(.heavy)
                .frame(width: 300,height: 55)
                .background(.black)
                .cornerRadius(10)
        }
        
        
    }
}
