//
//  URLSessionServiceTest.swift
//  Local EventsTests
//
//  Created by Dimitra Malliarou on 16/1/26.
//

import XCTest
import Local_Events

final class URLSessionServiceTest: XCTestCase {

    let json = """
        {
            "resultset": [
                {
                    "eventid": "38527",
                    "simpleViewId": "null",
                    "available": true,
                    "title": "Sleeping Beauty at Nottingham Playhouse",
                    "description": "Prepare to be spellbound as our legendary",
                    "distance": "5889.13",
                    "distanceUnits": "kilometres",
                    "distanceObj": {
                        "value": "5889.13",
                        "unitShort": "km",
                        "unitLong": "Kilometres"
                    },
                                "createdBy": "637278",
                                "status": "Approved",
                                "mediatype": null,
                                "mediaurl": "public/images/maps/sleep60eec18963.jpg",
                                "secondaryimage": null,
                                "url": "https://nottinghamplayhouse.co.uk/events/sleeping-beauty-2/",
                                "latitude": "52.9534500",
                                "longitude": "-1.1561700",
                                "eventcategory": "29",
                                "type": "other",
                                "address": "Wellington Circus,Nottingham,Nottinghamshire,NG1 5AF",
                                "enddate": "2026-01-16 23:59:59",
                                "startdate": "2026-01-16 00:00:00",
                                "starttime": "00:00 am",
                                "endtime": "23:59 pm",
                                "venuename": "Nottingham Playhouse",
                                "venueurl": null,
                                "ticketsurl": "https://nottinghamplayhouse.co.uk/events/sleeping-beauty-2/",
                                "additionalImages": [],
                                "primaryAction": {
                                    "title": "Book Now",
                                    "type": "url",
                                    "value": "https://nottinghamplayhouse.co.uk/events/sleeping-beauty-2/"
                                },
                                "secondaryAction": {
                                    "title": "More Info",
                                    "type": "url",
                                    "value": "https://nottinghamplayhouse.co.uk/events/sleeping-beauty-2/"
                                }
                }
            ]
        }
        """.data(using: .utf8)!

    let jsonEmpty = """
        {
            "resultset": [
            ]
        }
        
    """.data(using: .utf8)!
    
    let jsonError = """
        {
            "resultset": [
                {
                    "eventid": "38527",
                    "simpleViewId": null,
                    "available": true,
                    "title": "Sleeping Beauty at Nottingham Playhouse"
                }
            ]
        }
        
    """.data(using: .utf8)!
    
    // Helpers
    func makeSUT() -> URLSessionService {
        return URLSessionService(session: mockSession)
    }
    
    override func tearDown() {
        super.tearDown()
        MockURLProtocol.resetStub()
    }
    
    // Test Case
    func test_PostResponse_SuccessWithSuccessResponse() async{
        let httpClient = makeSUT()
        let url = dummyURL
        let response = getSuccessResponse(with: url)
        
        MockURLProtocol.stubRequest(response: response, data: json, error: nil)

        let exp = expectation(description: "waiting for completion")
        
        await httpClient.post(from: url){ res in
            switch res {
            case .success(let events):
                XCTAssertEqual(events.count, 1)
            case .failure(let fetchedError):
                XCTFail("Expected success insted get error \(fetchedError.localizedDescription)")
            }
            
            exp.fulfill()
        }
        
        await fulfillment(of: [exp], timeout: 7.0)
        
    }
    
    
    func test_GetResponse_FailedWithError() async {
        let httpClient = makeSUT()
        let url = dummyURL
        let response = getSuccessResponse(with: url)

        MockURLProtocol.stubRequest(response: response, data: jsonError, error: error)
        let exp = expectation(description: "waiting for completion")
        
        await httpClient.post(from: url){ result in
            switch result {
            case .success(let events):
                XCTFail("Expected Failed insted get \(events)")
            case .failure(let fetchedError):
                XCTAssertNotNil((fetchedError as NSError).domain)
                XCTAssertNotNil((fetchedError as NSError).code)
            }
            
            exp.fulfill()
        }
        
        await fulfillment(of: [exp], timeout: 7.0)
        
    }
    
    func test_PostResponse_SuccessWithEmptyData() async {
        let httpClient = makeSUT()
        let url = dummyURL
        let response = getSuccessResponse(with: url)
        let exp = expectation(description: "waiting for completion")
        
        MockURLProtocol.stubRequest(response: response, data: jsonEmpty, error: nil)

        await httpClient.post(from: url) { result in
            switch result {
            case let .success(data):
                XCTAssertEqual(data.count, 0)
            case .failure:
                XCTFail("Expected success insted get \(self.error)")
            }
            
            exp.fulfill()
        }
        
        await fulfillment(of: [exp], timeout: 7.0)

    }
    
    var mockSession: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: configuration)
    }()

    func getSuccessResponse(with url: URL) -> HTTPURLResponse {
        return HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
    }

    let dummyURL = URL(string: "https://dev.loqiva.com/public/service/phonejson/eventslist")!
    let error = NSError(domain: "Error", code: 0)
    
}
