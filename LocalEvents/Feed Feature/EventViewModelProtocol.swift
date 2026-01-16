//
//  UserViewModelProtocol.swift
//  Local Events
//
//  Created by Dimitra Malliarou on 14/1/26.
//

import Foundation


protocol EventViewModelProtocol {
    var events: [FeedEvent] { get }
    var onEventsFetched: (() -> Void)? { get set }
    var onEventsCanceled: (() -> Void)? { get set }
    func loadEvents()
}
