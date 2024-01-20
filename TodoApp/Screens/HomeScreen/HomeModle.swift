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
    var showalert = false
    var alertMessage:String?
    
    
    
    func GetTodosList(AccessToken:String)async{
        do{
            todoResponse = try await BackendApi.GetData(for: Todo.self, accessToken: AccessToken, endpoint:URL(string: "https://todo-xiii.onrender.com/api/todo/v1/Todos/todo/gettodo"), header: nil)
            
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
    
    func TodoOperation(url:String,data:[String:String],token:String) async{
        do{
            
            let header = [
            
                "Authorization":"Bearer \(token)"
                
            ]
            
            let response = try await BackendApi.PostData(for:Modle.self , url: URL(string: url), Bodydata: data, header: header)
            
            if let response = response{
                if !(response.success ?? false){
                    showalert = true
                    alertMessage = response.message ?? "nil"
                }
            }
            
        }catch(ApiError.EncriptionError){
            print("AddTodo EncriptionError")
        }catch(ApiError.RequestError){
            print("AddTodo RequestError")
        }catch(ApiError.invalidResponse){
            print("AddTodo invalidResponse")
        }catch(ApiError.invalidUrl){
            print("AddTodo invalidUrl")
        }catch{
            print("AddTodo Other error")
        }
    }
    

}


