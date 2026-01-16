//
//  EventLoader.swift
//  Local Events
//
//  Created by Dimitra Malliarou on 13/1/26.
//

import Foundation

public protocol EventLoader {
    typealias Result = Swift.Result<[FeedEvent], Error>

    func load(completion: @escaping (Result) -> Void)
}
