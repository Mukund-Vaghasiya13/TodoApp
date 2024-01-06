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
            VStack {
                AuthForm(Username: $apiservice.ussername, Password: $apiservice.password)
                
                Spacer()
            }.navigationTitle("Login")
            .padding()
        }
    }
}

#Preview {
    LoginView()
}
