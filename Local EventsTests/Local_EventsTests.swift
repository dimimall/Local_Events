//
//  Local_EventsTests.swift
//  Local EventsTests
//
//  Created by Dimitra Malliarou on 13/1/26.
//

import XCTest
import Local_Events

final class Local_EventsTests: XCTestCase {

    func test_load_success_withEvents() {
        let mockService = MockEventsService()
        
        mockService.result = .success([FeedEvent.mock])
        
        let viewModel = EventsViewModel(service: mockService)
                
        viewModel.load()
        
        if case .loaded(let events) = viewModel.state {
            XCTAssertEqual(events.count, 1)
        } else {
            XCTFail("Expected loaded state")
        }
    }
    
    func test_load_success_empty() {
        let mockService = MockEventsService()
        mockService.result = .success([])

        let sut = EventsViewModel(service: mockService)

        sut.load()

        if case .empty = sut.state {
            XCTAssertTrue(true)
        } else {
            XCTFail("Expected empty state")
        }
    }
    
    func test_load_failure() {
        let mockService = MockEventsService()
        mockService.result = .failure(NSError(domain: "Test", code: 0))

        let sut = EventsViewModel(service: mockService)

        sut.load()

        if case .error = sut.state {
            XCTAssertTrue(true)
        } else {
            XCTFail("Expected error state")
        }
    }
}
