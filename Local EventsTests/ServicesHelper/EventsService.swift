//
//  EventsService.swift
//  Local EventsTests
//
//  Created by Dimitra Malliarou on 15/1/26.
//

import Foundation
import Local_Events

protocol EventsService {
    func loadEvents(completion: @escaping (Result<[FeedEvent], Error>) -> Void)
}
