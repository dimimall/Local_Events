//
//  RemoteFeedEvents.swift
//  Local Events
//
//  Created by Dimitra Malliarou on 13/1/26.
//

import Foundation

public struct Root: Codable {
    let resultset: [Item]
    
    var feed: [FeedEvent] {
        return resultset.map(\.item)
    }
}

public struct Item: Codable {
    let eventid: String
    let simpleViewId: String?
    let available: Bool
    let title: String
    let description: String
    let distance: String
    let distanceUnits: String
    let distanceObj: Distance
    let createdBy: String
    let status: String
    let mediatype: String?
    let mediaurl: String?
    let secondaryimage: String?
    let url: String?
    let latitude: String
    let longitude: String
    let eventcategory: String
    let type: String
    let address: String
    let enddate: String
    let startdate: String
    let starttime: String
    let endtime: String
    let venuename: String
    let venueurl: String?
    let ticketsurl: String?
    let additionalImages: [String]
    let primaryAction: ActionJson?
    let secondaryAction: ActionJson?
    
    var item : FeedEvent {
        return FeedEvent(eventid: eventid, simpleViewId: simpleViewId, available: available, title: title, description: description, distance: distance, distanceUnits: distanceUnits, distanceObj: distanceObj.distance, createdBy: createdBy, status: status, mediatype: mediatype, mediaurl: mediaurl, secondaryimage: secondaryimage, url: url ?? "", latitude: latitude, longitude: longitude, eventcategory: eventcategory, type: type, address: address, enddate: enddate, startdate: startdate, starttime: starttime, endtime: endtime, venuename: venuename, venueurl: venueurl, ticketsurl: ticketsurl ?? "", additionalImages: additionalImages, primaryAction: primaryAction?.action ?? Action(title: "", type: "", value: ""), secondaryAction: secondaryAction?.action ?? Action(title: "", type: "", value: ""))
    }
}

public struct Distance: Codable {
    let value: String
    let unitShort: String
    let unitLong: String
    
    var distance: DistanceObj {
        return DistanceObj(value: value, unitShort: unitShort, unitLong: unitLong)
    }
}

public struct ActionJson: Codable {
    let title: String
    let type: String
    let value: String
    
    var action: Action {
        return Action(title: title, type: type, value: value)
    }
}

public extension Item {
    static func convert(event: FeedEvent) -> Item {
        let feedEvent = Item(eventid: event.eventid, simpleViewId: event.simpleViewId, available: event.available, title: event.title, description: event.description, distance: event.distance, distanceUnits: event.distanceUnits, distanceObj: Distance(value: event.distanceObj.value, unitShort: event.distanceObj.unitShort, unitLong: event.distanceObj.unitLong), createdBy: event.createdBy, status: event.status, mediatype: event.mediatype, mediaurl: event.mediaurl, secondaryimage: event.secondaryimage, url: event.url, latitude: event.latitude, longitude: event.longitude, eventcategory: event.eventcategory, type: event.type, address: event.address, enddate: event.enddate, startdate: event.startdate, starttime: event.starttime, endtime: event.endtime, venuename: event.venuename, venueurl: event.venueurl, ticketsurl: event.ticketsurl, additionalImages: event.additionalImages, primaryAction: ActionJson(title: event.primaryAction.title, type: event.primaryAction.type, value: event.primaryAction.value), secondaryAction: ActionJson(title: event.secondaryAction.title, type: event.secondaryAction.type, value: event.secondaryAction.value))
        
        return feedEvent
        
    }

}
