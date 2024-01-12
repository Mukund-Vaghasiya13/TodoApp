//
//  Home.swift
//  TodoApp
//
//  Created by Mukund vaghasiya  on 07/01/24.
//

import SwiftUI

struct Home: View {
    @State var todHandle:TodoHandle = TodoHandle()
    @Binding var path:NavigationPath
    var Token:Modle?
   
    
    var body: some View {
        VStack{

            TodoList(todHandle: $todHandle, token: Token?.data)
            
        }
        .task {
            if let token = Token?.data{
                await todHandle.GetTodosList(AccessToken: token)
            }else{
                print("error Intoken")
            }
        }
        .toolbar(content: {
            ToolBar(todHandle: $todHandle, token: Token?.data, path: $path)
        })
        .navigationTitle("Home")
        .navigationBarBackButtonHidden()
    }
}



