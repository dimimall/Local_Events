//
//  EventsViewModel.swift
//  Local EventsTests
//
//  Created by Dimitra Malliarou on 15/1/26.
//

import Foundation
import Local_Events

class EventsViewModel {
    
    enum State {
        case loaded([FeedEvent])
        case empty
        case error(String)
    }
    
    private let service: EventsService
    private(set) var state: State = .empty
    
    init(service: EventsService) {
        self.service = service
    }
    
    func load() {
        service.loadEvents { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let events):
                self.state = events.isEmpty ? .empty : .loaded(events)
            case .failure(let error):
                self.state = .error(error.localizedDescription)
            }
        }
    }
}
