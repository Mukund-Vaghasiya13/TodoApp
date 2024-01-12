//
//  HomeModle.swift
//  TodoApp
//
//  Created by Mukund vaghasiya  on 12/01/24.
//

import Foundation
import Observation

struct DataTodo:Codable{
    var _id:String?
    var refId:String?
    var todo:String?
}

struct Todo:Codable{
    var data:[DataTodo]?
    var message:String?
    var statuscode:Int?
    var success:Bool?
}

@Observable class TodoHandle{
    var todoResponse:Todo?
    
    
    func GetTodosList(AccessToken:String)async{
        do{
            todoResponse = try await BackendApi.GetData(for: Todo.self, accessToken: AccessToken, endpoint:URL(string: "http://localhost:3000/api/todo/v1/Todos/todo/gettodo"), header: nil)
            
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


