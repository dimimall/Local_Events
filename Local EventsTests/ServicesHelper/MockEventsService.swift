//
//  MockEventsService.swift
//  Local EventsTests
//
//  Created by Dimitra Malliarou on 15/1/26.
//

import Foundation
import Local_Events

final class MockEventsService: EventsService {
    func loadEvents(completion: @escaping (Result<[Local_Events.FeedEvent], any Error>) -> Void) {
        completion(result)
    }
    
    var result: Result<[FeedEvent], Error>!
    
}
