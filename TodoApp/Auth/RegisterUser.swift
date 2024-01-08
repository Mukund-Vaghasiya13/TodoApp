//
//  RegisterUser.swift
//  TodoApp
//
//  Created by Mukund vaghasiya  on 06/01/24.
//

import SwiftUI

struct RegisterUser : View{
    @AppStorage("Token") var token:String?
    @State var Apiservice = FewApiService()
    @Binding var path:NavigationPath
    var body: some View{
        VStack{
            AuthForm(Username: $Apiservice.ussername, Password: $Apiservice.password)
            Button {
                Task{
                    await Apiservice.CallingApi(endpoint: "http://localhost:3000/api/todo/v1/register")
                    if let response = Apiservice.Response{
                      
                        if response.success ?? false{
                            
                            // calling Again Register with Login
                            
                            await Apiservice.CallingApi(endpoint: "http://localhost:3000/api/todo/v1/login")
                            
                            if let response = Apiservice.Response{
                                if response.success ?? false{
                                    token = response.data ?? nil
                                    path.append(Modle(data: response.data))
                                }
                            }
                            
                        }
                    }else{
                        print("nil")
                    }
                }
            } label: {
               DesignButton(text: "Sinup")
            }
            Spacer()
        }
        .navigationTitle("SinUp")
        .padding()
    }
}
