//
//  TutusTests.swift
//  TutusTests
//
//  Created by Sebastian Guerrero on 11/21/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

//
// MODULES TO TEST:
// *AssignmentClient - getRiskTeam, createAssignment, deleteAssignment, getAssignments
// *LocationClient - createLocation, deleteLocation, getLocations
// *GuestClient - createGuest deleteGuest
// *EventClient - createEvent, createEventUser, getEventById, getUsersById, getEventUsers
// *UserClient - createNewUser, getEventUsersByAuthToken, setMainUserRole
// *SearchGuestListRiskClient - getGuests
// *MenuViewClient - getEventOptions, getEventCount

import XCTest
@testable import Tutus
var currentEvent = ""
var newEvent = ""
var currentEventObject: Event!
var mainUser = UserClient()

class TutusTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        mainUser.dict["id"] = "102396696923318" as AnyObject?
        currentEventObject.id = 
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // create event that is in the future with random string title and set ID (event_user for current user will automatically be set)
        // get the event object using getEventOptions and matching title and then get the ID and use getEventById
        // createEventUser using 345092735093847 auth token and team invite code from that event for that event
        // get user's info using getEventUsersByAuthToken
        // create a location for the event
        // create a guest for the event
        // create an assignment of the main user to the single location
    }
    
    func testExample() {
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // test getEventCount by checking to see if getEventOptions returns the same length array and that the first ID matches its ID
        // test that getUsersById with ID matches getEventUsersByAuthToken's ID
        // test that getEventUsers gives an eventUser with role team and use that ID to get the user and make sure the auth token matches 345092735093847
        // create user using createNewUser and then use getEventUsersByAuthToken and make sure it works and the info matches
        // test that setMainUserRole sets the role as admin for the current user object
        // test that there is a location for the event that has the right info
        // test that getGuests gives you a single guest with the right info
        // test that get risk team gives the eventUser with auth token 345092735093847
        // test that the main user has an assignment at the current location
        
        // delete the assignment and make sure it's gone
        // delete the location for the event and then use getLocationsById to make sure it's gone
        // delete the guest and make sure it's gone
    }
    
    
}
