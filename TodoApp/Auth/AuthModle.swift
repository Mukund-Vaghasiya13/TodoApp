//
//  AuthModle.swift
//  TodoApp
//
//  Created by Mukund vaghasiya  on 06/01/24.
//

import Foundation
import Observation

struct Modle:Hashable,Codable{
    var data:String?
    var message:String?
    var statuscode:Int?
    var success:Bool?
}

@Observable class FewApiService{
    var ussername:String = ""
    var password:String = ""
    var Response:Modle?
    
    func CallingApi(endpoint url:String)async{
        do{
            let data = [
                
                "username":ussername,
                "password":password
            
            ]
           Response =  try await BackendApi.PostData(for: Modle.self, url: URL(string: url), Bodydata: data, header: nil)
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
