//
//  EventsAPIService.swift
//  Local EventsTests
//
//  Created by Dimitra Malliarou on 15/1/26.
//

import Foundation
import Local_Events

class EventsAPIService: EventsService {
    
    let services: URLSessionService
    
    init(services: URLSessionService) {
        self.services = services
    }
    
    func loadEvents(completion: @escaping (Result<[FeedEvent], Error>) -> Void) {
        services.post(from: URL(string:"")!) { results in
            switch results {
            case .success(let events):
                completion(.success(events))
            case .failure(let error):
                print("Error fetching events \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    
}
