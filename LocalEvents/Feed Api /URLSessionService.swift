//
//  URLSessionHTTPClient.swift
//  Local Events
//
//  Created by Dimitra Malliarou on 13/1/26.
//

import Foundation


public class URLSessionService {
    
    private let session: URLSession
    private var body: Data
    
    
    public init(session: URLSession = .shared) {
        self.session = session
        
        let requestBody = Event(
            rowsPerPage: 100,
            page: 1,
            latitude: 0.0,
            longitude: 0.0,
            categoryId: 0,
            search: ""
        )
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let jsonData = try? encoder.encode(requestBody)
        
        self.body = jsonData ?? Data()
    }
    
    public func post(from url: URL, completion: @escaping (Result<[FeedEvent], Error>) -> Void){
        
        let jsonString = String(data: body, encoding: .utf8)
        print(jsonString!)
        
        print("Url \(url)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = body
        
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                return completion(.failure(error))
            }
            
            if let data = data, let response = response as? HTTPURLResponse{
               guard response.statusCode == 200 else {
                   print("Something is wrong while decoding JSON data. \(response.statusCode)")
                   return completion(.failure(NSError(domain: "InvalidResponse", code: 0)))
               }
               
               DispatchQueue.main.async {
                   do {
                       let root = try JSONDecoder().decode(Root.self, from: data)
                       print("events fetched: \(root.feed.count)")
                       completion(.success(root.feed))
                   } catch {
                       print("Decoding error:", error)
                       completion(.failure(error))
                   }
               }
               
           }
        }.resume()
    }
}
