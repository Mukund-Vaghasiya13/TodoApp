//
//  ApiHnadling.swift
//  TodoApp
//
//  Created by Mukund vaghasiya  on 07/01/24.
//

import Foundation

enum ApiError:Error{
    case invalidUrl
    case EncriptionError
    case RequestError
    case invalidResponse
}

class BackendApi{
    static func PostData<T:Codable>(for:T.Type,url:URL?,Bodydata:[String:String],header:[String:String]?)async throws -> T?{
        guard let url = url else{ throw ApiError.invalidUrl }
        
        var request  = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let header = header{
            for key in header.keys{
                request.setValue(header[key], forHTTPHeaderField: key)
            }
        }
        
        if let BodyData = EncriptData(data:Bodydata){
            request.httpBody = BodyData
        }else{
            throw ApiError.EncriptionError
        }
        
        do{
            let (data,response) = try await URLSession.shared.data(for: request)
            
            guard response is HTTPURLResponse else{throw ApiError.invalidResponse}
            
            if let Response = DecriptData(for: T.self, data: data){
                return Response
            }
            
        }catch{
            throw ApiError.RequestError
        }
        
        return nil
    }
    
    static func GetData<T:Codable>(for:T.Type,accessToken:String,endpoint url:URL?,header:[String:String]?)async throws -> T?{
        guard let usl = url else { throw ApiError.invalidUrl}
        
        var request = URLRequest(url: usl)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        if let header = header{
            for key in header.keys{
                request.setValue(header[key], forHTTPHeaderField: key)
            }
        }
        
        do{
            let (data,response) = try await URLSession.shared.data(for: request)
            guard response is HTTPURLResponse else{throw ApiError.invalidResponse}
            
            if let Response = DecriptData(for: T.self, data: data){
                return Response
            }
            
        }catch{
            throw ApiError.RequestError
        }
        return nil
    }
    
    private static func EncriptData(data:[String:String])->Data?{
        var encriptdata:Data?
        do{
            encriptdata = try JSONEncoder().encode(data)
        }catch{
            print("Fail to Encript Data")
        }
        return encriptdata
    }
    
    private static func DecriptData<T:Codable>(for:T.Type,data:Data)->T?{
        var Response:T?
        do{
            Response = try JSONDecoder().decode(T.self, from: data)
        }catch(let e){
            print(e.localizedDescription)
        }
        
        return Response
    }
}
