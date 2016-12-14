//
//  TutusTests.swift
//  TutusTests
//
//  Created by Sebastian Guerrero on 11/21/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

//
// MODULES TO TEST:
// *AssignmentClient - createAssignment, deleteAssignment, getAssignments
// *LocationClient - createLocation, deleteLocation, getLocations
// *GuestClient - createGuest deleteGuest
// *EventClient - createEvent, createEventUser, getEventById, getEventUsers
// *SearchGuestListRiskClient - getGuests
// *MenuViewClient - getEventOptions, getEventCount

import XCTest
@testable import Tutus
import Pods_Tutus
var currentEvent = ""
var newEvent = ""
var currentEventObject: Event!
var mainUser = UserClient()
let menuViewClient = MenuViewClient()
let dateFormatter = DateFormatter()
var eventTitle = ""
let eventClient = EventClient()
var globalLocations: [Location] = []

class TutusTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        mainUser.dict["id"] = "102396696923318" as AnyObject?
        
        // create event that is in the future with random string title and set ID (event_user for current user will automatically be set)
        var eventInfo = [String: String]()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        eventTitle = dateFormatter.string(from: Date())
        eventInfo["title"] = eventTitle
        eventInfo["location"] = "Test Location"
        eventInfo["startTime"] = "2017-12-05 15:10:00"
        eventInfo["endTime"] = "2017-12-06 15:10:00"
        eventInfo["maxInvites"] = "3"
        eventInfo["listOpen"] = "2017-12-02 15:10:00"
        eventInfo["listClose"] = "2017-12-03 15:10:00"
        eventInfo["isEdit"] = String(false)
        eventClient.setDict(diction: eventInfo) {
            eventClient.createEvent(){ dict in
            }
        }
        
        // get the event object using getEventOptions and matching title and then get the ID and use getEventById
        menuViewClient.getEventOptions { events in
            for event in events {
                if event["title"] == eventTitle {
                    currentEventObject.id = event["id"]!
                    currentEvent = event["id"]!
                }
            }
        }
        eventClient.getEventByID() { event in
            currentEventObject = event
            eventClient.getEventUsers() { event_users in
                currentEventObject.event_users = event_users
            }
        }
        
        // createEventUser using team invite code from that event for that event
        var inviteInfo = [String: String]()
        inviteInfo["invite"] = currentEventObject.team_invite_code
        eventClient.setDict(diction: inviteInfo) {
            eventClient.createEventUser(){ dict in
            }
        }
        
        // create a location for the event
        let locationClient = LocationClient()
        var locationInfo = [String: String]()
        locationInfo["name"] = "Test Location"
        locationInfo["description"] = "Test Location Description"
        locationInfo["isEdit"] = String(false)
        locationClient.setDict(diction: locationInfo) {
            locationClient.createLocation(){ dict in
            }
        }
        
        // create a guest for the event
        let guestClient = GuestClient()
        var guestInfo = [String: String]()
        guestInfo["name"] = "Guest Name"
        guestInfo["phone"] = "Guest Phone"
        guestInfo["birthdate"] = "Guest Birthdate"
        guestInfo["optionalText"] = "Guest Andrew ID"
        guestInfo["optionalTitle"] = "Andrew ID"
        guestInfo["isEdit"] = String(false)
        guestClient.setDict(diction: guestInfo) {
            guestClient.createGuest(){ dict in
            }
        }
        
        // get the location info back to get the ID
        locationClient.getLocations() { locs in
            globalLocations = locs
        }
        
        // create an assignment of the main user to the single location
        let assignmentsClient = AssignmentClient()
        var assignmentsInfo = [String: [String: String]]()
        assignmentsInfo["Test Assignment"] = ["event_id": String(currentEventObject.id), "location_id": globalLocations[0].id, "user_id": mainUser.dict["id"] as! String, "start": "2017-12-05 15:10:00", "end": "2017-12-06 15:10:00", "attended": "false"]
        assignmentsClient.setDict(diction: assignmentsInfo["Test Assignment"]!) {
            assignmentsClient.createAssignment() { dict in
            }
        }
    }
    
    func testExample() {
        // test getEventCount by checking to see if getEventOptions returns the same length array and that the first ID matches its ID
        var eventCountCount = 0
        var eventOptionsCount = 1
        var firstId = "0"
        var retrievedEvent = [String: String]()
        menuViewClient.getEventCount { count, id in
            eventCountCount = count
            firstId = id
        }
        menuViewClient.getEventOptions { events in
            eventOptionsCount = events.count
            for event in events {
                if event["title"] == eventTitle {
                    retrievedEvent = event
                }
            }
        }
        XCTAssertEqual(retrievedEvent["id"], firstId)
        XCTAssertEqual(eventCountCount, eventOptionsCount)
        
        // test that getEventUsers gives an eventUser with role team
        eventClient.getEventUsers() { event_users in
            currentEventObject.event_users = event_users
        }
        XCTAssertEqual(currentEventObject.event_users.count, 2)
        XCTAssertEqual(currentEventObject.event_users[0].id, mainUser.dict["id"])
        XCTAssertEqual(currentEventObject.event_users[1].id, mainUser.dict["id"])
        
        // test that there is a location for the event  and there is only one
        XCTAssertEqual(globalLocations.count, 1)
        
        // test that getGuests gives you a single guest with the right info
        let client = SearchGuestListRiskClient()
        var guests = [Guest]()
        client.getGuests { gs in
            guests = gs
        }
        XCTAssertEqual(guests.count, 1)
        XCTAssertEqual(guests[0].name, "Guest Name")
        
        // test that the main user has an assignment at the current location
        let aclient = AssignmentClient()
        var aassignments = [AssignmentLocation]()
        aclient.getAssignments { assignments in
            for assigment in assignments {
                for loc in globalLocations {
                    if assigment.location_id == loc.id {
                        aassignments.append(AssignmentLocation(id: assigment.id, location_name: loc.name, description: loc.description, start: assigment.start, end: assigment.end))
                    }
                }
            }
        }
        XCTAssertEqual(aassignments.count, 1)

        // delete the assignment and make sure it's gone (DO WE NEED TO TEST THIS???)
        
        // delete the location for the event and then use getLocationsById to make sure it's gone (DO WE NEED TO TEST THIS???)
        
        // delete the guest and make sure it's gone (DO WE NEED TO TEST THIS???)
        
    }
    
    
}
