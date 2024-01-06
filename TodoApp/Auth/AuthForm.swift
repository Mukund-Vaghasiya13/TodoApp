//
//  AuthForm.swift
//  TodoApp
//
//  Created by Mukund vaghasiya  on 06/01/24.
//

import SwiftUI

struct AuthForm : View{
    @Binding var Username:String
    @Binding var Password:String
    
    var body: some View{
        VStack(spacing:20){
            TextField("Enter Username",text: $Username)
                .padding(.leading)
                .font(.system(size: 25))
                .frame(width: 300,height: 55)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.black, lineWidth: 2)
                }
            
            SecureField("Enter Password",text: $Password)
                .padding(.leading)
                .font(.system(size: 25))
                .frame(width: 300,height: 55)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.black, lineWidth: 2)
                }
        }
    }
}
