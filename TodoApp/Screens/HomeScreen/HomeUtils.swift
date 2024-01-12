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
    var body: some View {
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
                            await todHandle.AddTodo(todo:todo,token:token)
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
