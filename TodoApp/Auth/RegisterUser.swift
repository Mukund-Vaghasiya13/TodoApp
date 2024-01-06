//
//  RegisterUser.swift
//  TodoApp
//
//  Created by Mukund vaghasiya  on 06/01/24.
//

import SwiftUI
import Observation

@Observable class RegisterApiService{
    var ussername:String = ""
    var password:String = ""
}


struct RegisterUser : View{
    @State var Apiservice = RegisterApiService()
    var body: some View{
        VStack{
            AuthForm(Username: $Apiservice.ussername, Password: $Apiservice.password)
            Button {
               
            } label: {
               DesignButton(text: "Sinup")
            }
            Spacer()
        }
        .navigationTitle("SinUp")
        .padding()
    }
}
