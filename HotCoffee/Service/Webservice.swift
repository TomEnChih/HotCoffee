//
//  Webservice.swift
//  HotCoffee
//
//  Created by 董恩志 on 2022/2/28.
//

import Foundation

enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

struct Resource<T: Codable> {
    let url: URL
    var httpMethod: HttpMethod = .get
    var body: Data? = nil
}

class Webservice {
    
    func load<A>(resource: Resource<A>, completion: @escaping(Result<A, NetworkError>)-> Void) {
        
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }
            
            if let observedData = try? JSONSerialization.jsonObject(with: data, options: []) {
                print("資料：",observedData)
            }
            
            let result = try? JSONDecoder().decode(A.self, from: data)
            if let result = result {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
                
            } else {
                completion(.failure(.decodingError))
            }
        }
        
        task.resume()
    }
}
