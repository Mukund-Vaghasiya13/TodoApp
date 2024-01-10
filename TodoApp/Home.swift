//
//  Home.swift
//  TodoApp
//
//  Created by Mukund vaghasiya  on 07/01/24.
//

import SwiftUI

struct Home: View {
    @Binding var path:NavigationPath
    var Token:Modle?
    
    var TempArray = ["One","Second","Third"]
    var body: some View {
        VStack{
            
//            MARK: Temp
            List(TempArray,id: \.count) { i in
                Text(i)
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
        }.toolbar(content: {
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

