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
    var body: some View {
        VStack{
            Button(action: {
                UserDefaults.standard.removeObject(forKey: "Token")
                path.removeLast(path.count)
            }, label: {
               DesignButton(text: "Logout")
            })
        }
        .navigationTitle("Home")
        .navigationBarBackButtonHidden()
    }
}

