//
//  ContentView.swift
//  TodoApp
//
//  Created by Mukund vaghasiya  on 06/01/24.
//
//

import SwiftUI

struct LoginView: View {
    @AppStorage("Token") var token:String?
    @State var path = NavigationPath()
    @State var apiservice = FewApiService()
    var body: some View {
        NavigationStack(path: $path) {
            ZStack{
                VStack(spacing:30) {
                    AuthForm(Username: $apiservice.ussername, Password: $apiservice.password)
                    
                    Button {
                        Task{
                            await apiservice.CallingApi(endpoint: "https://todo-xiii.onrender.com/api/todo/v1/login")
                            if let response = apiservice.Response{
                                token = response.data ?? nil
                                path.append(Modle(data:response.data))
                            }else{
                                print("nil")
                            }
                        }
                    } label: {
                        DesignButton(text: "Login")
                    }
                    
                    Text("Or")
                        .font(.system(size: 20))
                        .fontWeight(.heavy)
                    
                    NavigationLink {
                        RegisterUser(path: $path)
                    } label: {
                        DesignButton(text: "Create new User")
                    }
                    
                    
                    Spacer()
                }
            }
            .task {
                if token != nil{
                    path.append(Modle(data: token))
                }
            }
            .navigationDestination(for: Modle.self) { data in
                Home(path: $path, Token: data)
            }
            .navigationTitle("Login")
            .padding()
            
        }
    }
}

#Preview {
    LoginView()
}
