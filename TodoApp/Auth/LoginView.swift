//
//  ContentView.swift
//  TodoApp
//
//  Created by Mukund vaghasiya  on 06/01/24.
//

import SwiftUI
import Observation


@Observable class FewApiService{
    var ussername:String = ""
    var password:String = ""
}

struct LoginView: View {
    @State var apiservice = FewApiService()
    var body: some View {
        NavigationStack {
            VStack(spacing:30) {
                AuthForm(Username: $apiservice.ussername, Password: $apiservice.password)
                
                Button {
                   
                } label: {
                   DesignButton(text: "Login")
                }
                
                Text("Or")
                    .font(.system(size: 20))
                    .fontWeight(.heavy)
                
                NavigationLink {
                    
                } label: {
                    DesignButton(text: "Create new User")
                }

                
                Spacer()
            }.navigationTitle("Login")
            .padding()
        }
    }
}

#Preview {
    LoginView()
}
