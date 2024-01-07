//
//  ContentView.swift
//  TodoApp
//
//  Created by Mukund vaghasiya  on 06/01/24.
//
//

import SwiftUI
import Observation


@Observable class FewApiService{
    var ussername:String = ""
    var password:String = ""
    var Response:Modle?
    
    func CallingApi()async{
        do{
            let data = [
                
                "username":ussername,
                "password":password
            
            ]
           Response =  try await BackendApi.PostData(for: Modle.self, url: URL(string: "http://localhost:3000/api/todo/v1/login"), Bodydata: data, header: nil)
        }catch(ApiError.EncriptionError){
            print("EncriptionError")
        }catch(ApiError.RequestError){
            print("RequestError")
        }catch(ApiError.invalidResponse){
            print("invalidResponse")
        }catch(ApiError.invalidUrl){
            print("invalidUrl")
        }catch{
            print("Other error")
        }
    }
    
}

struct LoginView: View {
    @State var apiservice = FewApiService()
    var body: some View {
        NavigationStack {
            VStack(spacing:30) {
                AuthForm(Username: $apiservice.ussername, Password: $apiservice.password)
                
                Button {
                    Task{
                        await apiservice.CallingApi()
                        if let response = apiservice.Response{
                            print(response.message ?? "nil")
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
                    RegisterUser()
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
