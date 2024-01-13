//
//  HomeUtils.swift
//  TodoApp
//
//  Created by Mukund vaghasiya  on 12/01/24.
//

import SwiftUI

struct TodoList:View {
    
    @Binding var todHandle:TodoHandle
    var token:String?
    @State var todo = ""
    @State var ShowAlert = false
    var body: some View {
        if let data = todHandle.todoResponse?.data{
            List(data,id:\._id) { i in
                Text(i.todo ?? "nil")
                    .alert("Add todo", isPresented: $ShowAlert) {
                        TextField("Enter changes", text: $todo)
                        Button("Update") {
                            Task{
                                if let token = token{
                                    let data = [
                                        "todo":todo,
                                        "TodoID":i._id ?? ""
                                    ]
                                    await todHandle.TodoOperation(url: "http://localhost:3000/api/todo/v1/Todos/todo/update", data: data, token: token)
                                }else{
                                    print("tool bar Problem in Login Token")
                                }
                            }
                        }
                        .bold()
                        .font(.system(size: 20))
                    }
                    .swipeActions(content:{
                        Button(action: {
                            
                            Task{
                                let data = [
                                
                                    "TodoID":i._id ?? "nil"
                                
                                ]
                                if let token = token{
                                    await todHandle.TodoOperation(url: "http://localhost:3000/api/todo/v1/Todos/todo/delete", data: data, token: token)
                                }else{
                                    print("tool bar Problem in Login Token")
                                }
                            }
                            
                        }, label: {
                            Text("Delete")
                                .fontWeight(.heavy)
                        })
                        .tint(.red)
                        
                        Button(action: {
                            ShowAlert = true
                            print("Working")
                        }, label: {
                            Text("Edit")
                                .bold()
                        })
                        .tint(.blue)
                       
                    })
                
            }.refreshable {
                Task{
                    if let token = token{
                        await todHandle.GetTodosList(AccessToken: token)
                    }else{
                        print("List Problem in Login Token")
                    }
                }
            }
            
        }else{
            List{
                Text("Enter Data Or Nil")
            }
        }
    }
}

struct ToolBar:View {
    @Binding var todHandle:TodoHandle
    var token:String?
    @State var TodoValueAlert = false
    @State var todo = ""
    @Binding var path:NavigationPath
    var body: some View {
        HStack{
            Button {
               TodoValueAlert = true
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .renderingMode(.original)
                    .foregroundStyle(.red)
                    .frame(width: 20)
                    
            }.alert("Add todo", isPresented: $TodoValueAlert) {
                TextField("Enter Todo", text:$todo)
                
                Button("Add") {
                    Task{
                        if let token = token{
                            let data = [
                               "todo":todo
                            ]
                            await todHandle.TodoOperation(url: "http://localhost:3000/api/todo/v1/Todos/todo/add", data: data, token: token)
                        }else{
                            print("tool bar Problem in Login Token")
                        }
                    }
                }
                .bold()
                .font(.system(size: 20))
            }
            
            Spacer()
            
            Button(action: {
                UserDefaults.standard.removeObject(forKey: "Token")
                path.removeLast(path.count)
            }, label: {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .resizable()
                    .renderingMode(.original)
                    .frame(width: 20)
                    .foregroundStyle(.black)
            })
            
        }
    }
}
