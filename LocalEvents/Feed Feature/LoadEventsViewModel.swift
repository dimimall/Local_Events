//
//  LoadImage.swift
//  Local Events
//
//  Created by Dimitra Malliarou on 13/1/26.
//

import Foundation
import UIKit

class LoadEventsViewModel: EventViewModelProtocol {
    var onEventsCanceled: (() -> Void)?
    
    var events: [FeedEvent] = []

    var onEventsFetched: (() -> Void)?
    
    private let client: URLSessionService
    
    init(client: URLSessionService = URLSessionService()) {
        self.client = client
    }
    
    func loadEvents() {
        
        client.post(from: URL(string: "https://dev.loqiva.com/public/service/phonejson/eventslist")!) { [weak self] result in
            switch result {
                case .success(let data):
                self?.events = data
                DispatchQueue.main.async {
                    self?.onEventsFetched?()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.onEventsCanceled?()
                }
                print("Error fetching events \(error.localizedDescription)")
            }
        }
    }
    
}
