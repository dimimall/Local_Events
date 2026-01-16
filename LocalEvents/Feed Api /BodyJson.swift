//
//  BodyJson.swift
//  Local Events
//
//  Created by Dimitra Malliarou on 13/1/26.
//

import Foundation


struct Event: Encodable {
    let rowsPerPage: Int
    let page: Int
    let latitude: Double
    let longitude: Double
    let categoryId: Int?
    let search: String
    
    enum CodingKeys: String, CodingKey {
        case rowsPerPage, page, latitude, longitude, categoryId, search
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(rowsPerPage, forKey: .rowsPerPage)
        try container.encode(page, forKey: .page)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        
        if categoryId == nil {
            try container.encodeNil(forKey: .categoryId)
        } else {
            try container.encode(categoryId, forKey: .categoryId)
        }
        
        try container.encode(search, forKey: .search)
    }
}

