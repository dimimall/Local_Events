//
//  FeedEvents.swift
//  Local Events
//
//  Created by Dimitra Malliarou on 13/1/26.
//

import Foundation

public struct FeedEvent: Hashable {
    let eventid: String
    let simpleViewId: String?
    let available: Bool
    let title: String
    let description: String
    let distance: String
    let distanceUnits: String
    let distanceObj: DistanceObj
    let createdBy: String
    let status: String
    let mediatype: String?
    let mediaurl: String?
    let secondaryimage: String?
    let url: String
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
    let ticketsurl: String
    let additionalImages: [String]
    let primaryAction: Action
    let secondaryAction: Action
}

struct DistanceObj: Hashable {
    let value: String
    let unitShort: String
    let unitLong: String
}

struct Action: Hashable {
    let title: String
    let type: String
    let value: String
}

// For testing only

public extension FeedEvent {
    static let mock = FeedEvent(
        eventid: "1",
        simpleViewId: nil,
        available: true,
        title: "Test Event",
        description: "Test Event Description",
        distance: "10",
        distanceUnits: "km",
        distanceObj: DistanceObj(value: "10", unitShort: "km", unitLong: "kilometers"),
        createdBy: "1",
        status: "active",
        mediatype: nil,
        mediaurl: nil,
        secondaryimage: nil,
        url: "https://www.google.com",
        latitude: "37.7749° N, 122.4194° W",
        longitude: "37.7749° N, 122.4194° W",
        eventcategory: "1",
        type: "1",
        address: "1 Infinite Loop, Cupertino, CA 95014, USA",
        enddate: "2026-01-26",
        startdate: "2026-01-26",
        starttime: "12:00",
        endtime: "18:00",
        venuename: "Googleplex",
        venueurl: "",
        ticketsurl: "https://www.google.com/events/detail/Test+Event/20260126T120000Z/",
        additionalImages: ["https://via.placeholder.com/150"],
        primaryAction: Action(title: "Primary Action", type: "url", value: "https://www.google.com/events/detail/Test+Event/20260126T120000Z/"),
        secondaryAction: Action(title: "Secondary Action", type: "url", value: "https://www.google.com/events/detail/Test+Event/20260126T120000Z/"))
}
