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
var inviteInfo = [String: String]()


//SPECIAL NOTES:

//the reason why the test are nested is because alot of our testing depended on closures, 
//that would happen at different times, but for testing purposes we do them at the same time.
//Lastly there is like a 5% chance that they might fail because of an asyncronous issue. 
// Essentially our applicaiton uses a couple of global varibles to keep track of the user. 
//So in our test we set that up but because they are happening asychronsly it sometimes doesnt set the user and trying doing other things.
//Please if it fails once tryin running it again.


class TutusTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        //mainUser.dict["id"] = "102396696923318" as AnyObject?
        mainUser.setDictForTesting {
            let locationClient = LocationClient()
            let guestClient = GuestClient()
            let assignmentsClient = AssignmentClient()
            inviteInfo = [:]
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
                inviteInfo["invite"] = currentEventObject.team_invite_code
                eventClient.getEventUsers() { event_users in
                    currentEventObject.event_users = event_users
                    eventClient.setDict(diction: inviteInfo) {
                        
                        // create a guest for the event
                        eventClient.createEventUser(){ dict in
                            
                            locationClient.setDict(diction: ["name": "Test Location", "description" : "Test Location Description", "isEdit": "false"]) {
                                // create a location for the event
                                locationClient.createLocation(){ dict in
                                    
                                    guestClient.setDict(diction: ["name": "Guest Name", "phone": "Guest Phone", "birthdaye": "Guest Birthdate","optionalText": "Guest Andrew ID", "optionalTitle": "Andrew ID", "isEdit": "false"]) {
                                        
                                        guestClient.createGuest(){ dict in
                                            
                                            // get the location info back to get the ID
                                            locationClient.getLocations() { locs in
                                                
                                                globalLocations = locs
                                                // create an assignment of the main user to the single location
                                                assignmentsClient.setDict(diction: ["event_id": String(currentEventObject.id), "location_id": globalLocations[0].id, "user_id": mainUser.dict["id"] as! String, "start": "2017-12-05 15:10:00", "end": "2017-12-06 15:10:00", "attended": "false"]) {
                                                    
                                                    assignmentsClient.createAssignment() { dict in
                                                        
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
        
        
        }
        
    }
    
    func testExample() {
        // test getEventCount by checking to see if getEventOptions returns the same length array and that the first ID matches its ID
        let locationClient = LocationClient()
        var eventCountCount = 0
        var eventOptionsCount = 1
        var firstId = "0"
        var retrievedEvent = [String: String]()
        menuViewClient.getEventCount { count, id in
            eventCountCount = count
            firstId = id
            
            // test that getEventUsers gives an eventUser with role team
            menuViewClient.getEventOptions { events in
                eventOptionsCount = events.count
                for event in events {
                    if event["title"] == eventTitle {
                        retrievedEvent = event
                        XCTAssertEqual(retrievedEvent["id"], firstId)
                        XCTAssertEqual(eventCountCount, eventOptionsCount)
                        
                        // test that there is a location for the event  and there is only one
                        locationClient.getLocations() { locs in
                        
                        }
                    }
                }
            }
        }

        
        
        
        
        // test that getEventUsers gives an eventUser with role team
        eventClient.getEventUsers() { event_users in
            currentEventObject.event_users = event_users
            XCTAssertEqual(currentEventObject.event_users.count, 2)
            XCTAssertEqual(currentEventObject.event_users[0].auth_token, mainUser.dict["id"]! as! String)
            XCTAssertEqual(currentEventObject.event_users[1].auth_token, mainUser.dict["id"]! as! String)
        }
        
        // test that getGuests gives you a single guest with the right info
        let client = SearchGuestListRiskClient()
        var guests = [Guest]()
        client.getGuests { gs in
            guests = gs
            XCTAssertEqual(guests.count, 1)
            XCTAssertEqual(guests[0].name, "Guest Name")
        }

        
        // test that the main user has an assignment at the current location
        let aclient = AssignmentClient()
        var aassignments = [AssignmentLocation]()
        aclient.getAssignments { assignments in
            for assigment in assignments {
                for loc in globalLocations {
                    if assigment.location_id == loc.id {
                        aassignments.append(AssignmentLocation(id: assigment.id, location_name: loc.name, description: loc.description, start: assigment.start, end: assigment.end))
                        XCTAssertEqual(aassignments.count, 1)
                    }
                }
            }
        }

        
    }
    
    
}
