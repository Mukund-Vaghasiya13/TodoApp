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
//            MARK: Temp
            
            if let data = todHandle.todoResponse?.data{
                List(data,id:\._id) { i in
                    Text(i.todo ?? "nil")
                        .swipeActions(content:{
                            Button(action: {
                                
                            }, label: {
                                Text("Delete")
                            })
                            Button(action: {
                                
                            }, label: {
                                Text("Edit")
                            })
                            .tint(.orange)
                        })
                    
                }
            }else{
                List{
                    Text("Enter Data Or Nil")
                }
            }
            
        }
        .task {
            if let token = Token?.data{
                await todHandle.GetTodosList(AccessToken: token)
            }else{
                print("error Intoken")
            }
        }
        .toolbar(content: {
            Button(action: {
                UserDefaults.standard.removeObject(forKey: "Token")
                path.removeLast(path.count)
            }, label: {
                Text("Logout")
            })
        })
        .navigationTitle("Home")
        .navigationBarBackButtonHidden()
    }
}

